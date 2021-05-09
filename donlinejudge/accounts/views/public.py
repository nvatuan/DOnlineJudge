from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status, generics
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.authtoken.models import Token

from accounts.serializers import RegisterSerializer, UserLoginSerializer, UserSerializer
from accounts.models import User
from accounts.decorators import unauthenticated_user, login_required

from django.contrib.auth import login, logout

class RegisterAPI(APIView):
    serializer = RegisterSerializer

    @unauthenticated_user
    def post(self, request):
        user = request.data
        serializer = self.serializer(data=user)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        user_data = serializer.data
        return Response(user_data, status=status.HTTP_201_CREATED)


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
        return Response({
            "user": UserSerializer(user,context=self.get_serializer_context()).data,
            "token": str(token)
        })


class LogoutAPI(APIView):
    @login_required
    def get(self,request):
        logout(request)
        return Response({"User logger out!"})