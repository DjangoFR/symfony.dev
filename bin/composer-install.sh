#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $SCRIPT_DIR/lib.sh

docker-compose run php-fpm /bin/bash -c "cd /var/www/symfony/ && composer install"

sudo chown $USER.$USER symfony -R

