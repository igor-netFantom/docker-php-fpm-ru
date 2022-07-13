FROM php:7.2-fpm-alpine

ARG USER_ID
ENV USER_ID ${USER_ID:-1000}
ARG GROUP_ID
ENV GROUP_ID ${GROUP_ID:-1000}

RUN apk --update --no-cache --virtual build-deps add \
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
    libxml2-dev \
    && apk add --update --no-cache \
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
    libzip \
    curl \
    imagemagick \
    freetype \
    libpng \
    libjpeg-turbo \
    libxml2 \
    g++ \
#    zlib1g-dev libkrb5-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
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
    mysqli \
    exif \
    && pecl install -f memcache-4 \
    && docker-php-ext-enable memcache \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data \
    && usermod -d /var/www www-data \
    && apk del build-deps

RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /var/www

USER "${USER_ID}:${GROUP_ID}"

CMD ["php-fpm"]
