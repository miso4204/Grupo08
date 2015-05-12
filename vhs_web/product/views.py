# -*- encoding: utf-8 -*-
from django.shortcuts import render
from django.conf import settings

# Custom

from account.views import *
from xml.etree import ElementTree
import xmltodict

def listar_productos(request):

	productos = []

	if esta_autenticado(request):

		#Realizar el llamado al método REST para obtener la información

		try:
			url = settings.CUSTOM_BASE_URL + '/VhsBackEndServices/webresources'
			method = 'vhsspecialoffer'
			
			response = requests.get('{0}/{1}/'.format(url, method))

			if response.status_code == 200:
				tree = xmltodict.parse(response.text)['collection']['vhsSpecialOffer']

				for element in tree:
					producto = {}
					try:
						# Defaults

						producto['name'] = 'No Name'
						producto['description'] = 'No Description'
						producto['price'] = 0
						producto['image'] = 'http://www.ikea.com/ms/media/seorange/20151/20151_besr01a_hemnes_PH121213.jpg'

						# Defining...

						producto['name'] = element['shortName']
						producto['description'] = element['description']
						producto['price'] = element['price']
						producto['image'] = element['mainImageUrl']

					except Exception, e:
						raise e
					finally:
						productos.append(producto)
				
				print productos	

		except Exception, e:
			raise e
		return render(request, 'product/productos.html', { 'response': True,  'productos': productos })
	else:
		form = LoginForm(request.POST)
		form.add_error(None, "Please enter your username and password")
		return render(request, 'account/login.html', {'form': form})
