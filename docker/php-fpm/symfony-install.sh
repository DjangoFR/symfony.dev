#!/bin/bash

SYMFONY_INSTALL_DIR="/var/www/symfony"

# do NOTHING if project extsts
#-------------------------------------------------------------------------------
if [ -d "$SYMFONY_INSTALL_DIR" ]; then
  echo "--------------------------------------"
  echo "Symfony installation exists!"
  echo "--------------------------------------"
  exit 0;
fi

# install symfony
#-------------------------------------------------------------------------------
# use the most recent version in any Symfony branch
#$ symfony new my_project_name 2.8
#$ symfony new my_project_name 3.1

# use a specific Symfony version
#$ symfony new my_project_name 2.8.3
#$ symfony new my_project_name 3.1.5

# use a beta or RC version (useful for testing new Symfony versions)
#$ symfony new my_project 2.7.0-BETA1
#$ symfony new my_project 2.7.0-RC1

# use the most recent 'lts' version (Long Term Support version)
symfonyinstaller new "$SYMFONY_INSTALL_DIR" lts

rm -rf /var/www/symfony/app/cache/*