from django.shortcuts import render
from django.db.models import JSONField

from problem.models import Problem, ProblemTag
from problem.models import ProblemDifficulty

from submission.models import SubmissionVerdict
from problem.serializers import ProblemSerializer

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status


class ProblemAPI(APIView):
    """
    List all problems
    """
    def get(self, request, format=None):
        probs = Problem.objects.all()
        seris = ProblemSerializer(probs, many=True)
        return Response(seris.data)

class ProblemDetailAPI(APIView):
    """
    List a specific problem
    """
    def get(self, request, id):
        try:
            problem = Problem.objects.get(display_id=id)
        except Problem.DoesNotExist:
            return Response("Problem does not exist.", status=status.HTTP_400_BAD_REQUEST)
        
        ## TODO delete testset directory
        return Response(ProblemSerializer(problem).data)

    
