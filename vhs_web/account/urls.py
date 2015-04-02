from django.conf.urls import patterns, url

from account import views

urlpatterns = patterns('',
	
	url(r'^login/$', views.login),
	url(r'^auth/$', views.auth_view),
	url(r'^loggedin/$', views.loggedin),

	url(r'^logout/$', views.logout),
	url(r'^invalid/$', views.invalid_login),

)