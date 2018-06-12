#sudo apt update
#sudo apt upgrade
#sudo apt install python3
#sudo apt install git
#sudo apt install nginx 
#sudo apt install mysql-server 
#sudo apt install mysql-client
#sudo apt install python3-mysqldb 
#sudo apt install libmysqlclient-dev 
#sudo apt install python-dev
#sudo apt install python3-pip
#sudo pip3 install --upgrade pip
#sudo pip3 install launchpadlib
#sudo pip3 install virtualenv
#mkdir dataart

cd dataart

#git clone https://github.com/batwingsv/slytherinsoft.git

#virtualenv $(pwd)/venv --no-site-packages
source $(pwd)/venv/bin/activate

cd slytherinsoft
#git checkout dima

pip3 install --upgrade pip
pip3 install -r requirements.txt

#sudo mysql -u root -p < script.sql
#python3 manage.py makemigrations
#python3 manage.py migrate

#gunicorn testdj.wsgi:application --bind 127.0.0.1:8080 
#python3 manage.py runserver


