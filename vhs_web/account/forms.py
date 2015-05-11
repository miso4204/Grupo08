from django import forms

class RegisterForm(forms.Form):

	name = forms.CharField(max_length=100, required = True)
	email = forms.EmailField(required = True)
	password = forms.CharField(widget=forms.PasswordInput, required = True)
	# Opciones de productos
	special_offer = forms.BooleanField(required=False)
	currency_administration = forms.BooleanField(required=False)
	rating_report = forms.BooleanField(required=False)
	sale_report = forms.BooleanField(required=False)
	social_network = forms.BooleanField(required=False)
	location_search = forms.BooleanField(required=False)
	pay_on_delivery = forms.BooleanField(required=False)
	multimedia_video = forms.BooleanField(required=False)
	multimedia_image = forms.BooleanField(required=False)
	mobile = forms.BooleanField(required=False)
	maps = forms.BooleanField(required=False)
	scalability = forms.BooleanField(required=False)
	performance = forms.BooleanField(required=False)
	# Archivo
	file = forms.FileField()

class LoginForm(forms.Form):
	username = forms.CharField(max_length=100, required = True)
	password = forms.CharField(widget=forms.PasswordInput, required = True)