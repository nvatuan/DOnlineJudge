from django.shortcuts import render
from django.db.models import JSONField
from django.core.exceptions import ValidationError
from django.utils.crypto import get_random_string

from problem.models import Problem, ProblemTag
from problem.models import ProblemDifficulty

from submission.models import SubmissionVerdict
from problem.serializers import ProblemSerializer

from rest_framework.views import APIView

from accounts.models import User
from accounts.decorators import super_admin_required
from accounts.decorators import admin_required, super_admin_required
from utils.make_response import *
from utils.validators import lowerAlphanumeric

#from utils.query_set_rearrange import auto_apply
import utils.serialized_data_rearrange as sdr
from utils.pagination import paginate
from utils.test_zip import TestZipHandler

class ProblemAPI(APIView):
    serializer_class = ProblemSerializer
    def get(self, request, format=None):
        """
            Get a list of problems
        """
        try:
            if request.user.is_authenticated and (
                request.user.is_admin_role() or request.user.can_mgmt_all_problem()
            ):
                problem = Problem.objects.all()
                problem_ser_data = ProblemSerializer(problem, many=True).data
                problem_ser_data = sdr.auto_apply(problem_ser_data, request)
                problem_ser_data = paginate(problem_ser_data, request)
                return response_ok(problem_ser_data)
            else: ## TODO return not visible problems but are authored by the user
                problem = Problem.objects.filter(is_visible=True)
                problem_ser_data = ProblemSerializer(problem, many=True).data
                problem_ser_data = sdr.auto_apply(problem_ser_data, request)
                problem_ser_data = paginate(problem_ser_data, request)
                return response_ok(problem_ser_data)
        except Exception:
            return response_bad_request("Request denied.")

    @admin_required
    def post(self, request, format=None):
        resperror = ""
        respdata = ""

        datapost = request.POST.copy()
        if datapost.get('csrfmiddlewaretoken'): datapost.pop('csrfmiddlewaretoken')
        datafile = request.FILES
        print(datapost)

        try:
            ## Display ID
            disp_id = datapost["display_id"]
            if not disp_id:
                raise KeyError("display_id")
            disp_id = disp_id.lower()
            try:
                lowerAlphanumeric(disp_id) 
            except ValidationError:
                return response_bad_request("'display_id' should contains lowercase, alphanumerics only")
            if Problem.objects.filter(display_id=disp_id).exists():
                return response_bad_request("Problem with display_id=%s already exists" % disp_id)

            ## Handle empty title and statement
            if datapost.get('title', '') == '':
                datapost.pop('title')
            if datapost.get('statement', '') == '':
                datapost.pop('statement', '')

            ## Tags, Difficulty, Source
            tags = []
            if datapost.get('tags', '') == '':
                tags = ["Uncategorized"]
            else:
                tags = datapost.pop("tags")
            if type(tags) != list:
                return response_bad_request("'tags' should be a list.")

            for item in tags:
                try:
                    tag = ProblemTag.objects.get(tag_name=item)
                except ProblemTag.DoesNotExist:
                    tag = ProblemTag.objects.create(tag_name=item)

            datapost["difficulty"] = datapost.get("difficulty", "Easy")
            if datapost["difficulty"] not in ProblemDifficulty.DIFF:
                return response_bad_request(f"Difficulty {datapost['difficulty']} is not valid")

            # Author
            #datapost["author"] = request.user # raise ValueError: assign [...] : Problem.author must be User isntance

            # Sample_Test:
            if datapost.get("sample_test", '') != '':
                if type(datapost["sample_test"]) != list:
                    return response_bad_request("'sample_test' should be a list of dict{input:..., output:...}")
            else:
                datapost["sample_test"] = []
            # Testzip
            if datafile.get("test_zip"):
                pass

            # Constaints
            # Statistics
            datapost["statistic_info"] = SubmissionVerdict._get_default_dict()

            #visible
            if datapost.get('is_visible', '') == '':
                datapost['is_visible'] = False
            elif not datapost['is_visible'] in [True, False]:
                return response_bad_request({"is_visible":"This field must either be true or false"})                    

            # == Create object
            # Create a temporary mutable QueryDict
            from django.http import QueryDict
            alldata = QueryDict('', mutable=True)
            alldata.update(datapost)
            alldata.update(datafile)

            problem = Problem.objects.create(**alldata)
            for item in tags:
                tag = ProblemTag.objects.get(tag_name=item)
                problem.tags.add(tag)

            return response_ok(ProblemSerializer(problem).data)
        except KeyError as ke:
            return response_bad_request(str(ke) + " is required.")
        # except:
        #     return response_bad_request("Unexpected error has occurred")


class ProblemDetailAPI(APIView):
    serializer_class = ProblemSerializer
    """
    List a specific problem
    """

    def get(self, request, id):
        try:
            if request.user.is_authenticated and request.user.is_admin_role():
                problem = Problem.objects.get(id=id)
                return response_ok(ProblemSerializer(problem).data)
            else:
                problem = Problem.objects.get(id=id, is_visible=True)
                return response_ok(ProblemSerializer(problem).data)
        except Problem.DoesNotExist:
            return response_not_found("Problem does not exist.")


    """
    Update a problem
    """
    @admin_required
    def put(self, request, id):
        print(request.data)
        try:
            problem = Problem.objects.get(id=id)
        except Problem.DoesNotExist:
            return response_not_found("Problem with id=%s does not exist." % str(id))

        if (not request.user.can_mgmt_all_problem()) and (not request.user.is_super_admin()):
            if (problem.author is None) or (not request.user == problem.author):
                return response_unauthorized("You don't have permission to edit the problem")

        data = request.data

        # == Content to be displayed
        if data.get("title", '') != '':
            problem.title = data.get("title")
        if data.get("statement", '') != '':
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
        if data.get("sample_test", '') != '':
            problem.sample_test = data['sample_test']

        # Testdir
        if data.get('test_zip', '') != '':
            uploadedzipfile = request.FILES['test_zip']
            tmpzipfile = f"/tmp/{get_random_string(32)}.zip"
            with open(tmpzipfile, "wb") as f:
                for chunk in uploadedzipfile:
                    f.write(chunk)
            TestZipHandler(tmpzipfile) # automatic validate
            problem.remove_test_zip() # Does not raise when zip doesn't exist, remove zip if it exists
            problem.test_zip = data['test_zip']

        # Constaints
        if data.get("time_limit", '') != '':
            try:
                tlimit = int(data.get("time_limit", '1000'))
            except:
                return response_bad_request("Cannot parse time_limit to an integer")

            if tlimit < 0:
                tlimit = 1000
            problem.time_limit = tlimit

        #visible
        if data.get("is_visible", '') != '':
            if data.get("is_visible") in [True, False]:
                problem.is_visible = data.get("is_visible")
            else:
                raise ValueError("Attribute 'is_visible' should be boolean ("+data.get("is_visible")+")")

        if data.get("memory_limit", '') != '':
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

        problem.remove_test_zip()
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
