from django.contrib import admin
from django.urls import path, include, reverse
from django.conf import settings
from django.conf.urls.static import static
from django.shortcuts import redirect

urlpatterns = [
    path("api/", include('core.urls')), # add this
    path('', lambda _: redirect('admin:index'), name='index'),
    path("admin/", admin.site.urls, name='django-admin'),
]

# add this
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
