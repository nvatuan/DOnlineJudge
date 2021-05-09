from django.shortcuts import render
from django.db.models import JSONField

from problem.models import Problem, ProblemTag
from problem.models import ProblemDifficulty

from submission.models import SubmissionVerdict
from problem.serializers import ProblemSerializer

from rest_framework.views import APIView

from accounts.decorators import admin_required, super_admin_required
from utils.make_response import *

class ProblemAPI(APIView):
    def get(self, request, format=None):
        probs = Problem.objects.all()
        seris = ProblemSerializer(probs, many=True)
        return response_ok(seris.data)
    
    @admin_required
    def post(self, request, format=None):
        resperror = ""
        respdata = ""

        data = request.data

        try:
            ## Display ID
            disp_id = data["display_id"]
            if not disp_id:
                raise KeyError("display_id")
            if Problem.objects.filter(display_id=disp_id).exists():
                return response_bad_request("Problem with display_id=%s already exists" % disp_id)
        
            ## Tags, Difficulty, Source
            tags = data.pop("tags")
            if not tags:
                raise KeyError("tags")
            if type(tags) != list:
                return response_bad_request("'tags' should be a list.")

            for item in tags:
                try:
                    tag = ProblemTag.objects.get(tagName=item)
                except ProblemTag.DoesNotExist:
                    tag = ProblemTag.objects.create(tagName=item)
            
            data["difficulty"] = data.get("difficulty", "easy")
            if data["difficulty"] not in ProblemDifficulty.DIFF:
                data["difficulty"] = ProblemDifficulty.easy
        
            ## Author
            data["author"] = request.user

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

            return response_ok(ProblemSerializer(problem).data)
        except KeyError as ke:
            return response_bad_request(str(ke) + " is required.")
        except:
            return response_bad_request("Unexpected error has occurred")

class ProblemDetailAPI(APIView):
    """
    List a specific problem
    """
    def get(self, request, id):
        try:
            problem = Problem.objects.get(id=id)
        except Problem.DoesNotExist:
            return response_not_found("Problem with id=%s does not exist." % str(id))
        
        ## TODO delete testset directory
        return response_ok(ProblemSerializer(problem).data)
    
    """
    Update a problem
    """
    @admin_required
    def put(self, request, id):
        try:
            problem = Problem.objects.get(id=id)
        except Problem.DoesNotExist:
            return response_not_found("Problem with id=%s does not exist." % str(id))
        
        if not request.user.can_mgmt_all_problem():
            if (problem.author is None) or (not request.user == problem.author):
                return response_unauthorized("You don't have permission to the problem")

        data = request.data

        #== Content to be displayed
        if data.get("title") != None:
            problem.title = data.get("title")
        if data.get("statement") != None:
            problem.statement = data.get("statement") 

        ## Tags, Difficulty, Source
        if data.get("tags") != None:
            tags = data["tags"]
            if type(tags) != list:
                return response_bad_request("'tags' should be a list.")
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

        problem.save()
        return response_ok(ProblemSerializer(problem).data)

    
    """
    Delete a problem
    """
    @admin_required
    def delete(self, request, id):
        try:
            problem = Problem.objects.get(id=id)
        except Problem.DoesNotExist:
            return response_not_found("Problem with id=%s does not exist." % str(id))
        
        data = request.data

        if not data.user.can_mgmt_all_problem and not data.user == problem.author:
            return response_unauthorized("You don't have permission to the problem")
        
        ## TODO delete testset directory
        problem.delete()
        return response_no_content("Delete successful")
