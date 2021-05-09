from problem.models import Problem, ProblemTag
from rest_framework import serializers

class ProblemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Problem
        fields = [
            'id',
            'display_id', 'created', 'visible', 'author',

            'title', 'statement',
            'difficulty', 'tags', 'source',

            'sample_test',

            'time_limit', 'memory_limit',

            'total_submission', 'correct_submission',
            'statistic_info'
        ]

class ProblemTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProblemTag
        fields = "__all__"