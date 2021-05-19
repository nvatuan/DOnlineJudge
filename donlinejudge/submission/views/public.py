from django.shortcuts import render
from django.db.models import JSONField

from problem.models import Problem

from submission.models import Submission, SubmissionVerdict, SubmissionLanguage
from submission.serializers import SubmissionSerializer

from judgeserver.models import JudgeServer, JudgeServerStatus

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from accounts.decorators import login_required

from django_q.tasks import async_task

from time import sleep
from json import loads, dumps
import sys

from utils.make_response import *

import asyncio, websockets
class JudgeSubmissionTask:
    def __init__(self, sub : Submission, prob: Problem):
        self.sub = sub
        self.prob = prob

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

            res = []
            res.append(loads(await websocket.recv()))
            res.append(loads(await websocket.recv()))
            res.append(loads(await websocket.recv()))

            self.sub.verdict = "Judged"
            self.sub.output = res 
        return True

    @staticmethod
    def assign_judge_server():
        for jserver in JudgeServer.objects.all():
            if jserver.status() == JudgeServerStatus.NORMAL:
                return jserver
        return None
    
    def main(self):
        try:
            self.sub.verdict = "Pending"
            self.sub.save()

            counter=0
            self.jserver = JudgeSubmissionTask.assign_judge_server()
            while self.jserver is None:
                self.jserver = JudgeSubmissionTask.assign_judge_server()
                sleep(1)
                if counter > 10:
                    self.sub.verdict = "Skipped"
                    return
                else:
                    counter += 1
            ##
            asyncio.get_event_loop().run_until_complete(self.send_and_receive())
        except:
            self.sub.verdict = "System Error"
            raise
        finally:
            self.sub.save()


class SubmissionAPI(APIView):
    """
    List all problems
    """
    def get(self, request, format=None):
        subs = Submission.objects.all()
        seris = SubmissionSerializer(subs, many=True)
        return response_ok(seris.data)

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

            async_task(jstask.main)

            return response_created(SubmissionSerializer(submission).data)
        except KeyError as ke:
            return response_bad_request(str(ke) + " is required.")
        # except: # TODO Uncomment these
        #     return response_bad_request("Something went wrong.")

class SubmissionDetailAPI(APIView):
    """
    List a specific submission
    """
    def get(self, request, id):
        try:
            submission = Submission.objects.get(id=id)
        except Submission.DoesNotExist:
            return response_not_found("Submission does not exist.")
        
        ## TODO delete testset directory
        return response_ok(SubmissionSerializer(submission).data)

    
