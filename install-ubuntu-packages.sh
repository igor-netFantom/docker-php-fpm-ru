#!/bin/sh

apt-get update && apt-get install -y \
        unzip procps git curl wget locales \
        zlib1g-dev g++ libmagickwand-dev --no-install-recommends libxml2-dev libzip-dev \
        libjpeg-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
        libicu-dev libmemcached-dev libc-client-dev libkrb5-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install intl sockets xml imap zip mbstring gd pdo_mysql exif mysqli \
    && pecl install memcache-${MEMCACHE_VERSION} && docker-php-ext-enable memcache \
    && pecl install imagick && docker-php-ext-enable imagick \
    && pecl install xdebug-${XDEBUG_VERSION} && docker-php-ext-enable xdebug \
    && rm -r /var/lib/apt/lists/*