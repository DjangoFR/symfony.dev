#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/lib.sh

docker-compose run php-fpm /usr/bin/php /var/www/symfony/app/console cache:clear
sudo rm -rf $SCRIPT_DIR/../symfony/app/cache/*
