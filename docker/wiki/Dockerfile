# merged from upstream (synctree/mediawiki) for compatibility
FROM php:5.6-apache
MAINTAINER seu <seu@panopticon.re>

RUN set -x; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        imagemagick \
        libicu-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mbstring mysqli opcache intl

RUN pear install mail net_snmp

RUN a2enmod rewrite

COPY apache/mediawiki.conf /etc/apache2/

VOLUME /var/www/html

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
