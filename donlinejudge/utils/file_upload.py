import os
from uuid import uuid4

class FileUploadUtils:
    def __init__(self):
        pass

    def _wrapper(self, instance, filename):
        ext = filename.split('.')[-1]
        if instance.pk and not self.generate_uuid:
            filename = '{}.{}'.format(instance.pk, ext)
        else:
            filename = '{}.{}'.format(uuid4().hex, ext)
        return os.path.join(self.path, filename)

    def upload_to_path_and_rename(self, path, generate_uuid=False):
        """
        Upload the image to relative `path`.
        The file is renamed by the rule described in the code
        """
        self.path = path
        self.generate_uuid = generate_uuid
        return self._wrapper # django raise import not found
