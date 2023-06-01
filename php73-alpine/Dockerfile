FROM php:7.3-fpm-alpine

ARG USER_ID
ENV USER_ID ${USER_ID:-1000}
ARG GROUP_ID
ENV GROUP_ID ${GROUP_ID:-1000}
ARG MEMCACHE_VERSION
ENV MEMCACHE_VERSION ${MEMCACHE_VERSION:-4}
ARG XDEBUG_VERSION
ENV XDEBUG_VERSION ${XDEBUG_VERSION:-3.1.6}

COPY ../install-alpine-packages.sh /root/

RUN sh /root/install-alpine-packages.sh

RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /var/www

USER "${USER_ID}:${GROUP_ID}"

RUN composer global require "squizlabs/php_codesniffer=*" phpmd/phpmd phpunit/phpunit --no-interaction

ENV PATH="${PATH}:/home/www-data/.composer/vendor/bin"

COPY ../.bashrc /home/www-data

CMD ["php-fpm"]
