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

class UserAPI(APIView):

    @super_admin_required
    def get(self, request):
        user = User.objects.all()
        return Response(UserSerializer(user, many=True).data)

    # @admin_required
    # def post(self, request):
    #     pass

    @super_admin_required
    def put(self, request):
        data = request.data
        try:
            user = User.objects.get(id=data["id"])
        except User.DoesNotExist:
            return Response("User does not exist", status=status.HTTP_404_NOT_FOUND)
        if User.objects.filter(username=data["username"].lower()).exclude(id=user.id).exists():
            return Response("Username already exists", status=status.HTTP_400_BAD_REQUEST)
        if User.objects.filter(email=data["email"].lower()).exclude(id=user.id).exists():
            return Response("Email already exists", status=status.HTTP_400_BAD_REQUEST)

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

        return Response(UserSerializer(user).data)

    