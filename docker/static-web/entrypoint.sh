#!/bin/bash

rm -f /etc/nginx/conf.d/static-web.conf

for VAR in `env | egrep -o "^STATIC_SITE_.+"`
do
	LINE=`echo $VAR | cut -d = -f 2`
	HOST=`echo $LINE | cut -d , -f 1`
	REPO=`echo $LINE | cut -d , -f 2`
	JEKYLL=`echo $LINE | cut -d , -f 3`

	echo -n "Set up $HOST from $REPO"
	if [ $JEKYLL == true ]
	then
		echo " with jekyll"
	else
		echo " without jekyll"
	fi


	rm -rf /var/www/$HOST
	git clone $REPO /var/www/$HOST

	if [ $JEKYLL == true ]
	then
		cd /var/www/$HOST
		jekyll build
		m4 -Dhostname=$HOST -Dsiteroot=/var/www/$HOST/_site /nginx.m4 >> /etc/nginx/conf.d/static-web.conf
	else
		m4 -Dhostname=$HOST -Dsiteroot=/var/www/$HOST /nginx.m4 >> /etc/nginx/conf.d/static-web.conf
	fi
done

chown -R www-data:www-data /var/www

tail -F /var/log/nginx/error.log
