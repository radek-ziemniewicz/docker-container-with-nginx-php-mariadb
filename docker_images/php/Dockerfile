FROM php:7.4-fpm

#SETTING UP THE SYSTEM
RUN apt-get update \
    && apt-get install -y \
    apt-utils \
    wget \
    libwebp-dev \
    libxpm-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt-dev \
    libicu-dev \
    mariadb-client \
    pv \
    vim \
    nano \ 
    bash-completion \
    openssh-server \
    ssl-cert \
    msmtp \
    sudo \
    dnsutils \
    iputils-ping \
    iputils-tracepath \
    host \
    strace \
    telnet \
    unzip \
    gnupg \
    gcc \
    lsof \
    libsodium-dev \
    libzip-dev \
    && apt-get update \
    && apt-get clean all

#CREATE USER - you can change it!
ENV _USER=user
ENV _HOME_DIRECTORY=/home/${_USER}
RUN useradd -m ${_USER} && echo "${_USER}:${_USER}" | chpasswd && chsh ${_USER} -s /bin/bash && adduser ${_USER} sudo

#PHP EXTENSIONS
RUN docker-php-ext-install -j$(nproc) iconv soap sockets \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd bcmath pdo_mysql xsl intl zip \
    && pecl install libsodium-2.0.23

#GIT
RUN apt-get update \
    && apt-get install -y git \
    && apt-get clean all

#COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --2\
    && apt -qy install $PHPIZE_DEPS && mkdir /${_HOME_DIRECTORY}/.composer

#XDEBUG
RUN pecl install xdebug-3.0.1 \
    && echo ";zend_extension=xdebug.so" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.max_nesting_level=10000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY ./xdebug-php.sh /usr/local/bin/xdebug-php.sh

#APACHE
RUN chown -R ${_USER}:${_USER} /var/www/html
RUN chown -R ${_USER}:${_USER} ${_HOME_DIRECTORY}

#BASH COMPLETION
USER ${_USER}
RUN echo "source /etc/bash_completion" >> ${_HOME_DIRECTORY}/.bashrc

#TUNE ENVIRONMENT
USER root
RUN echo "Defaults    timestamp_timeout=-1" >> /etc/sudoers

RUN chmod +x /usr/local/bin/*

WORKDIR /var/www/html
