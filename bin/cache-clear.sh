#!/bin/bash

docker-compose run php-fpm /usr/bin/php /var/www/symfony/app/console cache:clear

sudo chmod 777 symfony/app/cache/*
