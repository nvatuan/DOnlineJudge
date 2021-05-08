from django.shortcuts import render
from django.db.models import JSONField

from problem.models import Problem, ProblemTag
from problem.models import ProblemDifficulty

from problem.serializers import ProblemSerializer

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status


class ProblemAPI(APIView):
    """
    Get a list of Problem
    """
    def get(self, request, format=None):
        probs = Problem.objects.all()
        seris = ProblemSerializer(probs, many=True)
        return Response(seris.data)


class ProblemDetailAPI(APIView):
    """
    View a specific problem
    """
    def get(self, request, id):
        try:
            problem = Problem.objects.get(id=id)
        except Problem.DoesNotExist:
            return Response("Problem does not exist.", status=status.HTTP_404_NOT_FOUND)
        
        return Response(ProblemSerializer(problem).data)
    