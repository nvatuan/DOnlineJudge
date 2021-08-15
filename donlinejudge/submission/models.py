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
    REJECT = "Rejected"

    NEW = "New"
    WAIT = "Waiting"
    JUDGE = "Judging"
    REJUDGE = "Rejudging"
    SKIPPED = "Skipped" 

    VERDICTS = [AC, WA, TLE, MLE, RE, CE, SE, REJECT]

    ACCEPTED_VERDICTS = [AC]
    NOT_ACCEPTED_VERDICTS = [WA, TLE, MLE, RE, REJECT]

    NOT_YET_VERDICTS = [NEW, WAIT, JUDGE, REJUDGE, SKIPPED]

    CHOICES = [
        ("AC", AC), ("WA", WA), ("TLE", TLE),
        ("MLE", MLE), ("RE", RE), ("CE", CE), ("REJECT", REJECT),
        ("SE", SE), ("WAIT", WAIT), ("JUDGE", JUDGE), ("REJUDGE", REJUDGE), ("NEW", NEW)
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

    verdict = models.CharField(choices=SubmissionVerdict.CHOICES, max_length=128, default=SubmissionVerdict.NEW)
    output = models.JSONField(default=dict)
    time = models.IntegerField(null=True)
    memory = models.IntegerField(null=True)

    def is_visible(self):
        return self.problem.is_visible

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

    ## Methods
    def set_fields_rejudge(self):
        self.verdict = SubmissionVerdict.REJUDGE
        self.time=None
        self.time=None
        self.output={}

    def revoke_and_update_solved_problems(self):
        if self.verdict == SubmissionVerdict.AC:
            remain_ac_sub_set = Submission.objects.filter(author=self.author).filter(problem=self.problem).filter(verdict=SubmissionVerdict.AC)
            try:
                if len(remain_ac_sub_set) == 1:
                    self.author.solved_problem.remove(self.problem)
                    self.author.save()
            except:
                pass

    def set_fields_reject(self):
        self.revoke_and_update_solved_problems()
        self.verdict = SubmissionVerdict.REJECT
        self.save()
    
    def set_fields_delete(self):
        self.revoke_and_update_solved_problems()

    class Meta:
        db_table = "submission"
        ordering = ["id", "submit_time"]

