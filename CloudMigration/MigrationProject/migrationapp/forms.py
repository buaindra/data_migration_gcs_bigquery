from django import forms
from django.forms import ModelForm
from .models import Cloud_Connect


class Cloud_ConnectForm(ModelForm):
    class Meta:
        model = Cloud_Connect
        # fields = '__all__'
        fields = ['cloudName', 'projectName', 'cloudServiceKeyLoc']
        widgets = {
            #'cloudName': forms.TextInput(attrs={'class': 'form-control'}),
            'projectName': forms.TextInput(attrs={'class': 'form-control'}),
            'cloudServiceKeyLoc': forms.TextInput(attrs={'class': 'form-control'}),
        }
