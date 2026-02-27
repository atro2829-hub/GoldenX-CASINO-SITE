FROM php:7.4.33-apache-bullseye

RUN apt-get update && apt-get install -y \
    git unzip zip libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

ENV COMPOSER_MEMORY_LIMIT=-1

RUN composer install --no-dev --optimize-autoloader --no-interaction

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
