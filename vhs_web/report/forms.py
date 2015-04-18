from django import forms

class RatingForm(forms.Form):
	# start_date = forms.DateField(required = False, input_formats='%d/%m/%Y')
	# end_date = forms.DateField(required = False, input_formats='%d/%m/%Y')
	start_date = forms.CharField(max_length=100, required = False)
	end_date = forms.CharField(max_length=100, required = False)