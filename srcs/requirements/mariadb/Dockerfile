FROM debian:buster

RUN apt update -y && apt upgrade -y

# => Install MariaDB server (MySQL)
RUN apt install mariadb-server -y

# => Copy into the container the MariaDB config file
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# => Copy the script to create mariadb
COPY tools/script.sh /script.sh

# => Give permission if dont have
RUN chmod +x /script.sh

# => Indicate the port partner with the mariadb server
EXPOSE 3306

# => Execute the script that we copied before 
ENTRYPOINT ["bash", "script.sh"]
