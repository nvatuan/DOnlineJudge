from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from accounts.views import public, admin

urlpatterns = [
    path('register/', public.RegisterAPI.as_view()),
    path('profile/', public.OwnProfilePageAPI.as_view()),
    path('profile/<int:id>', public.ProfilePageAPI.as_view()),

    path('login/', public.LoginAPI.as_view()),
    path('logout/', public.LogoutAPI.as_view()),

    path('admin/users/', admin.UserAPI.as_view()),
    path('admin/users/<int:id>', admin.UserDetailAPI.as_view()),
    path('admin/login/', admin.LoginAPI.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)