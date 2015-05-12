from django.conf.urls import patterns, url

from report import views

urlpatterns = patterns('',
	
	url(r'^ratingPackage/$', views.rating_report_package),
	url(r'^ratingLocation/$', views.rating_report_location),
	url(r'^salesLocation/$', views.sales_report_location),
	url(r'^salesPeriod/$', views.sales_report_period),
)