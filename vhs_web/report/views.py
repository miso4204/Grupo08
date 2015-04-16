from django.shortcuts import render_to_response
from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.contrib import auth
from django.core.context_processors import csrf
from xml.etree import ElementTree
from django.http import HttpResponse
import requests
import json

#Custom 

from account.views import *


def rating_report(request):

	if esta_autenticado(request):

		date = {'date': '03/04/2015 11:58:00 PM'}

		listado_productos = [{
				'name': 'Paquete Bogota',
				'data': 3.3
			}, {
				'name': 'Paquete Barranquilla',
				'data': 4.3
			}, {
				'name': 'Paquete Cartagena',
				'data': 3.8
			}, {
				'name': 'Paquete Santa Marta',
				'data': 3
			}, {
				'name': 'Paquete Amazonas',
				'data': 4.9
		}]
		
		ciudades = []
		calificaciones = []
		for producto in listado_productos:
			ciudades.append(producto['name'])
			calificaciones.append(producto['data'])

		# Tambien se debe recibir el parametro de fecha
		
		return render(request, 'report/rating_report.html', {'ciudades': json.dumps(ciudades), 
			'calificaciones': json.dumps(calificaciones), 
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
