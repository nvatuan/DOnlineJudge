from django.urls import include, path

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('', include('example.urls')),
    path('', include('announcement.urls')),
    path('', include('accounts.urls')),
    path('', include('problem.urls')),
    # path('', include('submission.urls')),
]
