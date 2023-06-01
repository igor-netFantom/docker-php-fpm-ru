FROM php:5.5-fpm

ARG USER_ID
ENV USER_ID ${USER_ID:-1000}
ARG GROUP_ID
ENV GROUP_ID ${GROUP_ID:-1000}
ARG MEMCACHE_VERSION
ENV MEMCACHE_VERSION ${MEMCACHE_VERSION:-2.2.3}
ARG XDEBUG_VERSION
ENV XDEBUG_VERSION ${XDEBUG_VERSION:-2.5.5}

ENV TZ=Europe/Moscow

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:ru
ENV LC_LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

COPY ../install-ubuntu-packages.sh /root/

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" >> /etc/apt/sources.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
#RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN sed -i '/jessie-updates/d' /etc/apt/sources.list
RUN sed -i '/jessie-main/d' /etc/apt/sources.list
RUN sed -i '/jessie\/main/d' /etc/apt/sources.list
RUN sed -i '/jessie\/updates/d' /etc/apt/sources.list
#RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf
#RUN echo 'Acquire::Check-Valid-Until no;' > /etc/apt/apt.conf.d/99no-check-valid-until
RUN apt-get update

#RUN rm /etc/apt/sources.list
#RUN echo "deb http://archive.debian.org/debian-security jessie/updates main" > /etc/apt/sources.list.d/jessie.list
#RUN apt-get update
#RUN echo 'deb http://archive.debian.org/debian-security jessie/updates main' > /etc/apt/sources.list.d/jessie-backports.list


#RUN apt-get -o Acquire::Check-Valid-Until=false update

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
