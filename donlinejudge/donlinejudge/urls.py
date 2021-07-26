from django.urls import include, path
from django.conf import settings
from django.conf.urls.static import static

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('', include('announcement.urls')),
    path('', include('accounts.urls')),
    path('', include('authenticate.urls')),
    path('', include('problem.urls')),
    path('', include('submission.urls')),
    path('', include('judgeserver.urls')),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
