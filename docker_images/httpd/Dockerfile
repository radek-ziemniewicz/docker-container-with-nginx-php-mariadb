FROM php:8.1.0-apache
RUN apt -y update
RUN apt install -y vim
RUN docker-php-ext-install pdo pdo_mysql
RUN apt install -y libicu-dev && docker-php-ext-configure intl && docker-php-ext-install intl
RUN apt install -y libzip-dev zip && docker-php-ext-configure zip && docker-php-ext-install zip
RUN a2enmod ssl

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

RUN docker-php-ext-configure gd && docker-php-ext-install gd
RUN docker-php-ext-install -j$(nproc) iconv soap sockets \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd bcmath pdo_mysql xsl intl zip
