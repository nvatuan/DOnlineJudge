from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.conf import settings
from django.db import models
from PIL import Image
import os

from django.apps import apps

from utils.file_upload import FileUploadUtils 

class AdminType(object):
    REGULAR_USER = "Regular User"
    ADMIN = "Admin"
    SUPER_ADMIN = "Super Admin"

    TYPES = [REGULAR_USER, ADMIN, SUPER_ADMIN]


class ProblemPermission(object):
    NONE = "None"
    OWN = "Own"
    ALL = "All"

    TYPES = [NONE, OWN, ALL]


class UserManager(BaseUserManager):
    def create_user(self, username, email, password=None):
        if username is None:
            raise TypeError('User should have a Username!')
        if email is None:
            raise TypeError('User should have a Email!')

        user = self.model(username=username, email=self.normalize_email(email))
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, username, email=None, password=None):
        if username is None:
            raise TypeError('User should have a Username!')
        if password is None:
            raise TypeError('Password should not be None!')

        user = self.model(username=username, email=self.normalize_email(email))
        user.set_password(password)
        user.admin_type = AdminType.SUPER_ADMIN
        user.is_superuser = True
        user.is_staff = True
        user.save()
        return user


class User(AbstractBaseUser, PermissionsMixin):
    username = models.TextField(unique=True, db_index=True)
    email = models.EmailField(null=True)
    first_name = models.CharField(max_length=100,null=True)
    last_name = models.CharField(max_length=100, null=True)

    solved_problem = models.ManyToManyField('problem.Problem', blank=True) 

    create_time = models.DateTimeField(auto_now_add=True, null=True)
    update_time = models.DateTimeField(auto_now=True, null=True)

    # One of UserType
    profile_pic = models.ImageField(
        default='avatar/__default__.png', null=True, blank=True,
        upload_to=FileUploadUtils().upload_to_path_and_rename('avatar/', False)
    )

    admin_type = models.TextField(default=AdminType.REGULAR_USER)
    problem_permission = models.TextField(default=ProblemPermission.NONE)
    is_verified = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    USERNAME_FIELD = "username"
    REQUIRED_FIELDS = []

    DISPLAY_FIELD = ["username", "email", "first_name", "last_name",
                     "create_time", "admin_type", "problem_permission", "is_active"]

    objects = UserManager()

    def authored_problem(self):
        return self.problem_set.all()

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        img = Image.open(self.profile_pic.path)

        if img.height > 300 or img.width > 300:
            output_size = (300, 300)
            img.thumbnail(output_size)
            img.save(self.profile_pic.path)

    def is_using_default_profile_pic(self):
        return self.profile_pic == User._meta.get_field('profile_pic').get_default() 

    def reset_profile_pic(self):
        if not self.is_using_default_profile_pic():
            if os.path.exists(self.profile_pic.path):
                os.remove(self.profile_pic.path)
            self.profile_pic = User._meta.get_field('profile_pic').get_default()
            self.save()

    def is_admin(self):
        return self.admin_type == AdminType.ADMIN

    def is_super_admin(self):
        return self.admin_type == AdminType.SUPER_ADMIN

    def is_admin_role(self):
        return self.admin_type in [AdminType.ADMIN, AdminType.SUPER_ADMIN]

    def can_mgmt_all_problem(self):
        return self.problem_permission == ProblemPermission.ALL

    def can_mgmt_own_problem(self):
        return self.problem_permission == ProblemPermission.OWN

    def __repr__(self):
        d = {}
        for field in self.DISPLAY_FIELD:
            d[field] = getattr(self, field)
        return str(d)
