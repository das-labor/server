FROM ubuntu:trusty

MAINTAINER seu <seu@panopticon.re>

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
		apt-get update -y && \
		DEBIAN_FRONTEND=noninteractive apt-get install -y slapd ldap-utils && \
		apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mv /etc/ldap /etc/ldap.dist && \
		mkdir /etc/ldap && \
		mkdir /etc/ldap/schema

EXPOSE 389

VOLUME /var/lib/ldap

ENV SLAPD_DOMAIN das-labor.org
ENV SLAPD_ORGANIZATION "LABOR e.V."
ENV SLAPD_ADDITIONAL_SCHEMAS "labor"

COPY labor.ldif /etc/ldap/schema/labor.ldif
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["slapd", "-d", "32768", "-u", "openldap", "-g", "openldap"]
