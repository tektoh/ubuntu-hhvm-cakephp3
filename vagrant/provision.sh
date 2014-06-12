#!/bin/sh

if [ ! -e /share/app ]; then
  cd /share
  yes | composer create-project -s dev cakephp/app app
else
  cd /share/app
  if [ ! -e composer.lock ]; then
    composer install
  else
    composer update
  fi
fi

sudo cp /share/vagrant/cakephp.conf /etc/nginx/sites-available/cakephp.conf
sudo ln -s -f /etc/nginx/sites-available/cakephp.conf /etc/nginx/sites-enabled/cakephp.conf

sudo service nginx restart
sudo update-rc.d nginx defaults

sudo service hhvm restart
sudo update-rc.d hhvm defaults

sudo service mysql restart
sudo update-rc.d mysql defaults

mysql -u root -psecret -e "create database my_app default charset utf8"
mysql -u root -psecret -e "create database test_my_app default charset utf8"
mysql -u root -psecret -e "GRANT ALL PRIVILEGES ON *.* TO 'my_app'@'localhost' IDENTIFIED BY 'secret' WITH GRANT OPTION;"

exit 0
