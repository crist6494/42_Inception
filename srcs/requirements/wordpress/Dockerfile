FROM debian:buster

RUN apt-get update && apt-get upgrade -y

# => Install eget to download the WordPress source code
RUN apt-get -y install wget

# => Install PHP 7.3 and its dependencies
RUN apt-get install -y php7.3\
	php7.3-fpm \
 	php7.3-mysql \
	php7.3-phar\
	mariadb-client 
	
# => Install sendmail fix warning in dokcer logs
RUN apt-get install -y sendmail 

# => Download wordpress 6.0 from wordpress.org into /var/www/ and extract it with tar command
RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz

# => Copy of php configuration
COPY	./conf/www.conf			/etc/php/7.3/fpm/pool.d/www.conf

# => Give the right group user to write in the directory
RUN	chown -R root:root /var/www/wordpress

# => Install wp-cli to manage wordpress installation
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# => Give the right to the user to write in the directory
RUN chmod +x wp-cli.phar
# => Copy wp-cli to /usr/local/bin/wp-cli.phar changing the name for fix a problem
RUN mv wp-cli.phar /usr/local/bin/wp-cli.phar

# => Copy the script to cronfigurate all the wordpress
COPY conf/auto_config.sh auto_config.sh

# => Indicate the port partner with the wordpress service
EXPOSE 9000

# => Execute the script copied before
ENTRYPOINT ["bash", "auto_config.sh"]
