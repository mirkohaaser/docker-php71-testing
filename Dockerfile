FROM php:7.1-cli

MAINTAINER Mirko Haaser <kontakt@mirko-haaser.de>

# Common tools needed later
RUN apt-get update -yqq
RUN apt-get install -y openssl git wget

# Install php extensions and dependencies
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libgd-dev libmcrypt-dev libbz2-dev zlib1g-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev libxml2-dev libexpat1-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev libcurl4-gnutls-dev libicu-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 
RUN docker-php-ext-install gd exif mysqli pdo pdo_mysql gettext mbstring mcrypt curl json intl xml opcache zip bz2

# Install Composer and project dependencies.
RUN curl -sS https://getcomposer.org/installer | php

# Install phpunit
RUN wget https://phar.phpunit.de/phpunit-6.5.phar
RUN chmod +x phpunit-6.5.phar
RUN mv phpunit-6.5.phar /usr/local/bin/phpunit
RUN phpunit --version

# Install phpmd
RUN wget -c http://static.phpmd.org/php/latest/phpmd.phar
RUN chmod +x phpmd.phar
RUN mv phpmd.phar /usr/local/bin/phpmd
RUN phpmd --version