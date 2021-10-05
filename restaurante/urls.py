
from django.urls import path, include
from rest_framework import status
from django.conf.urls.static import static
from django.conf import settings
from django.contrib import admin

urlpatterns = [
    path('admin/', admin.site.urls),
    path('cms/', include('cms.urls')),
    path('facturacion/', include('facturacion.urls')),
]+ static(settings.MEDIA_URL,document_root= settings.MEDIA_ROOT)
# document_root = es contenido que renderizara cuando se llama a determinada ruta con su nombre de archivo
