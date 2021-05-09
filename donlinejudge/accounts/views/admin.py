from django.contrib.auth.hashers import make_password
from django.contrib.auth import login, logout
from django.db import transaction, IntegrityError

from rest_framework.views import APIView
from rest_framework import generics, serializers, status 
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.authtoken.models import Token

from accounts.models import User
from accounts.serializers import UserSerializer, RegisterSerializer, UserLoginSerializer
from accounts.decorators import super_admin_required
from accounts.models import *
from submission.models import Submission
from utils.make_response import *


class UserAPI(APIView):
    @super_admin_required
    def get(self, request):
        user = User.objects.all()
        return response_ok(UserSerializer(user, many=True).data)

    # @admin_required
    # def post(self, request):
    #     pass

    @super_admin_required
    def put(self, request):
        data = request.data
        try:
            user = User.objects.get(id=data["id"])
        except User.DoesNotExist:
            return response_not_found("User does not exist")
        if User.objects.filter(username=data["username"].lower()).exclude(id=user.id).exists():
            return reponse_bad_request("Username already exists")
        if User.objects.filter(email=data["email"].lower()).exclude(id=user.id).exists():
            return reponse_bad_request("Email already exists")

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

class LoginAPI(generics.GenericAPIView):
    serializer_class = UserLoginSerializer
    authentication_classes = [SessionAuthentication, BasicAuthentication]

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data

        if not user.is_staff:
            return response_forbidden("Forbidden")

        login(request, user)

        user_data = User.objects.get(username=request.data['username'])
        token, created = Token.objects.get_or_create(user=user_data)
        return response_ok({
            "user": UserSerializer(user,context=self.get_serializer_context()).data,
            "token": str(token)
        })