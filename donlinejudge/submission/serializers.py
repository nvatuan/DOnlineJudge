from submission.models import Submission
from rest_framework import serializers

class SubmissionSerializer(serializers.ModelSerializer):
    problem_title = serializers.ReadOnlyField()
    problem_disp_id = serializers.ReadOnlyField()
    problem_id = serializers.ReadOnlyField()

    author_name = serializers.ReadOnlyField()
    author_id = serializers.ReadOnlyField()

    is_visible = serializers.ReadOnlyField()
    
    class Meta:
        model = Submission 
        exclude = ('problem', 'author',)
