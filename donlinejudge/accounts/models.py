from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.conf import settings
from django.db import models

class AdminType(object):
    REGULAR_USER = "Regular User"
    ADMIN = "Admin"
    SUPER_ADMIN = "Super Admin"


class ProblemPermission(object):
    NONE = "None"
    OWN = "Own"
    ALL = "All"


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
        default='profile1.png', null=True, blank=True)

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
