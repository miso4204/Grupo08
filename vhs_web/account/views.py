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
				'fullName': full_name,
				'archivo': archivo
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
		
	
