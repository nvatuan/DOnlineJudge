from django.db import models
from accounts.models import User
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
    SKIPPED = "Skipped" 

    VERDICTS = [AC, WA, TLE, MLE, RE, CE, SE]

    ACCEPTED_VERDICTS = [AC]
    NOT_ACCEPTED_VERDICTS = [WA, TLE, MLE, RE]

    NOT_YET_VERDICTS = [NEW, WAIT, JUDGE, SKIPPED]

    CHOICES = [
        ("AC", AC), ("WA", WA), ("TLE", TLE),
        ("MLE", MLE), ("RE", RE), ("CE", CE),
        ("SE", SE), ("WAIT", WAIT), ("JUDGE", JUDGE), ("NEW", NEW)
    ]

    def _get_default_dict():
        d = {}
        for v in SubmissionVerdict.VERDICTS:
            d[v] = 0
        return d

class SubmissionLanguage:
    LANG = ["PyPy3", "Python3", "Python2", "Java", "C", "Cpp"]
    DEFAULT = LANG[0]
    CHOICES = [
        ("Python3", LANG[0]), 
        ("Python2", LANG[1]), 
        ("Java", LANG[2]), 
        ("C", LANG[3]), 
        ("Cpp", LANG[4])
    ]

class Submission(models.Model):
    problem = models.ForeignKey(Problem, on_delete=models.CASCADE, null=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

    submit_time = models.DateTimeField(auto_now_add=True)

    content = models.TextField(null=True)
    language = models.CharField(choices=SubmissionLanguage.CHOICES, max_length=50, default=SubmissionLanguage.LANG[0])

    verdict = models.CharField(choices=SubmissionVerdict.CHOICES, max_length=20, default=SubmissionVerdict.NEW)
    output = models.JSONField(default=dict)
    ### [{input: "asdf", output: "xyz"}, ...]

    def problem_id(self):
        return self.problem.id

    def author_id(self):
        return self.author.id

    def problem_disp_id(self):
        return self.problem.display_id

    def problem_title(self):
        return Problem.objects.get(id=self.problem.id).title

    def author_name(self):
        return User.objects.get(id=self.author.id).username

    class Meta:
        db_table = "submission"
        ordering = ["id", "submit_time"]

