#!/bin/bash

echo "This will DESTROY all data. Type '1' to confirm, '2' to cancle."
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) echo "Aborted"; exit;;
    esac
done

echo "Attempting"
pip install django_extensions

python manage.py clear_cache
python manage.py clean_pyc
python manage.py reset_db 
python manage.py reset_schema

MODELS = ("annoucement" "account" "problem" "submission")
for m in ${MODELS[@]}; do
    if [ -d "$m/migrations" ]; then
        rm -rf "$m/migrations"
    fi

    mkdir "$m/migration"
    touch "$m/migration/__init__.py"
done

python manage.py makemigrations
python manage.py migrate
