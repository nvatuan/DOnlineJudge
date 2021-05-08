from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from submission.views import public, admin

urlpatterns = [
    path('status/', public.SubmissionAPI.as_view()),
    path('status/<int:id>/', public.SubmissionDetailAPI.as_view()),

    path('admin/status/', admin.SubmissionAPI.as_view()),
    path('admin/status/<int:id>/', admin.SubmissionDetailAPI.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)