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
			
			email = form.cleaned_data['email']
			password = form.cleaned_data['password']
			full_name = form.cleaned_data['name']

			archivo = request.FILES['file']

			archivo = [line.strip() for line in archivo]

			url = 'http://jbossasvhsbackendservices-vhstourism.rhcloud.com/VhsBackEndServices/webresources/vhsuser/'
			
			data = { 
				'mail': email,
				'password': password,
				'fullName': full_name
				# 'archivo': archivo
			}
			headers = {'Content-Type': 'application/json'}
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
	# if esta_autenticado(request):

	#Realizar el llamado al método REST para obtener la información

	# try:
	# 	url = 'http://jbossasvhsbackendservices-vhstourism.rhcloud.com/VhsBackEndServices/webresources'
	# 	method = 'vhsspecialoffer'
	# 	username = request.session['mail_usuario'] #"andresvargasr@gmail.com"

	# 	response = requests.get('{0}/{1}/{2}'.format(url, method, username))
	# except Exception, e:
	# 	raise e

	# Manual

	try:
		listado_usuarios = [
			{
				'name': 'Ernesto Nobmann', 
				'email': 'ef.nobmann10@uniandes.edu.co',
				'features': [
					'f1': True,
					'f2': False,
					'f3': True
				]
			},
			{
				'name': 'Paquete Santa Marta', 
				'description': 'Nota: El paquete NO incluye tiquetes aereos. Incluye alojamiento en hotel 5 estrellas para 5 personas 3 noches y 4 dias.',
				'price': 120000,
				'image': 'http://www.ikea.com/us/en/images/products/karit-bedspread-and-cushion-covers-turquoise__0143940_PE303324_S4.JPG'
			},
			{
				'name': 'Paquete Amazonas', 
				'description': 'El paquete incluye viaje a isla de los micos, avistamiento de delfines y alojamiento por 10 dias para 2 personas.',
				'price': 120000,
				'image': 'http://www.ikea.com/us/en/images/products/nockeby-sofa-brown__0250428_PE388702_S4.JPG'
			},
			{
				'name': 'Paquete San Andres', 
				'description': 'El paquete incluye viaje a isla de los micos, avistamiento de delfines y alojamiento por 10 dias para 2 personas.',
				'price': 120000,
				'image': 'http://www.ikea.com/us/en/media/categories/bedroom__bedroom_lighting_160_PE364867.jpg'
			}
		]

	except Exception, e:
		print 'Error generando el listado de productos'
		raise e
	return render_to_response('account/allUsers.html')
		
	
