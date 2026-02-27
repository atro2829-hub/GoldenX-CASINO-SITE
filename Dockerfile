FROM php:8.2-apache

# حذف أي MPM مفعل مسبقاً
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load

# تفعيل MPM واحد فقط
RUN a2enmod mpm_prefork

# تفعيل mod_rewrite إذا تحتاجه
RUN a2enmod rewrite

# نسخ ملفات الموقع
COPY . /var/www/html/

# ضبط الصلاحيات
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
