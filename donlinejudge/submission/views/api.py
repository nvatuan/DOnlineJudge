from django.shortcuts import render
from django.db.models import JSONField, Q
from rest_framework.views import APIView
from rest_framework import status

from django_q.tasks import async_task

from problem.models import Problem
from submission.models import Submission, SubmissionVerdict, SubmissionLanguage
from judgeserver.models import JudgeServer, JudgeServerStatus
from submission.serializers import SubmissionSerializer

from accounts.decorators import login_required, admin_required, super_admin_required

from time import sleep
from json import loads, dumps
import sys

from utils.make_response import *
import utils.serialized_data_rearrange as sdr
from utils.pagination import paginate
from utils.test_zip import TestZipHandler

import asyncio, websockets

class SubmissionAPI(APIView):
    serializer_class = SubmissionSerializer
    """
    List all problems
    """
    def get(self, request, format=None):
        subs=None
        try:
            if request.user.is_authenticated: 
                if (request.user.is_admin_role() or request.user.can_mgmt_all_problem()):
                    subs = Submission.objects.all()
                else: 
                    visible_problem = Problem.objects.filter(
                        Q(is_visible=True) | Q(author=request.user)
                    )
                    subs = Submission.objects.filter(problem__in=visible_problem)
            else:
                public_problem = Problem.objects.filter(is_visible=True)
                subs = Submission.objects.filter(problem__in=public_problem)
        except Exception as e:
            return response_bad_request("Request denied. ({})".format(e))

        subsdata = SubmissionSerializer(subs, many=True).data
        subsdata = sdr.auto_apply(subsdata, request)
        subsdata = paginate(subsdata, request)
        return response_ok(subsdata)


    """
    An user make a submission
    """
    @login_required
    def post(self, request, format=None):
        data = request.data
        ## TODO limit the amount of submission an user can make

        try:
            ## Problem ID
            prob_id = data["problem_id"]
            if not prob_id:
                raise KeyError("problem_id")
            if not Problem.objects.filter(id=prob_id).exists():
                return response_not_found("Problem with id=%s does not exist." % str(id))
        
            ## Author ID
            data["author"] = request.user

            ## Compile Language
            lang = data.get("language", SubmissionLanguage.DEFAULT)
            if not lang in SubmissionLanguage.LANG:
                return response_bad_request("Lang '"+lang+"': is not supported.")
            data["language"] = lang

            ## Content
            src = data["content"]
            if not src: 
                raise KeyError("content")

            ## == Create object
            submission = Submission.objects.create(**data)
            problem = Problem.objects.get(id=prob_id)
            jstask = JudgeSubmissionTask(submission, problem)

            async_task(jstask.main, hook=jstask.hook, ack_failure=True)

            return response_created(SubmissionSerializer(submission).data)
        except KeyError as ke:
            return response_bad_request(str(ke) + " is required.")
        # except: # TODO Uncomment these
        #     return response_bad_request("Something went wrong.")

class SubmissionDetailAPI(APIView):
    """
		Get a specific submission
    """
    def get(self, request, id):
        try:
            submission = Submission.objects.get(id=id)
            if not submission.is_visible():
                if request.user.is_authenticated and ((not request.user.is_admin_role()) or (request.user != submission.author)):
                    return response_unauthorized("This submission cannot be viewed")
                else:
                    return response_unauthorized("This submission cannot be viewed")
        except Submission.DoesNotExist:
            return response_not_found("Submission does not exist.")
        
        ## TODO delete testset directory
        return response_ok(SubmissionSerializer(submission).data)
	
    """
		Delete a submission 
    """
    @super_admin_required
    def delete(self, request, id):
        ## TODO permission all, own
        try:
            submission = Submission.objects.get(id=id)
        except Submission.DoesNotExist:
            return response_not_found("Submission with id=%s does not exist." % (str(id)))
        
        submission.delete()
        return response_no_content("Delete succesful")

class JudgeSubmissionTask:
    """
        Represents a Task to send to DjangoQ worker - A task is to compile, run and extract results
    """
    __name__ = 'JudgeSubmissionTask'
    def __init__(self, sub : Submission, prob: Problem):
        self.sub = sub
        self.prob = prob
        self.jserver = None
        self.sample_test_count = 0

        # Prepping kwargs
        src = self.sub.content
        lang = self.sub.language

        tests = []
        ## Appending sample tests
        for kv in self.prob.sample_test:       
            tests.append((kv["input"], kv["output"]))
        self.sample_test_count = len(tests)

        ## Appending actual tests
        if self.prob.test_zip.name: # Problem has hidden tests
            tzh = TestZipHandler(self.prob.test_zip.path)
            hidden_tests = tzh.get_testdata()
            for fin, fout in hidden_tests:
                #if not fin.endswith(b'\n'):
                #    fin += b'\n'
                #if not fout.endswith(b'\n'):
                #    fout += b'\n'
                tests.append((fin, fout))

        self.kwargs = {'source':src,'processor':lang,'tests':tests,'config':{}}

    async def send_and_receive(self):
        uri = "ws://" + self.jserver.socketaddress
        async with websockets.connect(uri) as websocket:
            await websocket.send(dumps(self.kwargs))

            judge_results, compile_result = (loads(await websocket.recv()))

            self.sub.output = {
                "sample_test": [],
                "hidden_test": [],
                "compile_message": compile_result,
                "time": 0,
                "memory": 0,
            }
            self.sub.verdict = SubmissionVerdict.AC

            maxtime, maxmem = 0, 0 
            ## Sample tests
            for i in range(self.sample_test_count):
                jres = judge_results[i]
                #
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
            
            ## Hidden tests
            for i in range(self.sample_test_count, len(judge_results)):
                jres = judge_results[i]

                test_verdict = jres[0]
                if self.sub.verdict == SubmissionVerdict.AC and test_verdict != self.sub.verdict:
                    self.sub.verdict = test_verdict
                
                maxtime = max(maxtime, float(jres[2]))
                maxmem  = max(maxmem, int(jres[3]))
                
                self.sub.output["hidden_test"].append(
                    {
                        "test_id": i,
                        "verdict": test_verdict,
                        #"stdout": jres[1][0],
                        #"stderr": jres[1][1],
                        "cpu time": jres[2],
                        "memory used": jres[3]
                    }
                )

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
    
