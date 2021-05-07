from django.db import models
from django.contrib.auth.models import User
from problem.models import Problem

# Create your models here.

class Submission(models.Model):
    problem = models.ForeignKey(Problem, on_delete=models.CASCADE, null=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    submit_time = models.DateTimeField(auto_now_add=True)
    verdict_code = models.IntegerField(null=True)
    output = models.BinaryField(null=True)
    judge_comment = models.CharField(max_length=255)