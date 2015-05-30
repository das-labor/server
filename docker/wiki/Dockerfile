FROM synctree/mediawiki
MAINTAINER seu <seu@panopticon.re>

ENV SMW_DOWNLOAD_URL "http://downloads.sourceforge.net/project/semediawiki/semediawiki/Semantic%20MediaWiki%202.2/Semantic%20MediaWiki%202.2%20%28%2Bdependencies%29.tgz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fsemediawiki%2Ffiles%2Fsemediawiki%2FSemantic%2520MediaWiki%25202.2%2F&ts=1432390638&use_mirror=garr"
ENV LDAPAUTH_DOWNLOAD_URL "https://extdist.wmflabs.org/dist/extensions/LdapAuthentication-REL1_24-24a399e.tar.gz"

RUN set -x; \
    curl -fSL "$SMW_DOWNLOAD_URL" -o smw.tar.gz && \
    tar -xf smw.tar.gz -C /usr/src/mediawiki/extensions/ --strip-components=0

RUN set -x; \
    curl -fSL "$LDAPAUTH_DOWNLOAD_URL" -o ldap.tar.gz && \
    tar -xf ldap.tar.gz -C /usr/src/mediawiki/extensions/ --strip-components=0

RUN apt-get update && \
		apt-get install -y libldap-dev && \
		rm -rf /var/lib/apt/lists/* && \
		ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/ && \
		docker-php-ext-install ldap

VOLUME /var/www-shared/html
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
