from django.forms import ModelForm
from problem.models import Problem, ProblemDifficulty
from django.core.exceptions import ValidationError
from utils.validators import lowerAlphanumeric
from django.utils.translation import ugettext_lazy as _

class ProblemForm(ModelForm):
    class Meta:
        nctype="multipart/form-data"
        model = Problem
        fields = ['display_id', 'is_visible',
                'title', 'statement',
                'difficulty', 
                'sample_test',
                'test_zip',
                'time_limit', 'memory_limit'
                ]

    def clean(self):
        cdata = super().clean()
        print("Forms data", self.data)
        print("Forms cleandata", cdata)

        try:
            # Clean display_id
            try:
                lowerAlphanumeric(cdata['display_id'].lower())
            except:
                raise ValidationError(
                    _('display_id should only contains lowercase alphabet character or digits'),
                    code='invalid',
                )

            # Clean is_visible
            if cdata['is_visible'] not in [True, False]:
                raise KeyError('is_visible')
            # Clean difficulty
            if cdata['difficulty'] not in ProblemDifficulty.DIFF:
                raise KeyError('difficulty')
            # Clean sample_test
            good_sample_elem = {'input':'','output':''}
            for obj in cdata['sample_test']:
                if obj.keys() != good_sample_elem.keys():
                    alien = (obj.key()-good_sample_elem.keys())[0]
                    raise ValidationError(
                        _('Invalid key-value pair in sample_test array: %(key)s: %(value)s'),
                        code='invalid',
                        params={
                            'key': alien,
                            'value': obj[alien],
                        },
                    )
            # Clean test_zip
            # ??

            # Clean time_limit
            if cdata['time_limit'] < 500:
                raise ValidationError(
                    _('time_limit cannot be less than 500ms'),
                    code='invalid',
                )

            # Clean memory limit 
            if cdata['memory_limit'] < 1:
                raise ValidationError(
                    _('memory_limit cannot be less than 1MB'),
                    code='invalid',
                )
        except KeyError as ke:
            raise ValidationError(
                _('Invalid value for %(keyname)s: %(value)s'),
                code='invalid',
                params={
                    'keyname': ke,
                    'value': self.data.get(ke)
                },
            )

class ProblemPutForm(ModelForm):
    class Meta:
        nctype="multipart/form-data"
        model = Problem
        fields = [#'display_id',
                'is_visible',
                'title', 'statement',
                'difficulty', 
                'sample_test',
                'test_zip',
                'time_limit', 'memory_limit'
        ]
    def clean(self):
        cdata = super().clean()

        try:
            # Clean is_visible
            if cdata['is_visible'] not in [True, False]:
                raise KeyError('is_visible')
            # Clean difficulty
            if cdata['difficulty'] not in ProblemDifficulty.DIFF:
                raise KeyError('difficulty')
            # Clean sample_test
            good_sample_elem = {'input':'','output':''}
            for obj in cdata['sample_test']:
                if obj.keys() != good_sample_elem.keys():
                    alien = (obj.key()-good_sample_elem.keys())[0]
                    raise ValidationError(
                        _('Invalid key-value pair in sample_test array: %(key)s: %(value)s'),
                        code='invalid',
                        params={
                            'key': alien,
                            'value': obj[alien],
                        },
                    )
            # Clean test_zip
            # ??

            # Clean time_limit
            if cdata['time_limit'] < 500:
                raise ValidationError(
                    _('time_limit cannot be less than 500ms'),
                    code='invalid',
                )

            # Clean memory limit 
            if cdata['memory_limit'] < 1:
                raise ValidationError(
                    _('memory_limit cannot be less than 1MB'),
                    code='invalid',
                )
        except KeyError as ke:
            raise ValidationError(
                _('Invalid value for %(keyname)s: %(value)s'),
                code='invalid',
                params={
                    'keyname': ke,
                    'value': self.data.get(ke)
                },
            )
