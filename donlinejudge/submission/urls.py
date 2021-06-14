from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
#from submission.views import public, admin
from submission.views import api

urlpatterns = [
    path('status/', api.SubmissionAPI.as_view()),
    path('status/<int:id>/', api.SubmissionDetailAPI.as_view()),

    path('admin/status/', api.SubmissionAPI.as_view()),
    path('admin/status/<int:id>/', api.SubmissionDetailAPI.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)