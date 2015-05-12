# -*- encoding: utf-8 -*-
from django.shortcuts import render
from django.conf import settings

# Custom

from account.views import *

def listar_productos(request):
	# if esta_autenticado(request):

	#Realizar el llamado al método REST para obtener la información

	# try:
	# 	url = settings.CUSTOM_BASE_URL + '/VhsBackEndServices/webresources'
	# 	method = 'vhsspecialoffer'
	# 	username = request.session['mail_usuario'] #"andresvargasr@gmail.com"

	# 	response = requests.get('{0}/{1}/{2}'.format(url, method, username))
	# except Exception, e:
	# 	raise e

	# Manual

	try:
		productos = [
			{
				'name': 'Paquete Cartagena', 
				'description': 'El paquete contiene tiquetes aereos + alojamiento para 2 durante 7 dias',
				'price': 120000,
				'image': 'http://www.ikea.com/ms/media/seorange/20151/20151_besr01a_hemnes_PH121213.jpg'
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

	# Manejo de la respuesta
	
	# try:
	# 		if response.status_code == 200:
	# 			root =  ElementTree.XML(response.text)
				
	# 			listado_productos = {}
	# 			for infoRating in root:
	# 				listado_productos[infoRating[1].text] = float(infoRating[0].text)

	# except Exception, e:
	# 	raise e

	return render(request, 'product/productos.html', { 'response': True,  'productos': productos })

	# return render(request, 'product/productos.html', { 'response': False })
