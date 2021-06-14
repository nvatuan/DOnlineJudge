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


class JudgeSubmissionTask:
    """
        Represents a Task to send to DjangoQ worker - A task is to compile, run and extract results
    """
    __name__ = 'JudgeSubmissionTask'
    def __init__(self, sub : Submission, prob: Problem):
        self.sub = sub
        self.prob = prob
        self.jserver = None

        # Prepping kwargs
        src = self.sub.content
        lang = self.sub.language
        tests = []
        for kv in self.prob.sample_test:       
            tests.append((kv["input"], kv["output"]))

        self.kwargs = {'source':src,'processor':lang,'tests':tests,'config':{}}

    async def send_and_receive(self):
        uri = "ws://" + self.jserver.socketaddress
        async with websockets.connect(uri) as websocket:
            await websocket.send(dumps(self.kwargs))

            judge_results, compile_result = (loads(await websocket.recv()))

            self.sub.output = {
                "sample_test": [],
                "test": [],
                "compile_message": compile_result,
                "time": 0,
                "memory": 0,
            }
            self.sub.verdict = SubmissionVerdict.AC

            maxtime, maxmem = 0, 0 
            ## Sample tests
            for i, jres in enumerate(judge_results):
                test_verdict = jres[0]
                if self.sub.verdict == SubmissionVerdict.AC and test_verdict != self.sub.verdict:
                    self.sub.verdict = test_verdict
                
                maxtime = max(maxtime, float(jres[2]))
                maxmem  = max(maxmem, int(jres[3]))
                
                self.sub.output["sample_test"].append(
                    {
                        "test_id": i,
                        "verdict": test_verdict,
                        "stdout": jres[1][0],
                        "stderr": jres[1][1],
                        "cpu time": jres[2],
                        "memory used": jres[3]
                    }
                )
            
            ## TODO Handle hidden tests
            ## Update stats
            self.sub.output["time"] = maxtime
            self.sub.output["memory"] = maxmem
        
        return True

    @staticmethod
    def assign_judge_server():
        candidates = [cand for cand in JudgeServer.objects.all() if cand.status() == JudgeServerStatus.NORMAL]

        chose, priority = None, -1 
        for cand in candidates:
            cand_priority = cand.max_pending_tasks - cand.pending_tasks
            if cand_priority > priority:
                chose = cand
                priority = cand_priority

        return chose 

    def main(self):
        try:
            self.sub.verdict = SubmissionVerdict.WAIT
            self.sub.save()

            counter=0
            self.jserver = JudgeSubmissionTask.assign_judge_server()
            while self.jserver is None:
                sleep(1)
                if counter > 10:
                    self.sub.verdict = SubmissionVerdict.SKIPPED
                    return
                else:
                    counter += 1
                self.jserver = JudgeSubmissionTask.assign_judge_server()
            ##
            self.sub.verdict = SubmissionVerdict.JUDGE
            self.sub.save()
            self.jserver.pending_tasks += 1
            self.jserver.save()
            asyncio.get_event_loop().run_until_complete(self.send_and_receive())
        except:
            self.sub.verdict = SubmissionVerdict.SE
            raise
        finally:
            self.prob.statistic_info[self.sub.verdict] = self.prob.statistic_info.get(self.sub.verdict, 0) + 1
            self.prob.save()
            if self.jserver != None:
                self.jserver.pending_tasks -= 1
                self.jserver.save()
            self.sub.save()

    def hook(self, task):
        if self.sub.verdict in [SubmissionVerdict.WAIT, SubmissionVerdict.NEW]: 
            self.sub.verdict = SubmissionVerdict.SE
            self.sub.save()
        
        m2m_solved = self.sub.author.solved_problem
        if self.sub.verdict in SubmissionVerdict.ACCEPTED_VERDICTS:
            m2m_solved.add(self.prob)
