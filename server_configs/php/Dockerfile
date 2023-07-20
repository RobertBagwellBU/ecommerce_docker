FROM php:8-fpm

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc mono-mcs && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y libssh2-1-dev libssh2-1 \
    && pecl install ssh2-1.3.1 \
    && docker-php-ext-enable ssh2

RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    vim \
    wget \
    git \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get --yes install libfreetype6-dev \
                          libjpeg62-turbo-dev \
                          libpng-dev \
                          libwebp-dev

RUN set -e; \
    docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype; \
    docker-php-ext-install -j$(nproc) gd

RUN apt-get -y update \
&& apt-get install -y libicu-dev \ 
&& docker-php-ext-configure intl \
&& docker-php-ext-install intl

RUN docker-php-ext-install pdo pdo_mysql mysqli 

RUN apt-get update && \
    apt-get install -y libxml2-dev \
    && docker-php-ext-install -j$(nproc) soap