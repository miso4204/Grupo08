from django.shortcuts import render_to_response
from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.contrib import auth
from django.core.context_processors import csrf
from xml.etree import ElementTree
from django.http import HttpResponse
import requests
import json
import operator

#Custom 

from account.views import *


def rating_report(request):

	if esta_autenticado(request):

		date = {'date': '03/04/2015 11:58:00 PM'}

		listado_productos = {
			"Paquete San Andres": 3.3,
			"Paquete Barranquilla": 4.3,
			"Paquete Cartagena": 3.8,
			"Paquete Santa Marta": 3,
			"Paquete Amazonas": 4.9
		}

		mejores_10 = sorted(listado_productos.iteritems(), key=lambda (k, v): (-v, k))[:10]
		peores_10 = sorted(listado_productos.iteritems(), key=lambda (k, v): (v, k))[:10]
		
		mejores_10 = dict(mejores_10)
		mejores_ciudades = mejores_10.keys()
		mejores_calificaciones = mejores_10.values()

		peores_10 = dict(peores_10)
		peores_ciudades = peores_10.keys()
		peores_calificaciones = peores_10.values()

		# Tambien se debe recibir el parametro de fecha
		
		return render(request, 'report/rating_report.html', {'mejores_ciudades': mejores_ciudades, 
			'mejores_calificaciones': mejores_calificaciones, 
			'peores_ciudades': peores_ciudades,
			'peores_calificaciones': peores_calificaciones,
			'fecha': date })
	else:
		form = LoginForm(request.POST)
		form.add_error(None, "Please enter your username and password")
		return render(request, 'account/login.html', {'form': form})

def sale_report(request):

	if esta_autenticado(request):
	
		date = {'date': '03/04/2015 11:58:00 PM'}

		ventas_mes = [{
				'name': '# de ventas',
				'data': [138, 232, 625, 357,65,90,41,987,984,729,847,859]
			}
		]

		ventas_semana = [{
				'name': '# de ventas',
				'data': [2,8,4,3,4,8,7]
			}
		]
		
		return render(request, 'report/sale_report.html', 
			{'data_mes': json.dumps(ventas_mes), 'data_semana': json.dumps(ventas_semana), 'fecha': date })
	else:
		form = LoginForm(request.POST)
		form.add_error(None, "Please enter your username and password")
		return render(request, 'account/login.html', {'form': form})
