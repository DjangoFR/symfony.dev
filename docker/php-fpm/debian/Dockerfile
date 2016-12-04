FROM debian:jessie-slim

ENV TERM xterm

RUN apt-get update
RUN apt-get install -y wget curl nano zip git

# php7
RUN echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.list
RUN curl http://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN apt-get update
RUN apt-get install -y \
    php7.0-apcu \
    php7.0-cli \
    php7.0-common \
    php7.0-curl \
    php7.0-fpm \
    php7.0-gd \
    php7.0-imagick \
    php7.0-intl \
    php7.0-json \
    php7.0-mbstring \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-opcache \
    php7.0-readline \
    php7.0-sybase \
    php7.0-xdebug \
    php7.0-xml

RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* && rm -rf /tmp/*

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
