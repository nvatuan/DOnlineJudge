from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
#from problem.views import public, admin
from problem.views import api

urlpatterns = [
    path('problem/', api.ProblemAPI.as_view()),
    path('problem/<int:id>/', api.ProblemDetailAPI.as_view()),

    path('problem_tag/', api.ProblemTagAPI.as_view()),
    path('problem_tag/<int:id>/', api.ProblemTagDetailAPI.as_view()),

    path('admin/problem/', api.ProblemAPI.as_view()),
    path('admin/problem/<int:id>/', api.ProblemDetailAPI.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)