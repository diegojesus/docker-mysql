FROM ubuntu:latest

MAINTAINER Diego Jesús Hernández <diegojesus.hernandez@swissmedical.com.ar>

# Instalamos las ultimas actualizaciones
RUN apt-get update
RUN apt-get upgrade -y

# Instalamos el cliente y servidor de MySQL
RUN apt-get -y install mysql-client mysql-server curl

# Habilitamos el acceso remoto
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Añadimos el archivo con la base de datos y las tablas.
ADD ./database.sql /var/db/database.sql

# Añadimos la configuración estandar.
ENV user admin
ENV password admin
ENV url file:/var/db/database.sql
ENV right READ

# Ejecutamos el script
ADD ./start-database.sh /usr/local/bin/start-database.sh
RUN chmod +x /usr/local/bin/start-database.sh

# Habilitamos el puerto 3306 para conectarnos a la BBDD.
EXPOSE 3306

# Iniciamos el motor de MySQL
CMD ["/usr/local/bin/start-database.sh"]
