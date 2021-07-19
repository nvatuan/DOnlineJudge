from django.core.validators import RegexValidator

alphanumeric = RegexValidator(r'^[0-9a-zA-Z]*$', 'Only alphanumeric characters are allowed.')
lowerAlphanumeric = RegexValidator(r'^[0-9a-z]*$', 'Only lowercase alphanumeric characters are allowed.')