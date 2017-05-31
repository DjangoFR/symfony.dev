FROM ubuntu:16.04

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
# msodbcsql - accept license
ENV ACCEPT_EULA y

RUN apt-get update
RUN apt-get install -y apt-utils apt-transport-https curl wget nano zip git 
# MS SQL Server tools - sources
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-tools.list
RUN apt-get update

RUN apt-get install -y \
    php-fpm \
    php-apcu \
    php-curl \
    php-gd \
    php-iconv \
    php-imagick \
    php-json \
    php-intl \
    php-mcrypt \
    php-mysql \
    php-opcache \
    php-mysql \
    php-mysqli \
    php-mbstring \
    php-xml \
    php-xdebug \
    php-dev

RUN apt-get update
RUN apt-get install -y librsvg2-bin
# MS SQL Server tools - installation
# RUN apt-get install -y msodbcsql mssql-tools
RUN apt-get install -y msodbcsql unixodbc-dev mssql-tools

# sqlcmd needs (en_US.UTF-8) to run
RUN locale-gen en_US.UTF-8
#RUN locale-gen en_US.UTF-8 && update-locale LANG=de_DE.UTF-8

# MS SQL Server driver - build
RUN pecl install sqlsrv-4.0.8
RUN pecl install pdo_sqlsrv-4.0.8

# librdkafka installation
RUN apt-get update
RUN apt-get install -y librdkafka-dev

# php-rdkafka installation
RUN pecl install rdkafka
RUN echo "extension=rdkafka.so" >> /etc/php/7.0/cli/php.ini
RUN echo "extension=/usr/lib/php/20151012/rdkafka.so" >> /etc/php/7.0/mods-available/rdkafka.ini
RUN ln -s /etc/php/7.0/mods-available/rdkafka.ini /etc/php/7.0/fpm/conf.d/20-rdkafka.ini
RUN ln -s /etc/php/7.0/mods-available/rdkafka.ini /etc/php/7.0/cli/conf.d/20-rdkafka.ini

RUN echo "post_max_size=32M" >> /etc/php/7.0/cli/php.ini
RUN echo "post_max_size=32M" >> /etc/php/7.0/fpm/php.ini

#
# https://msdn.microsoft.com/en-us/library/hh568454(v=sql.110).aspx
# Enable the connection log by verifying that your
# odbcinst.ini file contains the section and these items:
#
# [ODBC]
# Trace = Yes
# TraceFile = /var/www/logs/odbc.log

# MS SQL Server driver - configuration
RUN echo "extension=/usr/lib/php/20151012/sqlsrv.so" >> /etc/php/7.0/mods-available/sqlsrv.ini
RUN echo "extension=/usr/lib/php/20151012/pdo_sqlsrv.so" >> /etc/php/7.0/mods-available/pdo_sqlsrv.ini
RUN ln -s /etc/php/7.0/mods-available/sqlsrv.ini /etc/php/7.0/fpm/conf.d/20-sqlsrv.ini
RUN ln -s /etc/php/7.0/mods-available/pdo_sqlsrv.ini /etc/php/7.0/fpm/conf.d/20-pdo_sqlsrv.ini
RUN ln -s /etc/php/7.0/mods-available/sqlsrv.ini /etc/php/7.0/cli/conf.d/20-sqlsrv.ini
RUN ln -s /etc/php/7.0/mods-available/pdo_sqlsrv.ini /etc/php/7.0/cli/20-pdo_sqlsrv.ini

RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* && rm -rf /tmp/*

RUN sed -i -e "s/;\?daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

ADD symfony.ini /etc/php/7.0/cli/conf.d/
ADD symfony.ini /etc/php/7.0/fpm/conf.d/

RUN rm /etc/php/7.0/fpm/pool.d/*
ADD symfony.pool.conf /etc/php/7.0/fpm/pool.d/

RUN mkdir /root/.ssh
ADD gitlab_dk_id_rsa /root/.ssh/
ADD config /root/.ssh
RUN chmod 600 /root/.ssh/gitlab_dk_id_rsa

# xdebug config
RUN mkdir -p /var/log/xdebug
RUN touch /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.idekey = PHPSTORM" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.remote_host=192.168.2.107" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.remote_port=9009" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.remote_autostart=true" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.remote_enable=1" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.remote_connect_back=1" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.remote_mode=req" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.remote_handler=dbgp" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.max_nesting_level=2000" >>  /etc/php/7.0/fpm/conf.d/20-xdebug.ini; \
    echo "xdebug.remote_log=/var/log/xdebug/php5-xdebug.log" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini;

# symfony installer
RUN echo 'date.timezone = Europe/Berlin' > /etc/php/7.0/fpm/conf.d/symfony.ini
RUN echo 'max_execution_time = 300' >> /etc/php/7.0/fpm/conf.d/symfony.ini
RUN curl -LsS https://symfony.com/installer -o symfonyinstaller
RUN chmod a+x symfonyinstaller && mv symfonyinstaller /usr/local/bin/symfonyinstaller

# composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# php-fpm start
RUN service php7.0-fpm start
RUN service php7.0-fpm stop
CMD ["/usr/sbin/php-fpm7.0", "-FR"]

# /var/www/symfony
ADD symfony-install.sh /symfony-install.sh
WORKDIR /var/www
#ENTRYPOINT ["/symfony-install.sh"]

EXPOSE 9009
