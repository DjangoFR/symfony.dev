#!/bin/bash

docker-compose run php-fpm "/symfony-install.sh"
docker-compose run php-fpm composer install -d /var/www/symfony

sudo chown $USER.$USER symfony -R


echo -e "\n    * Run your application:"
echo -e "\n        - Browse to the http://symfony.dev URL.\n\n"
