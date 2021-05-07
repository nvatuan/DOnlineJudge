from django.db import models
from django.contrib.auth.models import User
from problem.models import Problem

# Create your models here.
class SubmissionVerdict:
    AC = "Accepted"
    WA = "Wrong Answer"
    TLE = "Time Limit Exceeded"
    MLE = "Memory Limit Exceeded"
    RE = "Runtime Error"
    CE = "Compile Error"
    SE = "System Error"
    NEW = "New"
    WAIT = "Waiting"
    JUDGE = "Judging"

    VERDICTS = [AC, WA, TLE, MLE, RE, CE, SE]
    CHOICES = [
        ("AC", AC), ("WA", WA), ("TLE", TLE),
        ("MLE", MLE), ("RE", RE), ("CE", CE),
        ("SE", SE), ("WAIT", WAIT), ("JUDGE", JUDGE), ("NEW", NEW)
    ]

    def _get_default_dict():
        d = {}
        for v in SubmissionVerdict.VERDICTS:
            d[v[0]] = 0
        return d

class Submission(models.Model):
    problem = models.ForeignKey(Problem, on_delete=models.CASCADE, null=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    submit_time = models.DateTimeField(auto_now_add=True)
    verdict = models.CharField(choices=SubmissionVerdict.CHOICES, max_length=20, default=SubmissionVerdict.NEW)
    output = models.BinaryField(null=True)
    judge_comment = models.CharField(max_length=255)