FROM debian:buster

RUN apt update -y && apt upgrade -y

# => Install ngixn server and openssl forgenerate the ssl
RUN apt install -y nginx openssl vim curl

# => Create the repository for the ssl certificate and the ssl key 
RUN mkdir -p /etc/nginx/ssl

# => Generate a self-signed certificate and key
RUN openssl req -x509 -nodes -newkey rsa:2048 -days 365 -sha256 \
	-out /etc/nginx/ssl/inception.crt \ 
	-keyout /etc/nginx/ssl/inception.key \ 
	-subj "/C=ES/ST=ML/L=Malaga/O=42/OU=42Malaga/CN=cmorales.42.fr/UID=cmorales"

# => Copy the nginx.conf file into the container
COPY conf/nginx.conf etc/nginx/nginx.conf

# => Use chmod to give the right to the user to edit html folder
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

# => Indicate the port partner with the nginx service
EXPOSE 443

# => Start the nginx service | -g give a configuration variable |daemos off put nginx server in second map
CMD ["nginx", "-g", "daemon off;"]
