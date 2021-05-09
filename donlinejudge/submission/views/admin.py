from django.shortcuts import render
from django.db.models import JSONField

from submission.models import Submission, SubmissionVerdict
from submission.serializers import SubmissionSerializer

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from accounts.decorators import login_required, super_admin_required

from utils.make_response import *
import sys

class SubmissionAPI(APIView):
    """
    Get a list of Submission
    """
    def get(self, request, format=None):
        probs = Submission.objects.all()
        seris = SubmissionSerializer(probs, many=True)
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
            content = data["content"]
            if not content: 
                raise KeyError("content")

            ## == Create object
            submission = Submission.objects.create(**data)

            ## TODO Judge the submission and change update its verdict and output

            return response_created(SubmissionSerializer(submission).data)
        except KeyError as ke:
            return response_bad_request(str(ke) + " is required.")
        # except: 
        #     return response_bad_request("Something went wrong.")


class SubmissionDetailAPI(APIView):
    """
    View a specific problem
    """
    def get(self, request, id):
        try:
            submission = Submission.objects.get(id=id)
        except Submission.DoesNotExist:
            return response_not_found("Submission with id=%s does not exist." % (str(id)))
        
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
