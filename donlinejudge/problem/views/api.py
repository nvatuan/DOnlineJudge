from django.shortcuts import render
from django.db.models import JSONField
from django.core.exceptions import ValidationError
from django.utils.crypto import get_random_string

from problem.models import Problem, ProblemTag
from problem.models import ProblemDifficulty
from problem.forms import ProblemForm, ProblemPutForm

from submission.models import SubmissionVerdict
from problem.serializers import ProblemSerializer, ProblemTagSerializer

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

import json

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
        datapost = request.data
        fdata = ProblemForm(request.POST, request.FILES)

        if not fdata.is_valid():
            return response_bad_request(fdata.errors.as_data())

        instance = fdata.save(commit=False)

        if request.FILES.get('test_zip', '') != '':
            uploadedzipfile = request.FILES['test_zip']
            tmpzipfile = f"/tmp/{get_random_string(32)}.zip"
            with open(tmpzipfile, "wb") as f:
                for chunk in uploadedzipfile:
                    f.write(chunk)
            try:
                TestZipHandler(tmpzipfile) # automatic validate
            except ValueError as ve:
                return response_bad_request('Invalid Zip: '+ve.args[0])
            instance.remove_test_zip() # Does not raise, remove zip if it exists
            instance.test_zip = request.FILES['test_zip']

        # TAGS
        tags = ["uncategorized"]
        if datapost.get('tags'):
            tags = datapost.get("tags")
            if type(tags) == str:
                tags = json.loads(tags)
            if type(tags) != list:
                return response_bad_request("'tags' should be a list.")
            if not tags:
                tags = ["uncategorized"]

        for item in tags:
            item = item.lower()
            try:
                tag = ProblemTag.objects.get(tag_name=item)
            except ProblemTag.DoesNotExist:
                tag = ProblemTag.objects.create(tag_name=item)

        # Statistics
        instance.statistic_info = SubmissionVerdict._get_default_dict()

        instance.save()
        for item in tags:
            tag = ProblemTag.objects.get(tag_name=item)
            instance.tags.add(tag)
        instance.author = request.user
        instance.save()
        return response_ok(ProblemSerializer(instance).data)

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

        ## Remove display_id if from querydict it is the same
        datapost = request.data
        rqpost = request.POST.copy()
        if rqpost.get('display_id'):
            problem.display_id = rqpost.get('display_id')
        rqpost.pop('display_id')
        
        fdata = ProblemPutForm(rqpost, request.FILES)
        if not fdata.is_valid():
            return response_bad_request(fdata.errors.as_data())
        if request.FILES.get('test_zip', '') != '':
            uploadedzipfile = request.FILES['test_zip']
            tmpzipfile = f"/tmp/{get_random_string(32)}.zip"
            with open(tmpzipfile, "wb") as f:
                for chunk in uploadedzipfile:
                    f.write(chunk)
            try:
                TestZipHandler(tmpzipfile) # automatic validate
            except ValueError as ve:
                return response_bad_request('Invalid Zip: '+ve.args[0])
            problem.remove_test_zip() # Does not raise, remove zip if it exists
            problem.test_zip = request.FILES['test_zip']

        # TAGS
        tags = ["uncategorized"]
        if datapost.get('tags'):
            tags = datapost.get("tags")
            if type(tags) == str:
                tags = json.loads(tags)
            if type(tags) != list:
                return response_bad_request("'tags' should be a list.")
            if not tags:
                tags = ["uncategorized"]
        problem.set_tags_to(tags)

        for k, v in fdata.cleaned_data.items():
            setattr(problem, k, v)
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
