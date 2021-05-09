from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from problem.views import public, admin

urlpatterns = [
    path('problem/', public.ProblemAPI.as_view()),
    path('problem/<int:id>/', public.ProblemDetailAPI.as_view()),

    path('problem_tag/', public.ProblemTagAPI.as_view()),
    path('problem_tag/<int:id>/', public.ProblemTagDetailAPI.as_view()),

    path('admin/problem/', admin.ProblemAPI.as_view()),
    path('admin/problem/<int:id>/', admin.ProblemDetailAPI.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)