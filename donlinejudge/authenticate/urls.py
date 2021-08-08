from django.urls import path
from authenticate.views import api

urlpatterns = [
    path('test-token/', api.TestTokenAPI.as_view()),
]

#urlpatterns = format_suffix_patterns(urlpatterns)