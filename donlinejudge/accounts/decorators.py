import functools
from rest_framework.response import Response


class BasePermissionDecorator(object):
    def __init__(self, func):
        self.func = func

    def __get__(self, obj, obj_type):
        return functools.partial(self.__call__, obj)

    def error(self, data):
        return Response({"error": "permission-denied", "data": data})

    def __call__(self, *args, **kwargs):
        self.request = args[1]

        if self.check_permission():
            if not self.request.user.is_active:
                return self.error("Your account is disabled")
            return self.func(*args, **kwargs)
        else:
            return self.error("Please login first")


    def check_permission(self):
        raise NotImplementedError()


class BaseAuthenticatedDecorator(object):
    def __init__(self, func):
        self.func = func

    def __get__(self, obj, obj_type):
        return functools.partial(self.__call__, obj)

    def error(self, data):
        return Response({"error": "permission-denied", "data": data})

    def __call__(self, *args, **kwargs):
        self.request = args[1]

        if self.check_unauthenticated_user():
            if self.request.user.is_active:
                return self.error("Please logout first")
        return self.func(*args, **kwargs)
      
            

    def check_unauthenticated_user(self):
        raise UserWarning()


class login_required(BasePermissionDecorator):
    def check_permission(self):
        return self.request.user.is_authenticated

class admin_required(BasePermissionDecorator):
    def check_permission(self):
        user = self.request.user
        return user.is_authenticated and user.is_admin_role()

class super_admin_required(BasePermissionDecorator):
    def check_permission(self):
        user = self.request.user
        return user.is_authenticated and user.is_super_admin()


class unauthenticated_user(BaseAuthenticatedDecorator):
    def check_unauthenticated_user(self):
        return self.request.user.is_authenticated
