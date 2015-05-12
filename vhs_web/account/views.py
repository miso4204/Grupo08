# -*- encoding: utf-8 -*-
from django.shortcuts import render_to_response
from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.contrib import auth
from django.core.context_processors import csrf

#Custom 

from account.forms import RegisterForm, LoginForm
from django.contrib.auth.models import User
import requests
import json
from xml.etree import ElementTree
import xmltodict

def login(request):
	c = {}
	c.update(csrf(request))
	return render_to_response('account/login.html', c)

def auth_view(request):
	url = 'http://jbossasvhsbackendservices-vhstourism.rhcloud.com/VhsBackEndServices/webresources'
	method = 'vhsuser'

	if request.method == 'POST':
		
		form = LoginForm(request.POST)
		if form.is_valid():

			username = form.cleaned_data['username']
			password = form.cleaned_data['password']

			response = requests.get('{0}/{1}/{2}/{3}'.format(url, method, username, password))

			if response.status_code == 200:
				element =  ElementTree.XML(response.text)

				request.session['id_usuario'] = element[3].text
				request.session['mail_usuario'] = element[1].text
				
				# Login ok
				return HttpResponseRedirect('/account/index')
			else:
				#Bad login
				form.add_error(None, "Please check your username and password")

				return render(request, 'account/login.html', {'form': form})
		else:
			form.add_error(None, "Login form is invalid.")
	else:
		form = LoginForm()
	return render(request, 'account/login.html', {'form': form})

def index(request):
	if esta_autenticado(request):
		return render_to_response('account/index.html')
	else:
		form = LoginForm(request.POST)
		form.add_error(None, "Please enter your username and password")
		return render(request, 'account/login.html', {'form': form})

def logout(request):
	auth.logout(request)
	c = {}
	c.update(csrf(request))
	request.session['id_usuario'] = None
	return render_to_response('account/login.html', c)

def register(request):
	
	if request.method == 'POST':

		form = RegisterForm(request.POST, request.FILES)

		if form.is_valid():
			
			# Se lee lo escrito por el usaurio

			email = form.cleaned_data['email']
			password = form.cleaned_data['password']
			full_name = form.cleaned_data['name']
			archivo = request.FILES['file']

			# Se procede a generar variable 'feature' con las caracteristicas del archivo separadas por coma

			features = ''
			for line in archivo:
				features = features + line.strip() + ','

			# Se crea el diccionario a enviar

			data = { 
				'mail': email,
				'password': password,
				'fullName': full_name + '|' + features
			}

			# Se realiza conexión con el servicio

			url = 'http://192.168.0.199:8080/VhsBackEndServices/webresources/vhsuser/'
			headers = {'Content-Type': 'application/json'}
			print json.dumps(data)
			response = requests.post(url, data=json.dumps(data), headers=headers)

			return HttpResponseRedirect('/account/login/')
	else:
		form = RegisterForm()
	return render(request, 'account/register.html', {'form': form})

def esta_autenticado(request):
	if request.session.get('id_usuario'):
		id_usuario = request.session['id_usuario']
		return True
	return False

def allUsers(request):
	#Realizar el llamado al método REST para obtener la información

	try:
		url = 'http://192.168.0.199:8080/VhsBackEndServices/webresources/vhsuser/'
		# headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}
		# response = requests.get(url, headers=headers)
		response = requests.get(url)
	except Exception, e:
		raise e

	if response.status_code == 200:
		tree = xmltodict.parse(response.text)['collection']['vhsUser']

		usuarios = []

		for element in tree:
			usuario = {}
			try:

				# Setting defaults

				usuario['baseuser'] = 'false.png'
				usuario['name'] = 'No Name'
				usuario['email'] = 'No email'
				
				usuario['optionalFeatureCashPayOnDelivery'] = 'false.png'
				usuario['optionalFeatureGoogleMapsEnabled'] = 'false.png'
				usuario['optionalFeatureMobile'] = 'false.png'
				usuario['optionalFeatureMultimediaImages'] = 'false.png'
				usuario['optionalFeatureMultimediaVideo'] = 'false.png'
				usuario['optionalFeaturePerformance'] = 'false.png'
				usuario['optionalFeatureReportsByRating'] = 'false.png'
				usuario['optionalFeatureScalability'] = 'false.png'
				usuario['optionalFeatureSearchByLocation'] = 'false.png'

				# Obtaining info

				usuario['name'] = element['fullName']
				usuario['email'] = element['mail']
				usuario['baseuser'] = 'true.png' if (element['baseUser'] == 'true') else 'false.png'
				usuario['optionalFeatureCashPayOnDelivery'] = 'true.png' if (element['optionalFeatureCashPayOnDelivery'] == 'true') else 'false.png'
				usuario['optionalFeatureGoogleMapsEnabled'] = 'true.png' if (element['optionalFeatureGoogleMapsEnabled'] == 'true') else 'false.png'
				usuario['optionalFeatureMobile'] = 'true.png' if (element['optionalFeatureMobile'] == 'true') else 'false.png'
				usuario['optionalFeatureMultimediaImages'] = 'true.png' if (element['optionalFeatureMultimediaImages'] == 'true') else 'false.png'
				usuario['optionalFeatureMultimediaVideo'] = 'true.png' if (element['optionalFeatureMultimediaVideo'] == 'true') else 'false.png'
				usuario['optionalFeaturePerformance'] = 'true.png' if (element['optionalFeaturePerformance'] == 'true') else 'false.png'
				usuario['optionalFeatureReportsByRating'] = 'true.png' if (element['optionalFeatureReportsByRating'] == 'true') else 'false.png'
				usuario['optionalFeatureScalability'] = 'true.png' if (element['optionalFeatureScalability'] == 'true') else 'false.png'
				usuario['optionalFeatureSearchByLocation'] = 'true.png' if (element['optionalFeatureSearchByLocation'] == 'true') else 'false.png'

			except Exception, e:
				print 'No se encontro el parametro'
			finally:
				usuarios.append(usuario)

	# try:
	# 	listado_usuarios = [
	# 		{
	# 			'name': 'Ernesto Nobmann', 
	# 			'email': 'ef.nobmann10@uniandes.edu.co',
	# 			'features': {
	# 				'f1': True,
	# 				'f2': False,
	# 				'f3': True
	# 			}
	# 		}
	# 	]

	# except Exception, e:
	# 	print 'Error generando el listado de productos'
	# 	raise e
	return render_to_response('account/allUsers.html', {'usuarios': usuarios})
		
	
