FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install system dependencies and clean up in a single layer
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
        simplexml \
        soap \
        sockets \
        xsl \
        zip \
    && pecl install amqp \
    && docker-php-ext-enable amqp \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (Node 20)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]