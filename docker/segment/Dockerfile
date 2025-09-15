FROM php:8.0-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    libmemcached-dev \
    libmagickwand-dev \
    libcurl4-openssl-dev
RUN docker-php-ext-install -j$(nproc) \
    bcmath \
    curl \
    opcache \
    pdo_mysql \
    pcntl \
    sockets \
    zip \
    && exit 1
