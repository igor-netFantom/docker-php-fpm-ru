FROM php:7.2-fpm-alpine

RUN apk --update --virtual build-deps add \
    autoconf \
    make \
    gcc \
    g++ \
    libtool \
    icu-dev \
    curl-dev \
    freetype-dev \
    imagemagick-dev \
    libmemcached-dev \
    libzip-dev \
    pcre-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    openssl-dev \
    libxml2-dev \
    shadow
RUN apk add --no-cache \
    unzip \
    procps \
    git \
    curl \
    wget \
    freetype \
    libpng \
    libjpeg-turbo \
    libxml2 \
    imap-dev
#        zlib1g-dev g++ imagemagick-dev libxml2-dev libzip-dev \
#        libmemcached-dev libkrb5-dev \
#         \
RUN docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure imap --with-imap --with-imap-ssl
RUN docker-php-ext-install \
    intl \
    sockets \
    xml \
    imap \
    zip \
    mbstring \
    gd \
    pdo_mysql
RUN pecl install -f memcache-4 \
    && docker-php-ext-enable memcache \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

ARG USER_ID
ENV USER_ID ${USER_ID:-1000}
ARG GROUP_ID
ENV GROUP_ID ${GROUP_ID:-1000}

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data

RUN apk del build-deps

WORKDIR /var/www

USER "${USER_ID}:${GROUP_ID}"

CMD ["php-fpm"]
