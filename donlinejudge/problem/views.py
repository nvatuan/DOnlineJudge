from django.shortcuts import render

# Create your views here.
from django.http import Http404

from problem.models import Problem, ProblemTag
from problem.serializers import ProblemSerializer

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status


class ProblemList(APIView):
    """
    List all problems, or create a new problem
    """
    def get(self, request, format=None):
        probs = Problem.objects.all()
        seris = ProblemSerializer(probs, many=True)
        return Response(seris.data)
    
    def post(self, request, format=None):
        data = request.data
        disp_id = data["display_id"]
        if not disp_id:
            return Response({"display_id": "is required."}, status=status.HTTP_400_BAD_REQUEST)

        if Problem.objects.filter(display_id=disp_id).exists():
            return Response({"display_id": ""+disp_id+" has already exists."}, status=status.HTTP_400_BAD_REQUEST)

        tags = data.pop("tags")
        problem = Problem.objects.create(**data)

        for item in tags:
            try:
                tag = ProblemTag.objects.get(tagName=item)
            except ProblemTag.DoesNotExist:
                tag = ProblemTag.objects.create(tagName=item)
            problem.tags.add(tag)

        return Response(ProblemSerializer(problem).data, status=status.HTTP_201_CREATED)

