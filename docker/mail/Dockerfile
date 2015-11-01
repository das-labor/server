FROM ubuntu:trusty

MAINTAINER seu <seu@panopticon.re>

RUN apt-get update -y && \
		DEBIAN_FRONTEND=noninteractive apt-get install -y postfix postfix-ldap dovecot-common dovecot-imapd dovecot-ldap dovecot-lmtpd dovecot-imapd dovecot-pop3d libsasl2-modules && \
		apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY dovecot.conf /etc/dovecot/dovecot.conf
COPY dovecot-ldap.conf /etc/dovecot/dovecot-ldap.conf

COPY main.cf /etc/postfix/main.cf
COPY master.cf /etc/postfix/master.cf
COPY vdomain /etc/postfix/vdomain
COPY valias /etc/postfix/valias
COPY vmailbox.cf /etc/postfix/vmailbox.cf
COPY entrypoint.sh /entrypoint.sh

RUN postmap hash:/etc/postfix/valias
RUN useradd -U -M vmail
RUN mkdir -p /srv/mail
RUN chown -R vmail:vmail /srv/mail

ENTRYPOINT /entrypoint.sh
