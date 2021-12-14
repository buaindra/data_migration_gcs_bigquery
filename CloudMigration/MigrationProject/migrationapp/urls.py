from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('cloud_connect/', views.cloud_connect_add, name='cloud_connect'),
    path('cc_delete/<int:id>/', views.cloud_connect_delete, name='cloud_connect_del'),
    path('cc_details/<int:id>/', views.cloud_connect_details, name='cloud_connect_details'),
]