from django.shortcuts import render
from django.db.models import JSONField

from problem.models import Problem, ProblemTag
from problem.models import ProblemDifficulty

from submission.models import SubmissionVerdict
from problem.serializers import ProblemSerializer

from rest_framework.views import APIView

from accounts.decorators import super_admin_required
from accounts.decorators import admin_required, super_admin_required
from utils.make_response import *

#from utils.query_set_rearrange import auto_apply
import utils.serialized_data_rearrange as sdr
from utils.pagination import paginate

class ProblemAPI(APIView):
    def get(self, request, format=None):
        """
            Get a list of problems
        """
        try:
            if request.user.is_authenticated and (
                request.user.is_admin_role() or request.user.can_mgmt_all_problem()
            ):
                problem = Problem.objects.all().order_by("-created")
                problem_ser_data = ProblemSerializer(problem, many=True).data
                problem_ser_data = sdr.auto_apply(problem_ser_data, request)
                problem_ser_data = paginate(problem_ser_data, request)
                return response_ok(problem_ser_data)
            else: ## TODO return not visible problems but are authored by the user
                problem = Problem.objects.filter(
                    visible=True).order_by("-created")
                problem_ser_data = ProblemSerializer(problem, many=True).data
                problem_ser_data = sdr.auto_apply(problem_ser_data, request)
                problem_ser_data = paginate(problem_ser_data, request)
                return response_ok(ProblemSerializer(problem, many=True).data)
        except Exception:
            return response_bad_request("Request denied.")

    @admin_required
    def post(self, request, format=None):
        resperror = ""
        respdata = ""

        data = request.data

        try:
            # Display ID
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
                    tag = ProblemTag.objects.get(tag_name=item)
                except ProblemTag.DoesNotExist:
                    tag = ProblemTag.objects.create(tag_name=item)

            data["difficulty"] = data.get("difficulty", "Easy")
            if data["difficulty"] not in ProblemDifficulty.DIFF:
                return response_bad_request(f"Difficulty {data['difficulty']} is not valid")

            # Author
            data["author"] = request.user

            # Testdir
            data["testset_dir"] = disp_id
            data["testset_count"] = data.get("testset_count", 0)
            if data["testset_count"] < 0:
                data["testset_count"] = 0

            # Constaints
            # Statistics
            data["statistic_info"] = SubmissionVerdict._get_default_dict()

            #visible
            if data['visible'] == '':
                data['visible'] = True
            elif not data['visible'] in [True, False]:
                return response_bad_request({"visible":"This field must be true or false"})                    

            # == Create object
            problem = Problem.objects.create(**data)
            for item in tags:
                tag = ProblemTag.objects.get(tag_name=item)
                problem.tags.add(tag)

            return response_ok(ProblemSerializer(problem).data)
        except KeyError as ke:
            return response_bad_request(str(ke) + " is required.")
        # except:
        #     return response_bad_request("Unexpected error has occurred")


class ProblemDetailAPI(APIView):
    """
    List a specific problem
    """

    def get(self, request, id):
        try:
            if request.user.is_authenticated and request.user.is_admin_role():
                problem = Problem.objects.get(id=id)
                return response_ok(ProblemSerializer(problem).data)
            else:
                problem = Problem.objects.get(id=id, visible=True)
                return response_ok(ProblemSerializer(problem).data)
        except Problem.DoesNotExist:
            return response_not_found("Problem does not exist.")



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

        # == Content to be displayed
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
                        tag = ProblemTag.objects.get(tag_name=item)
                    except ProblemTag.DoesNotExist:
                        tag = ProblemTag.objects.create(tag_name=item)

            problem.tags.clear()
            for item in tags:
                problem.tags.add(ProblemTag.objects.get(tag_name=item))

        if data.get("difficulty") != None:
            dif = data.get("difficulty")
            if dif not in ProblemDifficulty.DIFF:
                dif = ProblemDifficulty.easy
            problem.difficulty = dif

        # Sample tests
        if data.get("sample_test"):
            problem.sample_test = data['sample_test']

        # Testdir
        if data.get("testset_count") != None:
            tscount = data.get("testset_count", 0)
            if tscount < 0:
                tscount = 0
            problem.testset_count = tscount

        # Constaints
        if data.get("time_limit") != None:
            try:
                tlimit = int(data.get("time_limit", '1000'))
            except:
                return response_bad_request("Cannot parse time_limit to an integer")

            if tlimit < 0:
                tlimit = 1000
            problem.time_limit = tlimit

        #visible
        if data.get("visible") != '' and data.get("visible") in [True, False]:
            problem.visible = data.get("visible")

        if data.get("memory_limit") != None:
            if data.get("memory_limit") != None:
                try:
                    mlimit = int(data.get("memory_limit", '256'))
                except:
                    return response_bad_request("Cannot parse memory_limit to an integer")
            if mlimit < 0:
                mlimit = 256
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

        if not request.user.can_mgmt_all_problem and not request.user == problem.author:
            return response_unauthorized("You don't have permission to the problem")

        # TODO delete testset directory
        problem.delete()
        return response_no_content("Delete successful")


class ProblemTagAPI(APIView):
    """
    Get all tags
    """

    def get(self, request, format=None):
        probs = ProblemTag.objects.all()
        seris = ProblemTagSerializer(probs, many=True)
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

        # TODO delete testset directory
        return response_ok(ProblemTagSerializer(tag).data)
