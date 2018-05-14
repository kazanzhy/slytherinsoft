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
cd slytherinsoft
#virtualenv $(pwd)/venv
source $(pwd)/venv/bin/activate

#git checkout dima
sudo pip3 install --upgrade pip
sudo pip3 install -r requirements.txt
#sudo mysql -u root -p < script.sql
#sudo python3 manage.py makemigrations
#sudo python3 manage.py migrate

sudo gunicorn testdj.wsgi:application --bind 127.0.0.1:8080


