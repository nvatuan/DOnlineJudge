from django.db import models
from accounts.models import User
from utils.validators import lowerAlphanumeric
from utils.file_upload import FileUploadUtils
from donlinejudge.settings import MEDIA_ROOT

import os, sys

class ProblemDifficulty(object):
    HARD = "Hard"
    MEDIUM = "Medium"
    EASY = "Easy"
    DIFF = [EASY, MEDIUM, HARD]
    CHOICES = [(EASY, EASY), (MEDIUM, MEDIUM), (HARD, HARD)]

class ProblemTag(models.Model):
    tag_name = models.TextField()

    class Meta:
        db_table = "problemtag"

    def __str__(self):
        if self.tag_name: return self.tag_name
        return None


class Problem(models.Model):
    display_id = models.CharField(db_index=True, unique=True, max_length=64, validators=[lowerAlphanumeric])
    created = models.DateTimeField(auto_now_add=True)
    is_visible = models.BooleanField(default=True, null=True)

    author = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

    #== Content to be displayed
    title = models.TextField()
    statement = models.TextField() ## TODO RichTextField support

    #== Tag, Difficulty, Source
    difficulty = models.CharField(choices=ProblemDifficulty.CHOICES, max_length=50, default=ProblemDifficulty.EASY)
    tags = models.ManyToManyField(ProblemTag)
    source = models.TextField(null=True)

    sample_test = models.JSONField(default=dict, null=True, blank=True)
    ### [{input: "hello", output: "world"}, {input: "i am", output: "django"}]

    #== The Problem tests location
    test_zip = models.FileField(
        default=None, null=True, blank=True,
        upload_to=FileUploadUtils().upload_to_path_and_rename('tests/', False)
    )

    #== Problem constraints
    time_limit = models.IntegerField(default=1000)      ## millisecond
    memory_limit = models.IntegerField(default=256)    ## MB

    #== Statistics
    total_submission = models.BigIntegerField(default=0)
    correct_submission = models.BigIntegerField(default=0)
    statistic_info = models.JSONField(default=dict)
    ### {_.ACCEPTED: 5, _.WRONG_ANSWER: 4, ...}

    #-- Method fields
    def set_tags_to(self, newTags):
        # Remove old tag that isn't in new tags
        for oldTag in self.tags.all():
            if not oldTag.tag_name in newTags:
                self.tags.remove(oldTag)
                if len(ProblemTag.objects.get(id=oldTag.id).problem_set.all())==0:
                    oldTag.delete()

        # Add new tags
        for item in newTags:
            item = item.lower()
            try:
                tag = ProblemTag.objects.get(tag_name=item)
            except ProblemTag.DoesNotExist:
                tag = ProblemTag.objects.create(tag_name=item)
        for item in newTags:
            tag = ProblemTag.objects.get(tag_name=item)
            self.tags.add(tag)

    def remove_test_zip(self):
        if self.test_zip:
            try:
                if os.path.exists(self.test_zip.path):
                    os.remove(self.test_zip.path)
            except:
                pass
            self.test_zip = None
            self.save()

    def std_test_zip_name(self):
        return 'tests/'+str(self.id)+'.zip'
    def std_test_zip_path(self):
        return os.path.join(
            os.path.abspath(MEDIA_ROOT),
            self.std_test_zip_name(),
        )

    def rename_testzip_to_pk(self):
        if self.test_zip:
            if self.test_zip.name != self.std_test_zip_name():
                try:
                    if os.path.exists(self.test_zip.path):
                        if os.path.exists(self.std_test_zip_path()):
                            os.remove(self.std_test_zip_path())
                        os.rename(self.test_zip.path, self.std_test_zip_path())
                        self.test_zip.name = self.std_test_zip_name()
                        self.save()
                    else:
                        self.test_zip = None
                        self.save()
                except:
                    e = sys.exc_info()[0]
                    print(e)
                    raise

    def update_stat_remove_submission(self, sub):
        try:
            if sub.problem.id != self.id: return
            self.statistic_info[sub.verdict] = max(self.statistic_info.get(sub.verdict, 0) - 1, 0)
            self.total_submission = max(self.total_submission-1, 0)

            #if sub.verdict == SubmissionVerdict.AC: # circular import problem
            if sub.verdict == "Accepted": # TODO Fix import issue and Use the above line
                 self.correct_submission = max(
                    self.correct_submission-1, 0
                 )
        except:
            # TODO handle exception for Problem.submission_got_rejected
            pass
    
    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        #self.rename_testzip_to_pk() # dont need

    #--- Author
    def author_id(self):
        if self.author:
            return self.author.id
        return None

    def author_name(self):
        if self.author:
            return self.author.username
        return None

    class Meta:
        db_table = "problem"
        ordering = ["-id"]
    
    def __str__(self):
        return f"Disp_id[{self.display_id}] Title[{self.title}]"
