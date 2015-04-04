from django.shortcuts import render_to_response
from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.contrib import auth
from django.core.context_processors import csrf

#Custom 

import requests
from xml.etree import ElementTree

def rating_report(request):
	
	return render_to_response('report/rating_report.html')
