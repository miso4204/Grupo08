from django.conf.urls import patterns, url

from report import views

urlpatterns = patterns('',
	
	url(r'^rating/$', views.rating_report),
	url(r'^sale/$', views.sale_report),

)