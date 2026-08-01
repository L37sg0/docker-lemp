FROM php:8.1-fpm

# Set working directory
WORKDIR /var/www

# Инсталиране на системни зависимости и библиотеки
RUN apt-get update && apt-get install -y \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxpm-dev \
    libwebp-dev \
    libicu-dev \
    libxslt1-dev \
    libzip-dev \
    libxml2-dev \
    librabbitmq-dev \
    zlib1g-dev \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-xpm \
        --with-webp \
    && docker-php-ext-install -j$(nproc) \
        gd \
        bcmath \
        intl \
        pdo_mysql \
        soap \
        sockets \
        xsl \
        zip \
        exif \
    && pecl install amqp redis \
    && docker-php-ext-enable amqp redis \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (Node 20)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*
    
# Create application user (www) with uid/gid 1000
RUN groupadd -g 1000 www \
    && useradd -u 1000 -ms /bin/bash -g www www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]