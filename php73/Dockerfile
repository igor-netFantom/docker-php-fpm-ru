FROM php:7.3-fpm

ARG USER_ID
ENV USER_ID ${USER_ID:-1000}
ARG GROUP_ID
ENV GROUP_ID ${GROUP_ID:-1000}
ARG MEMCACHE_VERSION
ENV MEMCACHE_VERSION ${MEMCACHE_VERSION:-4.0.5.2}
ARG XDEBUG_VERSION
ENV XDEBUG_VERSION ${XDEBUG_VERSION:-3.1.6}

ENV TZ=Europe/Moscow

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:ru
ENV LC_LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

COPY ../install-ubuntu-packages.sh /root/

RUN sh /root/install-ubuntu-packages.sh

RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN sed -i -e \
  's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
   && locale-gen

RUN usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data

WORKDIR /var/www

USER "${USER_ID}:${GROUP_ID}"

CMD ["php-fpm"]
