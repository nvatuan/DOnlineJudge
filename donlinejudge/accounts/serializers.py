from rest_framework import serializers
from accounts.models import User
from django.contrib.auth import authenticate, login, logout, password_validation
from django.utils.translation import gettext_lazy as _


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


class ProfilePageSerializer(serializers.ModelSerializer):
    profile_pic = serializers.ImageField(default='avatar/__default__.png')

    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'first_name',
                  'last_name', 'profile_pic', 'solved_problem']


class ProfilePageNoPasswordSerializer(serializers.ModelSerializer):
    profile_pic = serializers.ImageField(default='avatar/__default__.png')

    class Meta:
        model = User
        fields = ['username', 'email', 'first_name',
                  'last_name', 'profile_pic', 'solved_problem']


class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(
        max_length=128, write_only=True, required=True)
    new_password1 = serializers.CharField(
        max_length=128, write_only=True, required=True)
    new_password2 = serializers.CharField(
        max_length=128, write_only=True, required=True)

    def validate_old_password(self, value):
        user = self.context['request'].user
        if not user.check_password(value):
            raise serializers.ValidationError(
                _('Your old password was entered incorrectly. Please enter it again.')
            )
        return value

    def validate(self, data):
        if data['new_password1'] != data['new_password2']:
            raise serializers.ValidationError(
                {'new_password2': _("The two password fields didn't match.")})
        password_validation.validate_password(
            data['new_password1'], self.context['request'].user)
        return data

    def save(self, **kwargs):
        password = self.validated_data['new_password1']
        user = self.context['request'].user
        user.set_password(password)
        user.save()
        return user
