FROM php:7.4.33-apache-bullseye

# حذف أي MPM مفعل مسبقاً (حل نهائي لمشكلة more than one MPM)
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load

# تفعيل MPM واحد فقط
RUN a2enmod mpm_prefork

# تثبيت المتطلبات
RUN apt-get update && apt-get install -y \
    git unzip zip libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath

# نسخ composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

ENV COMPOSER_MEMORY_LIMIT=-1

RUN composer install --no-dev --optimize-autoloader --no-interaction

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
