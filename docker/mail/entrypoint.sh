#!/bin/bash

service rsyslog start
dovecot
service postfix start
tail -F /var/log/mail.log
