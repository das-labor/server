# merged from upstream (synctree/mediawiki) for compatibility
FROM php:7.2-apache
MAINTAINER seu <seu@panopticon.re>

RUN set -x; \
    apt-get update && apt-get install -y \
        git \
        imagemagick \
        libicu-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mbstring mysqli opcache intl

# copied from the official mediawiki dockerfile
# Install the default object cache.
RUN pecl channel-update pecl.php.net \
	&& pecl install apcu \
	&& docker-php-ext-enable apcu

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN pear install Mail Net_SMTP

RUN a2enmod rewrite

COPY apache/mediawiki.conf /etc/apache2/
RUN echo Include /etc/apache2/mediawiki.conf >> /etc/apache2/apache2.conf

VOLUME /var/www/html

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
