from django import forms

class CodeForm(forms.Form):
    source_code = forms.CharField(widget=forms.Textarea)
    lang = forms.CharField(max_length=50)
    inputs = forms.CharField(widget=forms.Textarea)
    answer = forms.CharField(widget=forms.Textarea)

