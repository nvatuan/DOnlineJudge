from rest_framework import serializers
from accounts.models import User
from django.contrib.auth import authenticate, login, logout, password_validation
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.password_validation import validate_password

from problem.serializers import ProblemBriefSerializer

class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(max_length=80, min_length=8)

    class Meta:
        model = User
        fields = ['username', 'email', 'password']

    def validate(self, attrs):
        email = attrs.get('email', '')
        username = attrs.get('username', '')

        if not username.isalnum():
            raise serializers.ValidationError(
                "The username should only contain alphanumeric characters")
        return attrs

    def create(self, validated_data):
        return User.objects.create_user(**validated_data)


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"


class UserLoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        user = authenticate(**data)
        if user and user.is_active:
            return user
        raise serializers.ValidationError("Incorrect Credentials")

class UserCreationSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"

class ProfilePageSerializer(serializers.ModelSerializer):
    profile_pic = serializers.ImageField(default='avatar/__default__.png')
    authored_problem = ProblemBriefSerializer(many=True, read_only=True) 
    solved_problem = ProblemBriefSerializer(many=True, read_only=True) 

    class Meta:
        model = User
        fields = '__all__'


class ProfilePageNoPasswordSerializer(serializers.ModelSerializer):
    profile_pic = serializers.ImageField(default='avatar/__default__.png')
    authored_problem = ProblemBriefSerializer(many=True, read_only=True) 
    solved_problem = ProblemBriefSerializer(many=True, read_only=True) 

    class Meta:
        model = User
        exclude = ('password',)


class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(
        max_length=128, write_only=True, required=True)
    new_password1 = serializers.CharField(
        max_length=128, write_only=True, required=True)
    new_password2 = serializers.CharField(
        max_length=128, write_only=True, required=True)

    def validate_new_password1(self, value):
        validate_password(value)
        return value

    def save(self, **kwargs):
        password = self.validated_data['new_password1']
        user = self.context['request'].user
        user.set_password(password)
        user.save()
        return user
