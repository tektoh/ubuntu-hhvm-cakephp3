#!/bin/sh

COMPOSER="hhvm -v ResourceLimit.SocketDefaultTimeout=30 -v Http.SlowQueryThreshold=30000 -v Eval.Jit=false /usr/local/bin/composer"

if [ ! -e /share/app ]; then
  cd /share
  yes | $COMPOSER create-project -s dev cakephp/app app
else
  cd /share/app
  if [ ! -e composer.lock ]; then
    $COMPOSER install
  else
    $COMPOSER update
  fi
fi

mkdir -p /share/app/tmp/{logs,sessions,tests} /share/app/tmp/cache/{models,persistent,views}

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
