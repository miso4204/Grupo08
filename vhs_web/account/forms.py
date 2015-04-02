from django import forms

class RegisterForm(forms.Form):

	username = forms.CharField(max_length=100)
	name = forms.CharField(max_length=100)
	last_name = forms.CharField(max_length=100)
	email = forms.EmailField()
	password = forms.CharField(widget=forms.PasswordInput)

    # subject = forms.CharField(max_length=100)
    # message = forms.CharField(widget=forms.Textarea)
    # sender = forms.EmailField()
    # cc_myself = forms.BooleanField(required=False)