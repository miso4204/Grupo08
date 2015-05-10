from django.conf.urls import patterns, url

from product import views

urlpatterns = patterns('',
	
	url(r'^all/$', views.listar_productos),

)