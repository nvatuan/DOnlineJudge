## From django
from django.contrib.auth import login, logout
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status, generics
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.authtoken.models import Token

## Python
import os
import logging

## Project's
from donlinejudge.settings import MEDIA_ROOT
from accounts.serializers import RegisterSerializer, UserLoginSerializer, UserSerializer, ProfilePageSerializer
from accounts.models import User
from accounts.decorators import unauthenticated_user, login_required

## Custom made utils lib
from utils.make_response import *
from utils.query_set_rearrange import *

class RegisterAPI(APIView):
    serializer = RegisterSerializer

    @unauthenticated_user
    def post(self, request):
        user = request.data
        serializer = self.serializer(data=user)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        user_data = serializer.data
        return response_created(user_data)


class LoginAPI(generics.GenericAPIView):
    serializer_class = UserLoginSerializer
    authentication_classes = [SessionAuthentication, BasicAuthentication]

    @unauthenticated_user
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data
        login(request, user)
        user_data = User.objects.get(username=request.data['username'])
        token, created = Token.objects.get_or_create(user=user_data)

        ## make_response would break ?
        return Response({
            "user": UserSerializer(user, context=self.get_serializer_context()).data,
            "token": str(token)
        })

class LogoutAPI(APIView):
    @login_required
    def get(self, request):
        logout(request)
        return response_no_content("User logout.")

class OwnProfilePageAPI(generics.GenericAPIView):
    serializer_class = ProfilePageSerializer

    @login_required
    def get(self, request):
        user = request.user
        return response_ok(ProfilePageSerializer(user, context=self.get_serializer_context()).data)

    @login_required
    def put(self, request):
        user = request.user
        data = request.data
        serializer = ProfilePageSerializer(instance=user)

        if data["email"] != '':
            if User.objects.filter(email=data["email"].lower()).exclude(id=user.id).exists():
                return response_not_found("This email already exists")
            user.email = data["email"].lower()

        if data["first_name"] != '':
            user.first_name = data["first_name"]

        if data["last_name"] != '':
            user.last_name = data["last_name"]
        
        if data["profile_pic"] != '':
            user.profile_pic = data["profile_pic"]
        user.save()

        return response_ok(ProfilePageSerializer(user, context=self.get_serializer_context()).data)
    
    @login_required
    def delete(self, request):
        user = request.user
        default_profile_pic = User._meta.get_field('profile_pic').get_default()
        if user.profile_pic == default_profile_pic:
            return response_bad_request("This user is using the default avatar")
        
        try:
            filepath = os.path.join(MEDIA_ROOT, str(user.profile_pic))
            if not os.path.exists(filepath):
                user.profile_pic = default_profile_pic
                user.save()
                return response_no_content("Your avatar file could not be located. Resetting it to default.")

            os.remove(filepath)
            user.profile_pic = default_profile_pic
            user.save()
        except Exception as e:
            logging.debug(f"Exception occured when trying to delete avatar\n {e}")
            return response_internal_error("Cannot delete your avatar at the moment")
        
        return response_no_content("Delete avatar successfully.")


class ProfilePageAPI(APIView):
    def get(self, request, id):
        user = request.user
        if not User.objects.filter(id=id).exists():
            return response_not_found(f"User with id={id} could not be found.")
        return response_ok(ProfilePageSerializer(User.objects.get(id=id)).data)
