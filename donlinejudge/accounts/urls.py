from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from accounts.views import public, admin

urlpatterns = [
    path('register/', public.RegisterAPI.as_view()),
    path('login/', public.LoginAPI.as_view()),
    # path('announcement/<int:id>/', public.AnnouncementDetailAPI.as_view()),
    path('admin/userlist/', admin.UserAPI.as_view()),
    # path('admin/announcement/<int:id>/', admin.AnnouncementDetailAdminAPI.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)