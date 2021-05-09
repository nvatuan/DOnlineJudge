from django.shortcuts import render
from django.db.models import JSONField

from problem.models import Problem, ProblemTag
from problem.models import ProblemDifficulty

from problem.serializers import ProblemSerializer

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from utils.make_response import response_bad_request, response_created, response_no_content, response_not_found, response_ok

class ProblemAPI(APIView):
    """
    Get all problem
    """
    def get(self, request, format=None):
        probs = Problem.objects.all()
        seris = ProblemSerializer(probs, many=True)
        return response_ok(seris.data)

class ProblemDetailAPI(APIView):
    """
    Get a specific problem
    """
    def get(self, request, id):
        try:
            problem = Problem.objects.get(id=id)
        except Problem.DoesNotExist:
            return response_not_found("Problem with id=%s does not exist." % str(id))
        
        ## TODO delete testset directory
        return response_ok(ProblemSerializer(problem).data)
    
class ProblemTagAPI(APIView):
    """
    Get all tags
    """
    def get(self, request, format=None):
        probs = Problem.objects.all()
        seris = ProblemSerializer(probs, many=True)
        return response_ok(seris.data)

class ProblemTagDetailAPI(APIView):
    """
    Get a specific tag 
    """
    def get(self, request, id):
        try:
            tag = ProblemTag.objects.get(id=id)
        except ProblemTag.DoesNotExist:
            return response_not_found("Tag with id=%s does not exist." % str(id))
        
        ## TODO delete testset directory
        return response_ok(ProblemTagSerializer(tag).data)