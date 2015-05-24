FROM synctree/mediawiki
MAINTAINER seu <seu@panopticon.re>

ENV SMW_DOWNLOAD_URL "http://downloads.sourceforge.net/project/semediawiki/semediawiki/Semantic%20MediaWiki%202.2/Semantic%20MediaWiki%202.2%20%28%2Bdependencies%29.tgz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fsemediawiki%2Ffiles%2Fsemediawiki%2FSemantic%2520MediaWiki%25202.2%2F&ts=1432390638&use_mirror=garr"

RUN set -x; \
    curl -fSL "$SMW_DOWNLOAD_URL" -o smw.tar.gz \
    && tar -xf smw.tar.gz -C /usr/src/mediawiki/extensions/ --strip-components=0

VOLUME /var/www-shared/html
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
