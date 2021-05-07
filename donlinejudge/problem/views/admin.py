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
    def get(self, request, format=None):
        probs = Problem.objects.all()
        seris = ProblemSerializer(probs, many=True)
        return Response(seris.data)
    
    def post(self, request, format=None):
        data = request.data
        ## TODO get request user

        try:
            ## Display ID
            disp_id = data["display_id"]
            if not disp_id:
                return Response({"display_id": "is required."}, status=status.HTTP_400_BAD_REQUEST)
            if Problem.objects.filter(display_id=disp_id).exists():
                return Response({"display_id": ""+disp_id+" has already exists."}, status=status.HTTP_400_BAD_REQUEST)
        
            ## Tags, Difficulty, Source
            tags = data.pop("tags")
            if not tags:
                return Response({"tags": "is required."}, status=status.HTTP_400_BAD_REQUEST)
            if type(tags) != list:
                return Response({"tags": "should be a list."}, status=status.HTTP_400_BAD_REQUEST)

            for item in tags:
                try:
                    tag = ProblemTag.objects.get(tagName=item)
                except ProblemTag.DoesNotExist:
                    tag = ProblemTag.objects.create(tagName=item)
            
            data["difficulty"] = data.get("difficulty", "easy")
            if data["difficulty"] not in ProblemDifficulty.DIFF:
                data["difficulty"] = ProblemDifficulty.easy
        
            ## Testdir
            data["testset_dir"] = disp_id
            data["testset_count"] = data.get("testset_count", 0)
            if data["testset_count"] < 0: data["testset_count"]=0

            ## Constaints
            ## Statistics
            data["statistic_info"] = SubmissionVerdict._get_default_dict()

            ## == Create object
            problem = Problem.objects.create(**data)
            for item in tags:
                tag = ProblemTag.objects.get(tagName=item)
                problem.tags.add(tag)

            return Response(ProblemSerializer(problem).data, status=status.HTTP_201_CREATED)
        except KeyError as ke:
            return Response({str(ke): "is required."}, status=status.HTTP_400_BAD_REQUEST)

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
    
    """
    Update a problem
    """
    def put(self, request, id):

        try:
            problem = Problem.objects.get(display_id=id)
        except Problem.DoesNotExist:
            return Response("Problem does not exist.", status=status.HTTP_400_BAD_REQUEST)
        data = request.data

        ## TODO get request user
        ## TODO permission all, own

        #== Content to be displayed
        if data.get("title") != None:
            problem.title = data.get("title")
        if data.get("statement") != None:
            problem.statement = data.get("statement") 

        ## Tags, Difficulty, Source
        if data.get("tags") != None:
            tags = data["tags"]
            if type(tags) != list:
                return Response({"tags": "should be a list."}, status=status.HTTP_400_BAD_REQUEST)
            else:
                for item in tags:
                    try:
                        tag = ProblemTag.objects.get(tagName=item)
                    except ProblemTag.DoesNotExist:
                        tag = ProblemTag.objects.create(tagName=item)
            
            problem.tags.clear()
            for item in tags:
                problem.tags.add(ProblemTag.objects.get(tagName=item))

        if data.get("difficulty") != None:
            dif = data.get("difficulty")
            if dif not in ProblemDifficulty.DIFF:
                dif = ProblemDifficulty.easy
            problem.difficulty = dif
    
        ## Testdir
        if data.get("testset_count") != None:
            tscount = data.get("testset_count", 0)
            if tscount < 0: tscount = 0
            problem.testset_count = tscount

        ## Constaints
        if data.get("time_limit") != None:
            tlmit = data.get("time_limit", 1000)
            if tlmit < 0: tlmit = 1000
            problem.time_limit = tlmit 

        if data.get("memory_limit") != None:
            mlimit = data.get("memory_limit", 256)
            if mlimit < 0: mlimit = 256
            problem.memory_limit = mlimit

        
        return Response(ProblemSerializer(problem).data, status=status.HTTP_202_ACCEPTED)

    
    """
    Delete a problem
    """
    def delete(self, request, id):
        ## TODO permission all, own
        try:
            problem = Problem.objects.get(display_id=id)
        except Problem.DoesNotExist:
            return Response("Problem does not exist.", status=status.HTTP_400_BAD_REQUEST)
        
        ## TODO delete testset directory
        problem.delete()
        return Response({"Xoa thanh cong."}, status=status.HTTP_204_NO_CONTENT)
