FROM ubuntu:16.04

ENV TERM xterm

RUN apt-get update
RUN apt-get install -y curl nano zip git \
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
    php-sybase \
    php-xdebug \
    wget

# RUN rm -rf /var/cache/apt/archives/* && rm -rf /tmp/*

RUN sed -i -e "s/;\?daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

ADD symfony.ini /etc/php/7.0/cli/conf.d/
ADD symfony.ini /etc/php/7.0/fpm/conf.d/

RUN rm /etc/php/7.0/fpm/pool.d/*
ADD symfony.pool.conf /etc/php/7.0/fpm/pool.d/

# symfony installer
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

EXPOSE 9000
