FROM debian:buster

RUN apt update -y && apt upgrade -y

RUN apt install php7.3 php-fpm php-mysql mariadb-client wget -y

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www \
	&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN cd /var/www/ && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz \
	&& chown -R root:root /var/www/wordpress

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Exponer el puerto 80 para acceder a WordPress desde fuera del contenedor
EXPOSE 80

# Iniciar el servidor web para PHP (puedes usar php-fpm)
CMD ["tail", "-f", "/dev/null"]

 
