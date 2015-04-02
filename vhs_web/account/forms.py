from django import forms

class RegisterForm(forms.Form):

	username = forms.CharField(max_length=100, required = True)
	name = forms.CharField(max_length=100, required = True)
	last_name = forms.CharField(max_length=100)
	email = forms.EmailField(required = True)
	password = forms.CharField(widget=forms.PasswordInput, required = True)
	# Opciones de productos
	special_offer = forms.BooleanField(required=False)
	money_administration = forms.BooleanField(required=False)
	report = forms.BooleanField(required=False)
	social_network = forms.BooleanField(required=False)
