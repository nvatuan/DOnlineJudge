from django.shortcuts import render
from django.db.models import JSONField

from problem.models import Problem
from submission.models import Submission, SubmissionVerdict, SubmissionLanguage
from submission.serializers import SubmissionSerializer

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from accounts.decorators import login_required

from django_q.tasks import async_task

from utils.make_response import *
import sys

class JudgeSubmissionTask:
    def __init__(self, sub : Submission, prob: Problem):
        self.sub = sub
        self.prob = prob
    
    def judge_and_update(self):
        src = self.sub.content
        lang = self.sub.language

        inputs = []
        answers = []

        for kv in self.prob.sample_test:       
            inputs.append(kv["input"])
            answers.append(kv["output"])

        from .coderunner import send_submission_multi_test
        try:
            judge_result = send_submission_multi_test(src, lang, inputs, answers)
            self.sub.verdict = judge_result.pop("verdict")
            self.sub.output = judge_result
            self.sub.save()
        except:
            self.sub.verdict = "System Error"
            self.sub.save()
            raise
        return True

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
    #@login_required
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
            ## TODO get request.user
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

            async_task(jstask.judge_and_update)

            return response_created(SubmissionSerializer(submission).data)
        except KeyError as ke:
            return response_bad_request(str(ke) + " is required.")
        # except: 
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

    
