from django.core.validators import RegexValidator

alphanumeric = RegexValidator(r'^[0-9a-zA-Z]*$', 'Only alphanumeric characters are allowed.')
lowerAlphanumeric = RegexValidator(r'^[0-9a-z]*$', 'Only lowercase alphanumeric characters are allowed.')

class ImageExtensionValidator:
	VALID_IMAGE_EXTENSIONS = [
		".jpg", ".jpeg", ".png", ".gif",
	]

	def validate(path, extension_list=VALID_IMAGE_EXTENSIONS):
		return any([path.endswith(e) for e in extension_list])

class ZipExtensionValidator:
	def validate(path):
		return path.endswith(".zip")
