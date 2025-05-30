#!/bin/sh

apk --update --no-cache --virtual build-deps add \
    linux-headers \
    autoconf \
    make \
    gcc \
    libtool \
    shadow \
    libmemcached-dev \
    pcre-dev \
\
    openssl-dev \
    icu-dev \
    libzip-dev \
    curl-dev \
    imagemagick-dev \
    freetype-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    oniguruma-dev \
    libxml2-dev \
    && apk add --update --no-cache \
    grep \
    unzip \
    procps \
    git \
    wget \
    bash \
    imap-dev \
    imap \
\
    openssl \
    icu \
    libpq-dev \
    libzip \
    curl \
    imagemagick \
    freetype \
    libpng \
    libjpeg-turbo \
    libxml2 \
    g++ \
    && echo 'could be helpful: zlib1g-dev libkrb5-dev' \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-configure imap --with-imap --with-imap-ssl \
    && docker-php-ext-install \
    intl \
    sockets \
    xml \
    imap \
    zip \
    mbstring \
    gd \
    pdo_mysql \
    pgsql \
    pdo_pgsql \
    mysqli \
    exif \
    opcache \
    && pecl install memcache${MEMCACHE_VERSION:+-$MEMCACHE_VERSION} && docker-php-ext-enable memcache \
    && pecl install imagick && docker-php-ext-enable imagick \
    && pecl install xdebug${XDEBUG_VERSION:+-$XDEBUG_VERSION} && docker-php-ext-enable xdebug \
    && usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data \
    && echo '# IF YOU WANT TO CHANGE HOME DIR: && usermod -d /var/www www-data' \
    && apk del build-deps