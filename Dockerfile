FROM php:8.3-apache

ENV PORT=3000 \
    APACHE_DOCUMENT_ROOT=/var/www/html/public

RUN apt-get update \
    && apt-get install -y --no-install-recommends libpq-dev \
    && docker-php-ext-install pdo_pgsql \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

COPY . /var/www/html/

RUN sed -ri \
        -e "s|/var/www/html|${APACHE_DOCUMENT_ROOT}|g" \
        -e 's|AllowOverride None|AllowOverride All|g' \
        /etc/apache2/sites-available/000-default.conf

COPY docker/apache-entrypoint.sh /usr/local/bin/apache-entrypoint
RUN chmod +x /usr/local/bin/apache-entrypoint

WORKDIR /var/www/html

EXPOSE 3000

ENTRYPOINT ["/usr/local/bin/apache-entrypoint"]
CMD ["apache2-foreground"]
