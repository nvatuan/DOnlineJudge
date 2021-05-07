from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from problem import views

urlpatterns = [
    path('problem/', views.ProblemList.as_view()),
    # path('problem/<int:pk>/', views.snippet_detail),
]

urlpatterns = format_suffix_patterns(urlpatterns)