from rest_framework import generics, serializers, status 
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.authtoken.models import Token
from django.contrib.auth import login, logout

from accounts.serializers import RegisterSerializer, UserLoginSerializer, UserSerializer

from accounts.models import User

from utils.make_response import *

class RegisterAPI(APIView):
    serializer = RegisterSerializer

    def post(self, request):
        try:
            user = request.data
            if user["username"] == "": raise KeyError("username")
            if user["password"] == "": raise KeyError("password")
            if user["email"] == "": raise KeyError("email")

            serializer = self.serializer(data=user)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            user_data = serializer.data

            return response_created(user_data)
        except KeyError as ke:
            return response_bad_request(str(ke) + " is required.")
        except ValueError as err:
            return response_bad_request(str(err))

class LoginAPI(generics.GenericAPIView):
    serializer_class = UserLoginSerializer
    authentication_classes = [SessionAuthentication, BasicAuthentication]

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data
        login(request, user)

        user_data = User.objects.get(username=request.data['username'])
        token, created = Token.objects.get_or_create(user=user_data)
        return response_ok({
            "user": UserSerializer(user,context=self.get_serializer_context()).data,
            "token": str(token)
        })