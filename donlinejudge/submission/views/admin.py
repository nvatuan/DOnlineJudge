from django.shortcuts import render
from django.db.models import JSONField

from submission.models import Submission, SubmissionVerdict
from submission.serializers import SubmissionSerializer

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

import sys

class SubmissionAPI(APIView):
    """
    Get a list of Submission
    """
    def get(self, request, format=None):
        probs = Submission.objects.all()
        seris = SubmissionSerializer(probs, many=True)
        return Response(seris.data)
    
    """
    An user make a submission
    """
    def post(self, request, format=None):
        data = request.data
        ## TODO get request user
        ## TODO limit the amount of submission an user can make

        try:
            ## Problem ID
            prob_id = data["problem_id"]
            if not prob_id:
                return Response({"prob_id": "is required."}, status=status.HTTP_400_BAD_REQUEST)
            if not Problem.objects.filter(id=prob_id).exists():
                return Response({"Problem does not exists."}, status=status.HTTP_404_NOT_FOUND)
        
            ## Author ID
            ## TODO get request.user

            ## Compile Language
            lang = data.get("language", SubmissionLanguage.DEFAULT)
            if not lang in SubmissionLanguage.LANG:
                return Response({"Lang '"+lang+"'": " is not supported."}, status=status.HTTP_400_BAD_REQUEST)
            data["language"] = lang

            ## == Create object
            submission = Submission.objects.create(**data)

            ## TODO Judge the submission and change update its verdict and output

            return Response(SubmissionSerializer(submission).data, status=status.HTTP_201_CREATED)
        except KeyError as ke:
            return Response({str(ke): "is required."}, status=status.HTTP_400_BAD_REQUEST)
        except: 
            return Response({"Something went wrong!\n"+sys.exc_info()[0]}, status=status.HTTP_400_BAD_REQUEST)


class SubmissionDetailAPI(APIView):
    """
    View a specific problem
    """
    def get(self, request, id):
        try:
            submission = Submisson.objects.get(id=id)
        except Submission.DoesNotExist:
            return Response("Submission does not exist.", status=status.HTTP_404_NOT_FOUND)
        
        return Response(SubmissionSerializer(submission).data)
    
    """
    Delete a submission 
    """
    def delete(self, request, id):
        ## TODO permission all, own
        try:
            submission = Submisson.objects.get(id=id)
        except Submission.DoesNotExist:
            return Response("Submission does not exist.", status=status.HTTP_404_NOT_FOUND)
        
        submission.delete()
        return Response({"Xoa thanh cong."}, status=status.HTTP_204_NO_CONTENT)
