from submission.models import Submission
from rest_framework import serializers

class SubmissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Submission 
        fields = [
            'id',

            'problem', 'author', 'submit_time',

            'content', 'language',

            'verdict', 'output',
        ]