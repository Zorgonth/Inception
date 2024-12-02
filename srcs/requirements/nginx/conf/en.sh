#!/bin/sh

mkdir -p /etc/nginx/ssl/

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${KEY} -out ${CERT} -subj "/C=US/ST=SomeState/L=SomeCity/O=SomeOrganization/CN=sal-zuba.42.fr";
mv  ${CERT} /etc/nginx/ssl/;
mv  ${KEY} /etc/nginx/ssl/;

echo "server {
	listen			443 ssl;
	server_name		${SERVER_NAME} www.${SERVER_NAME};
	
	root			/var/www/;
	index			index.php index.html;

	ssl_certificate		/etc/nginx/ssl/${CERT};
	ssl_certificate_key	/etc/nginx/ssl/${KEY};
	ssl_protocols		TLSv1.2 TLSv1.3;
	ssl_session_timeout	10m;
	keepalive_timeout	70;

	location / {
		try_files		\$uri /index.php\$is_args\$args;
		add_header		Last-Modified \$date_gmt;
		add_header		Cache-Control 'no-store, no-cache';
		if_modified_since	off;
		expires			off;
		etag			off;
	}
	location ~ \.php$ {
		fastcgi_split_path_info	^(.+\.php)(/.+)$;
		fastcgi_pass		wordpress:9000;
		fastcgi_index		index.php;
		include			fastcgi_params;
		fastcgi_param		SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
		fastcgi_param		PATH_INFO \$fastcgi_path_info;
	}
}
" > /etc/nginx/http.d/nginx.conf

nginx -g "daemon off;"