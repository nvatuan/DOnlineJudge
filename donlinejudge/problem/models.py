from django.db import models
from accounts.models import User

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
    display_id = models.TextField(db_index=True)
    created = models.DateTimeField(auto_now_add=True)
    visible = models.BooleanField(default=True, null=True)

    author = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

    #== Content to be displayed
    title = models.TextField()
    statement = models.TextField() ## TODO RichTextField support

    #== Tag, Difficulty, Source
    difficulty = models.CharField(choices=ProblemDifficulty.CHOICES, max_length=50, default=ProblemDifficulty.EASY)
    tags = models.ManyToManyField(ProblemTag)
    source = models.TextField(null=True)

    sample_test = models.JSONField(default=dict, null=True)
    ### [{input: "hello", output: "world"}, {input: "i am", output: "django"}]

    #== The Problem tests location
    testset_dir = models.TextField(null=True)
    testset_count = models.PositiveIntegerField(default=0)

    #== Problem constraints
    time_limit = models.IntegerField(default=1000)      ## millisecond
    memory_limit = models.IntegerField(default=256)    ## MB


    #== Statistics
    total_submission = models.BigIntegerField(default=0)
    correct_submission = models.BigIntegerField(default=0)
    statistic_info = models.JSONField(default=dict)
    ### {_.ACCEPTED: 5, _.WRONG_ANSWER: 4, ...}

    #-- Method fields
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
        ordering = ["created"]
    
    def __str__(self):
        return f"Disp_id[{self.display_id}] Title[{self.title}]"
