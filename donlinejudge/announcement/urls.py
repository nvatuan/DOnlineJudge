from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from announcement.views import public, admin

urlpatterns = [
    path('announcement/', public.AnnouncementAPI.as_view()),
    path('announcement/<int:id>/', public.AnnouncementDetailAPI.as_view()),
    path('admin/announcement/', admin.AnnouncementAdminAPI.as_view()),
    path('admin/announcement/<int:id>/', admin.AnnouncementDetailAdminAPI.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)