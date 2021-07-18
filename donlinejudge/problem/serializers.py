from problem.models import Problem, ProblemTag
from rest_framework import serializers

class ProblemTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProblemTag
        fields = '__all__'

class ProblemSerializer(serializers.ModelSerializer):
    author_name = serializers.ReadOnlyField()
    author_id = serializers.ReadOnlyField()

    tags = ProblemTagSerializer(many=True, read_only=True)

    class Meta:
        model = Problem
        fields = [
            'id',
            'display_id', 'created', 'visible', 
            'author_id', 'author_name',

            'title', 'statement',
            'difficulty', 'tags', 'source',

            'sample_test',

            'time_limit', 'memory_limit',

            'total_submission', 'correct_submission',
            'statistic_info'
        ]

class ProblemBriefSerializer(serializers.ModelSerializer):
    tags = ProblemTagSerializer(many=True, read_only=True)

    class Meta:
        model = Problem
        fields = [
            'id', 'display_id',  
            'title', 'difficulty', 
            'visible', 'tags',
        ]

