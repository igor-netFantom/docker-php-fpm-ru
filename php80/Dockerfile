FROM php:8.0-fpm

RUN apt-get update && apt-get install -y \
        unzip procps git curl wget locales \
        zlib1g-dev g++ libmagickwand-dev --no-install-recommends libxml2-dev libzip-dev \
        libjpeg-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
        libicu-dev libmemcached-dev libc-client-dev libkrb5-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install intl sockets xml imap zip mbstring gd pdo_mysql \
    && pecl install memcache \
    && docker-php-ext-enable memcache \
    && pecl install imagick \
    && docker-php-ext-enable imagick

RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

ARG USER_ID
ENV USER_ID ${USER_ID:-1000}
ARG GROUP_ID
ENV GROUP_ID ${GROUP_ID:-1000}

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN sed -i -e \
  's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
   && locale-gen

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:ru
ENV LC_LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

RUN usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data

WORKDIR /var/www

USER "${USER_ID}:${GROUP_ID}"

CMD ["php-fpm"]
