from django.db import models
from utils.models import JSONField

class ProblemDifficulty(object):
    Hard = "Hard"
    Medium = "Medium"
    Easy = "Easy"

class ProblemTag(models.Model):
    tagName = models.TextField()


class Problem(models.Model):
    _id = models.TextField(db_index=True)
    created = models.DateTimeField(auto_now_add=True)
    visible = models.BooleanField()

    # author = models.OneToOneField()
    author = models.TextField()

    #== Content to be displayed
    title = models.TextField()
    statement = models.TextField() ## TODO RichTextField support

    #== Tag, Difficulty, Source
    difficulty = models.TextField()
    tags = models.ManyToManyField(ProblemTag)
    source = models.TextField(null=True)

    sample_test = JSONField()
    ### [{input: "hello", output: "world"}, {input: "i am", output: "django"}]

    #== The Problem tests location
    testset_dir = models.TextField()
    testset_count = models.PositiveIntegerField()

    #== Problem constraints
    time_limit = models.IntegerField()      ## millisecond
    memory_limit = models.IntegerField()    ## MB


    #== Statistics
    total_submission = models.BigIntegerField(default=0)
    correct_submission = models.BigIntegerField(default=0)
    statistic_info = JSONField()
    ### {_.ACCEPTED: 5, _.WRONG_ANSWER: 4, ...}

    class Meta:
        db_table = "problem"
        ordering = ["created"]

