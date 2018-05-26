# /bin/bash
mysql -u root -p < howto/script.sql
./manage.py collectstatic
./manage.py makemigrations
./manage.py migrate
./manage.py createsuperuser --email '' --username admin


