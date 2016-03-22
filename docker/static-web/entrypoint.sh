#!/bin/bash

# Default server handles Github hooks
cat << "EOF" > /etc/nginx/conf.d/default.conf
server {
	listen 80 default_server;
	server_name api.das-labor.org;

	location /github {
		expires 8d;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;
		proxy_set_header X-NginX-Proxy true;
		proxy_read_timeout 5m;
		proxy_connect_timeout 5m;

		proxy_cache_key sfs$request_uri$scheme;
		proxy_pass http://127.0.0.1:3000;
		proxy_redirect off;
	}
}
EOF

# Iterate thru all STATIC_SITE_* env vars
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
	git clone --depth 1 $REPO /var/www/$HOST

	if [ $JEKYLL == true ]
	then
		cd /var/www/$HOST
		jekyll build
		ROOT="/var/www/$HOST/_site"
	else
		ROOT="/var/www/$HOST"
	fi

	cat << EOF >> /etc/nginx/conf.d/default.conf
server {
	listen 80;
	server_name $HOST;
	root $ROOT;

	location / {
		index index.htm index.html;
	}
}
EOF

done

# Iterate thru all REDIRECT_SITE_* env vars
for VAR in `env | egrep -o "^REDIRECT_SITE_.+"`
do
	LINE=`echo $VAR | cut -d = -f 2`
	FROM=`echo $LINE | cut -d , -f 1`
	TO=`echo $LINE | cut -d , -f 2`

	echo -n "Set up redirect from $FROM to $TO"

	cat << EOF >> /etc/nginx/conf.d/default.conf
server {
	server_name $FROM;
	return 301 \$scheme://$TO\$request_uri;
}
EOF

done

chown -R www-data:www-data /var/www
go build -o /github_hook /github_hook.go

/github_hook &
sleep 2


exec nginx -g "daemon off;"
