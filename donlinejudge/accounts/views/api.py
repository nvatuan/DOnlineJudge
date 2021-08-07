# From django
from django.contrib.auth import login, logout
from django.contrib.auth.hashers import make_password
from django.utils.crypto import get_random_string as randstr
from django.db import transaction, IntegrityError

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status, generics
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.authtoken.models import Token

from django.core.validators import validate_email
from django.core.exceptions import ValidationError
# Python
import os
import logging
from PIL import Image

# Project's
from donlinejudge.settings import MEDIA_ROOT, TOKEN_EXPIRE_AFTER_SECONDS
from accounts.serializers import RegisterSerializer, UserLoginSerializer, UserSerializer, ProfilePageSerializer, ProfilePageNoPasswordSerializer, ChangePasswordSerializer, UserCreationSerializer
from accounts.decorators import unauthenticated_user, login_required, super_admin_required
from accounts.models import *
from submission.models import Submission

# Custom made utils lib
from utils.make_response import *
import utils.serialized_data_rearrange as sdr
from utils.pagination import paginate
from utils.validators import ImageExtensionValidator as IEV
from utils.time import utc_now

""" accounts.management API
    - RegisterAPI
    - LoginAPI
    - LogoutAPI
    - ChangePasswordAPI
    - OwnProfilePageAPI
    - ProfilePageAPI

    - UserAPI (Get a List of users)
    - UserDetailAPI (Get a certain user)
"""

class RegisterAPI(APIView):
    '''
    For Registering a new account
    '''
    serializer_class = RegisterSerializer
    @unauthenticated_user
    def post(self, request):
        data = request.data
        serializer = self.serializer_class(data=data)
        username = data.get("username", '')
        email = data.get("email", '')
        password =  data.get("password",'')
        if username != '' and username.isalnum():
            if User.objects.filter(username=data["username"].lower()).exists():
                return response_bad_request({"username":"This username already exists"})
        else: 
            return response_bad_request({"username":"Username can only contain alphanumeric characters."})
        if email != '':
            try:
                validate_email(email)
                if User.objects.filter(email=email.lower()).exists():
                    return response_bad_request({"email":"This email already exists"})
            except ValidationError:
                return response_bad_request({"email":"This email is invalid"})
        else:
            return response_bad_request({"email":"This field is required."})
        if password != '' and len(password) >= 8:
            serializer.is_valid()
            serializer.save()
            user_data = serializer.data
            return response_created(user_data)
    
        return response_bad_request({"password":"The password length must be more than 8 with letters and numbers."})


class LoginAPI(generics.GenericAPIView):
    serializer_class = UserLoginSerializer
    authentication_classes = [SessionAuthentication]

    #@unauthenticated_user # not required to logout, refresh token
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if request.data.get("username").strip() == "": 
            return response_bad_request({"username":"This field is required."})
        if request.data.get("password").strip() == "":
            return response_bad_request({"password":"This field is required."})
        
        if serializer.is_valid():
            user = serializer.validated_data

            if request.user.is_authenticated:
                if user != request.user:
                    return response_bad_request("Cannot login as another user if you are already logged on")
                request.user.auth_token.delete()
                logout(request)
            
            try:
                login(request, user)
            except FileNotFoundError:
                user.reset_profile_pic()
                login(request, user)

            user_data = User.objects.get(username=request.data['username'])
            try: # Delete the Token if it exists
                token = Token.objects.get(user=user_data)
                token.delete()
            except Token.DoesNotExist:
                pass
            except:
                raise
            token = Token.objects.create(user=user_data) # Recreate Token for the user who is logging in
            
            return response_ok({
                "user": UserSerializer(user, context=self.get_serializer_context()).data,
                "token": str(token),
                "TTL": int(TOKEN_EXPIRE_AFTER_SECONDS - (utc_now() - token.created).total_seconds()+0.5),
            })
        else:
            return response_bad_request({"username":"Username or Password is incorrect. Try again."})


class LogoutAPI(APIView):
    @login_required
    def get(self, request):
        request.user.auth_token.delete()
        logout(request)
        return response_no_content("User logout.")

class ChangePasswordAPI(generics.UpdateAPIView):
    serializer_class = ChangePasswordSerializer

    @login_required
    def update(self, request, *args, **kwargs):
        user = request.user
        data = request.data
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            old_password = data.get('old_password', '')

            if not user.check_password(old_password):
                return response_bad_request({"old_password":"Your old password was entered incorrectly. Please enter it again."})

            if data.get('new_password1', '') != '' and data.get('new_password1', '') == data.get('new_password2', ''):
                user = serializer.save()
            # create a new token
                if hasattr(user, 'auth_token'):
                    user.auth_token.delete()
                token, created = Token.objects.get_or_create(user=user)
            # return new token
                return response_ok({'token': token.key, 'noti': 'success!'})
            return response_bad_request({"entered_password":"The two password fields didn't match."})
        return response_bad_request({"entered_password":"Password is not valid."})

class OwnProfilePageAPI(generics.GenericAPIView):
    serializer_class = ProfilePageNoPasswordSerializer

    @login_required
    def get(self, request):
        user = request.user
        return response_ok(ProfilePageNoPasswordSerializer(user, context=self.get_serializer_context()).data)

    @login_required
    def put(self, request):
        user = request.user
        data = request.data

        if data.get("username", '') != '':
            if User.objects.filter(username=data["username"].lower()).exclude(id=user.id).exists():
                return response_bad_request({"username":"This username already exists"})
            user.username = data["username"].lower()

        if data.get("password", '') != '':
            return response_bad_request("Please use profile/change-password API for password changing")

        if data.get("email", '') != '':
            if User.objects.filter(email=data["email"].lower()).exclude(id=user.id).exists():
                return response_bad_request({"email":"This email already exists"})
            user.email = data["email"].lower()

        if data.get("first_name", '') != '':
            user.first_name = data["first_name"]

        if data.get("last_name", '') != '':
            user.last_name = data["last_name"]

        if data.get("profile_pic", '') != '':
            if IEV.validate(str(data["profile_pic"])):
                user.reset_profile_pic()
                user.profile_pic = data["profile_pic"]
            else:
                return response_bad_request({"profile_pic":"The file must have an image extension of .jpg, .jpeg or .png"})
        user.save()

        return response_ok(ProfilePageNoPasswordSerializer(user, context=self.get_serializer_context()).data)

    @login_required
    def delete(self, request):
        """
        Delete avatar - not the user
        """
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
            logging.debug(
                f"Exception occured when trying to delete avatar\n {e}")
            return response_internal_error("Cannot delete your avatar at the moment")

        return response_no_content("Delete avatar successfully.")

class ProfilePageAPI(APIView):
    def get(self, request, id):
        if not User.objects.filter(id=id).exists():
            return response_not_found(f"User with id={id} could not be found.")
        return response_ok(ProfilePageNoPasswordSerializer(User.objects.get(id=id)).data)

class UserAPI(APIView):
    @super_admin_required
    def get(self, request):
        user = User.objects.all()
        #user = auto_apply(user, request)
        user_sdata = UserSerializer(user, many=True).data
        user_sdata = sdr.auto_apply(user_sdata, request)
        user_sdata = paginate(user_sdata, request)

        return response_ok(user_sdata)

    @super_admin_required
    def post(self, request):
        gen_type = request.data.get('user_gen_type')
        dat = request.data
        # If any is duplicated, abort
        if gen_type == 'list':
            # 1. Supply list of username, email, first_name, last_name
            # Automatically create accounts for these users
            ulist = dat.get('username_list',[])

            elist = dat.get('email_list',[])
            flist = dat.get('fname_list',[])
            llist = dat.get('lname_list',[])
            created_users = []
            for i, un in enumerate(ulist):
                if len(User.objects.filter(username=un)) > 0:
                    return response_bad_request(
                        "Username {0} has been taken".format(un)
                    )
                em = (elist[i] if len(elist) > i else '')
                fn = (flist[i] if len(flist) > i else '')
                ln = (llist[i] if len(llist) > i else '')
                created_users.append(
                    User(username=un, email=em,
                         first_name=fn, last_name=ln,
                         password = randstr(length=10)
                    )
                )
            User.objects.bulk_create(created_users)
            return response_created(
                UserCreationSerializer(created_users, many=True).data
            ) 
        elif gen_type == 'macro':
            # 2. Let the website generate a group of users
            # with prefix and postfix in their username
            prefix=dat.get('username_prefix', '');
            postfix=dat.get('username_postfix', '');
            try:
                howmany = int(dat.get('create_count', '0'));
                if howmany < 1:
                    return response_bad_request("'create_count' should be positive")
            except ValueError:
                return response_bad_request("'create_count' should be a whole number")
            
            created_users = []
            for i in range(howmany):
                un = prefix+str(i)+postfix
                if len(User.objects.filter(username=un)) > 0:
                    return response_bad_request(
                        "Username {0} has been taken".format(un)
                    )
                created_users.append(
                    User(username=un,password = randstr(length=10))
                )
            User.objects.bulk_create(created_users)
            return response_created(
                UserCreationSerializer(created_users, many=True).data
            ) 
        else:
            return response_bad_request("Missing 'user_gen_type' in body or type is unsupported")

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
        UPDATE_FIELDS = ["username", "password", "email", "first_name", "last_name",
            "admin_type", "problem_permission", "is_staff"]
        for field in UPDATE_FIELDS:
            data[field] = data.get(field, '')

        # Try validate
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
