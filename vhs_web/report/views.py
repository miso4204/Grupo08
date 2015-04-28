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
from datetime import datetime, timedelta

#Custom 

from account.views import *
from report.forms import RatingForm


def rating_report_package(request):

	if esta_autenticado(request):

		fecha_inicio = ''
		fecha_fin = ''

		if request.method == 'POST':

			form = RatingForm(request.POST)

			if form.is_valid():
				fecha_inicio = form.cleaned_data['start_date']
				fecha_fin = form.cleaned_data['end_date']
				
		# date = {'date': '03/04/2015 11:58:00 PM'}
		date = datetime.today().strftime('%d/%m/%Y %I:%M:%S %p')
		
		url = 'http://jbossasvhsbackendservices-vhstourism.rhcloud.com/VhsBackEndServices/webresources'
		method = 'vhsofferrating'
		username = request.session['mail_usuario'] #"andresvargasr@gmail.com"

		# Se convierten a Date, esto se debe mejorar

		if fecha_inicio == '':
			fecha_fin = datetime.today()
			fecha_inicio = fecha_fin - timedelta(days=10)
		else:
			fecha_inicio = datetime.strptime(fecha_inicio, '%d/%m/%Y')
			fecha_fin = datetime.strptime(fecha_fin, '%d/%m/%Y')
	
		# Se convierten a String

		fecha_fin = fecha_fin.strftime('%d%m%Y')
		fecha_inicio = fecha_inicio.strftime('%d%m%Y')

		response = requests.get('{0}/{1}/{2}/{3}/{4}/product'.format(url, method, username, fecha_inicio, fecha_fin))

		try:
			if response.status_code == 200:
				root =  ElementTree.XML(response.text)
				
				listado_productos = {}
				for infoRating in root:
					listado_productos[infoRating[1].text] = float(infoRating[0].text)

		except Exception, e:
			raise e

		mejores_10 = sorted(listado_productos.iteritems(), key=lambda (k, v): (-v, k))[:10]
		peores_10 = sorted(listado_productos.iteritems(), key=lambda (k, v): (v, k))[:10]
		
		mejores_10 = dict(mejores_10)
		mejores_ciudades = mejores_10.keys()
		mejores_calificaciones = mejores_10.values()

		peores_10 = dict(peores_10)
		peores_ciudades = peores_10.keys()
		peores_calificaciones = peores_10.values()

		return render(request, 'report/rating_report_package.html', {'mejores_ciudades': mejores_ciudades, 
			'mejores_calificaciones': mejores_calificaciones, 
			'peores_ciudades': peores_ciudades,
			'peores_calificaciones': peores_calificaciones,
			'fecha': str(date) })
		
	else:
		form = LoginForm(request.POST)
		form.add_error(None, "Please enter your username and password")
		return render(request, 'account/login.html', {'form': form})

def rating_report_location(request):

	if esta_autenticado(request):

		fecha_inicio = ''
		fecha_fin = ''

		if request.method == 'POST':

			form = RatingForm(request.POST)

			if form.is_valid():
				fecha_inicio = form.cleaned_data['start_date']
				fecha_fin = form.cleaned_data['end_date']
				
		# date = {'date': '03/04/2015 11:58:00 PM'}
		date = datetime.today().strftime('%d/%m/%Y %I:%M:%S %p')

		# ToDo: El metodo puede que cambie dependiendo del servicio
		
		url = 'http://jbossasvhsbackendservices-vhstourism.rhcloud.com/VhsBackEndServices/webresources'
		method = 'vhsofferrating'
		username = request.session['mail_usuario'] #"andresvargasr@gmail.com"

		# Se convierten a Date, esto se debe mejorar

		if fecha_inicio == '':
			fecha_fin = datetime.today()
			fecha_inicio = fecha_fin - timedelta(days=10)
		else:
			fecha_inicio = datetime.strptime(fecha_inicio, '%d/%m/%Y')
			fecha_fin = datetime.strptime(fecha_fin, '%d/%m/%Y')
	
		# Se convierten a String

		fecha_fin = fecha_fin.strftime('%d%m%Y')
		fecha_inicio = fecha_inicio.strftime('%d%m%Y')

		response = requests.get('{0}/{1}/{2}/{3}/{4}/location'.format(url, method, username, fecha_inicio, fecha_fin))

		try:
			if response.status_code == 200:
				root =  ElementTree.XML(response.text)
				
				listado_productos = {}
				for infoRating in root:
					listado_productos[infoRating[1].text] = float(infoRating[0].text)

		except Exception, e:
			raise e

		mejores_10 = sorted(listado_productos.iteritems(), key=lambda (k, v): (-v, k))[:10]
		peores_10 = sorted(listado_productos.iteritems(), key=lambda (k, v): (v, k))[:10]
		
		mejores_10 = dict(mejores_10)
		mejores_ciudades = mejores_10.keys()
		mejores_calificaciones = mejores_10.values()

		peores_10 = dict(peores_10)
		peores_ciudades = peores_10.keys()
		peores_calificaciones = peores_10.values()

		return render(request, 'report/rating_report_location.html', {'mejores_ciudades': mejores_ciudades, 
			'mejores_calificaciones': mejores_calificaciones, 
			'peores_ciudades': peores_ciudades,
			'peores_calificaciones': peores_calificaciones,
			'fecha': str(date) })
		
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
