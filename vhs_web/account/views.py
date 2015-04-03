from django.shortcuts import render_to_response
from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.contrib import auth
from django.core.context_processors import csrf

#Custom 

from account.forms import RegisterForm, LoginForm
from django.contrib.auth.models import User
import requests
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

			username = form.cleaned_data['username'] # username = 'andresvargasr@gmail.com'
			password = form.cleaned_data['password'] # password = 'andres'

			response = requests.get('{0}/{1}/{2}/{3}'.format(url, method, username, password))

			if response.status_code == 200:
				element =  ElementTree.XML(response.text)	
				# Login ok
				return HttpResponseRedirect('/account/index')
			else:
				#Bad login
				form.add_error(None, "Login error: Please check your username and password")

				return render(request, 'account/login.html', {'form': form})
		else:
			form.add_error(None, "Login form is invalid.")
	else:
		form = LoginForm()
	return render(request, 'account/login.html', {'form': form})

def index(request):
	return render_to_response('account/index.html')

def logout(request):
	auth.logout(request)
	c = {}
	c.update(csrf(request))
	return render_to_response('account/login.html', c)

def register(request):
	
	if request.method == 'POST':
		
		form = RegisterForm(request.POST)
		if form.is_valid():

			username = form.cleaned_data['username']
			name = form.cleaned_data['name']
			last_name = form.cleaned_data['last_name']
			email = form.cleaned_data['email']
			password = form.cleaned_data['password']
			# Opciones de productos
			special_offer = form.cleaned_data['special_offer']
			money_administration = form.cleaned_data['money_administration']
			report = form.cleaned_data['report']
			social_network = form.cleaned_data['social_network']

			user = User.objects.create_user(username=username, email=email, password=password)
			user.first_name = name
			user.last_name = last_name
			
			user.save()

			return HttpResponseRedirect('/account/login/')
		else:
			form.add_error(None, "Register form is invalid.")
	else:
		form = RegisterForm()
	return render(request, 'account/register.html', {'form': form})