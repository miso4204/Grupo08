from django.shortcuts import render_to_response
from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.contrib import auth
from django.core.context_processors import csrf

#Custom 

from account.forms import RegisterForm
from django.contrib.auth.models import User

def login(request):
	c = {}
	c.update(csrf(request))
	return render_to_response('account/login.html', c)

def auth_view(request):
	username = request.POST.get('username', '')
	password = request.POST.get('password', '')
	user = auth.authenticate(username=username, password=password)

	if user is not None:
		auth.login(request, user)
		return HttpResponseRedirect('/account/loggedin')
	else:
		return HttpResponseRedirect('/account/invalid')

def loggedin(request):
	return render_to_response('account/loggedin.html', {'full_name': request.user.username})

def invalid_login(request):
	return render_to_response('account/invalid_login.html')

def logout(request):
	auth.logout(request)
	return render_to_response('account/logout.html')

def register(request):
	if request.method == 'POST':
		form = RegisterForm(request.POST)
		if form.is_valid():

			username = form.cleaned_data['username']
			name = form.cleaned_data['name']
			last_name = form.cleaned_data['last_name']
			email = form.cleaned_data['email']
			password = form.cleaned_data['password']

			user = User.objects.create_user(username=username, email=email, password=password)
			user.first_name = name
			user.last_name = last_name
			
			user.save()

			return HttpResponseRedirect('/account/login/')
	else:
		form = RegisterForm()
	return render(request, 'account/register.html', {'form': form})

