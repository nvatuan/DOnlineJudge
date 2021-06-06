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

    @super_admin_required
    def post(self, request):
        return response_bad_resquest("This API is not implemented")

    @super_admin_required
    def put(self, request):
        data = request.data
        try:
            user = User.objects.get(id=data["id"])
        except User.DoesNotExist:
            return response_bad_request("User does not exist")
        if User.objects.filter(username=data["username"].lower()).exclude(id=user.id).exists():
            return response_bad_request("Username already exists")
        if User.objects.filter(email=data["email"].lower()).exclude(id=user.id).exists():
            return response_bad_request("Email already exists")

        pre_username = user.username
        user.username = data["username"].lower()
        user.email = data["email"].lower()
        user.admin_type = data["admin_type"]
        user.is_verified = data["is_verified"]
        user.is_active = data["is_active"]
        user.is_staff = data["is_staff"]

        if data["admin_type"] == AdminType.ADMIN:
            user.problem_permission = data["problem_permission"]
        elif data["admin_type"] == AdminType.SUPER_ADMIN:
            user.problem_permission = ProblemPermission.ALL
        else:
            user.problem_permission = ProblemPermission.NONE

        if data["password"]:
            user.set_password(data["password"])

        user.save()
        if pre_username != user.username:
            Submission.objects.filter(username=pre_username).update(username=user.username)

        return response_ok(UserSerializer(user).data)

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
    
