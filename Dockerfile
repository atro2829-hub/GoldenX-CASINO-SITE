FROM php:7.4-apache

# حذف جميع ملفات MPM
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load \
    && rm -f /etc/apache2/mods-available/mpm_*.load

# إنشاء ملف واحد فقط يدويًا لـ prefork
RUN echo "LoadModule mpm_prefork_module /usr/lib/apache2/modules/mod_mpm_prefork.so" \
    > /etc/apache2/mods-enabled/mpm_prefork.load

RUN a2enmod rewrite

COPY . /var/www/html
EXPOSE 80
