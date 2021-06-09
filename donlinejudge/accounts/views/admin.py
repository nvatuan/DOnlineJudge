from rest_framework.views import APIView
from rest_framework import status
from accounts.models import User
from rest_framework.response import Response
from accounts.serializers import UserSerializer
from accounts.decorators import super_admin_required
from accounts.models import *
from django.contrib.auth.hashers import make_password
from django.db import transaction, IntegrityError
from submission.models import Submission

from utils.query_set_rearrange import *
from utils.make_response import *

class UserAPI(APIView):
    @super_admin_required
    def get(self, request):
        user = User.objects.all()
        user = filter_then_sort(user, request.query_params)
        return response_ok(UserSerializer(user, many=True).data)

    #@super_admin_required
    #def post(self, request):
    #    return response_bad_request("This API is not implemented")


class UserDetailAPI(APIView):
    @super_admin_required
    def get(self, request, id):
        """
        Get specific user
        """
        try:
            user = User.objects.get(id=id)
        except User.DoesNotExist:
            return response_not_found(f"User with id={id} could not be found.")
        return response_ok(UserSerializer(user).data)

    @super_admin_required
    def put(self, request, id):
        """
        Update a specific user
        """
        data = request.data
        fields = ["username", "password", "email", "first_name", "last_name",
            "admin_type", "problem_permission", "is_staff"]
        for field in fields:
            data[field] = data.get(field, '')

        try:
            user = User.objects.get(id=id)
        except User.DoesNotExist:
            return response_bad_request("User does not exist")

        if data["username"] != '':
            if User.objects.filter(username=data["username"].lower()).exclude(id=user.id).exists():
                return response_bad_request("Username already exists")
            user.username = data["username"].lower()

        if data["email"] != '':
            if User.objects.filter(email=data["email"].lower()).exclude(id=user.id).exists():
                return response_bad_request("Email already exists")
            user.email = data["email"].lower()

        if data["admin_type"] != '':
            if data["admin_type"] not in AdminType.TYPES:
                return response_bad_request("admin_type \'{}\' is not valid.".format(data["admin_type"]))
            user.admin_type = data["admin_type"]

        if data["is_staff"] != '':
            if data["is_staff"] not in ['true', 'false']:
                return response_bad_request("is_staff '{}' should be either 'true' or 'false'.".format(data["is_staff"]))
            if data["is_staff"] == 'true':
                user.is_staff = True
            else:
                user.is_staff = False 

        if data["admin_type"] == AdminType.ADMIN:
            user.problem_permission = ProblemPermission.OWN
        elif data["admin_type"] == AdminType.SUPER_ADMIN:
            user.problem_permission = ProblemPermission.ALL
        else:
            user.problem_permission = ProblemPermission.NONE

        if data["problem_permission"] != '':
            if data["problem_permission"] not in ProblemPermission.TYPES:
                return response_bad_request("problem_permission '{}' is not valid.".format(data["problem_permission"]))
            user.problem_permission = data["problem_permission"]
        
        if data["password"] != '':
            user.set_password(data["password"])

        user.save()

        return response_ok(UserSerializer(user).data)

    @super_admin_required
    def delete(self, request, id):
        """
        Delete a specific user
        """
        try:
            user = User.objects.get(id=id)
        except User.DoesNotExist:
            return response_not_found(f"User with id={id} could not be found.")
        user.delete()
        return response_no_content("Delete successfully")

class LoginAPI(APIView):
    pass
    
