from rest_framework import serializers
from accounts.models import User
from django.contrib.auth import authenticate, login, logout


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


class UpdateUserSerializer(serializers.ModelSerializer):
    profile_pic = serializers.ImageField(
        default='profile1.png')

    class Meta:
        model = User
        fields = ['email', 'first_name', 'last_name', 'profile_pic']
