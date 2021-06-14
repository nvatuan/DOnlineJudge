from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
#from announcement.views import public, admin
from announcement.views import api

urlpatterns = [
    path('announcement/', api.AnnouncementAPI.as_view()),
    path('announcement/<int:id>/', api.AnnouncementDetailAPI.as_view()),
    path('admin/announcement/', api.AnnouncementAPI.as_view()),
    path('admin/announcement/<int:id>/', api.AnnouncementDetailAPI.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)