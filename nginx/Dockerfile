FROM debian:buster

RUN apt update -y && apt upgrade -y

RUN apt install -y nginx openssl vim curl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -newkey rsa:2048 -days 365 -sha256 \
	-out /etc/nginx/ssl/inception.crt \ 
	-keyout /etc/nginx/ssl/inception.key \ 
	-subj "/C=ES/ST=ML/L=Malaga/O=42/OU=42Malaga/CN=login.42.es/UID=login"

COPY conf/nginx.conf etc/nginx/nginx.conf


RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
