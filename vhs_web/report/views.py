from django.shortcuts import render_to_response
from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.contrib import auth
from django.core.context_processors import csrf

#Custom 

import requests
from xml.etree import ElementTree
import json
from django.http import HttpResponse

def rating_report(request):

	date = {'date': '03/04/2015 11:58:00 PM'}

	listado_productos = [{
			'name': 'Bogota',
			'data': [0,1,0,0,4,0,6,7,8,9]
		}, {
			'name': 'Barranquilla',
			'data': [0,1,0,0,0,5,6,7,16,9]
		}, {
			'name': 'Cartagena',
			'data': [0,2,2,0,0,10,6,0,0,0]
		}, {
			'name': 'Santa Marta',
			'data': [0,0,0,6,4,0,6,0,8,18]
	}]
	data = json.dumps(listado_productos)

	return render(request, 'report/rating_report.html', {'data': data, 'fecha': date })