from django.shortcuts import render
from django.db.models import JSONField
from rest_framework.views import APIView
from rest_framework import status

from django_q.tasks import async_task

from problem.models import Problem
from submission.models import Submission, SubmissionVerdict, SubmissionLanguage
from submission.models import JudgeSubmissionTask
from judgeserver.models import JudgeServer, JudgeServerStatus
from submission.serializers import SubmissionSerializer

from accounts.decorators import login_required, admin_required, super_admin_required

from time import sleep
from json import loads, dumps
import sys

from utils.make_response import *
from utils.query_set_rearrange import auto_apply 

import asyncio, websockets

class SubmissionAPI(APIView):
    """
    List all problems
    """
    def get(self, request, format=None):
        subs = Submission.objects.all()
        subs = auto_apply(subs, request)
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


    
