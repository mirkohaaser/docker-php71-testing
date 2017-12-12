FROM php:7.1-cli

MAINTAINER Mirko Haaser <kontakt@mirko-haaser.de>

# Common tools needed later
RUN apt-get update
RUN apt-get install -y openssl git

# Install image extensions
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libgd-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 
RUN docker-php-ext-install gd exif

# Install database extension
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install string ectensions
RUN docker-php-ext-install gettext mbstring

# Install mcrypt
RUN apt-get install -y libmcrypt-dev
RUN docker-php-ext-install mcrypt

# Install compression extension
RUN apt-get update 
RUN apt-get install -y libbz2-dev zlib1g-dev 
RUN docker-php-ext-install zip bz2

# Update packages and install composer and PHP dependencies.
apt-get update -yqq
apt-get install git libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev -yqq

# Compile PHP, include these extensions.
docker-php-ext-install curl json intl xml opcache

# Install Composer and project dependencies.
curl -sS https://getcomposer.org/installer | php

php composer.phar install
