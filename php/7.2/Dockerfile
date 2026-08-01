FROM php:7.2-fpm

# Fix repositories for old PHP 7.2 (Debian Stretch)
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list \
    && echo "Acquire::Check-Valid-Time \"false\";" > /etc/apt/apt.conf.d/99no-check-valid-time

# Set working directory
WORKDIR /var/www

# Install system dependencies including libicu-dev for intl
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    gzip \
    lsof \
    sed \
    tar \
    curl \
    libcurl4-openssl-dev \
    libxml2-dev \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

# Configure and install PHP extensions
RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
    gd \
    bcmath \
    intl \
    pdo_mysql \
    soap \
    sockets \
    zip \
    && pecl install redis-5.3.7 \
    && docker-php-ext-enable redis

# Create application user (www) with uid/gid 1000
RUN groupadd -g 1000 www \
    && useradd -u 1000 -ms /bin/bash -g www www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]