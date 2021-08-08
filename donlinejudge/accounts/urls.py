from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from accounts.views import api

urlpatterns = [
    path('register/', api.RegisterAPI.as_view()),
    path('profile/', api.OwnProfilePageAPI.as_view()),
    path('profile/<int:id>', api.ProfilePageAPI.as_view()),
    path('profile/change-password/', api.ChangePasswordAPI().as_view()),

    path('login/', api.LoginAPI.as_view()),
    path('logout/', api.LogoutAPI.as_view()),

    path('admin/users/', api.UserAPI.as_view()),
    path('admin/users/<int:id>', api.UserDetailAPI.as_view()),
]

#urlpatterns = format_suffix_patterns(urlpatterns)