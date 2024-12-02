FROM alpine:3.16

ARG	DB_NAME \
	DB_USER \
	DB_PASS

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/run/mysqld && \
    chmod 777 /var/run/mysqld && \
    mkdir -p /etc/my.cnf.d

RUN echo '[mysqld]' > /etc/my.cnf.d/docker.cnf && \
    echo 'skip-host-cache' >> /etc/my.cnf.d/docker.cnf && \
    echo 'skip-name-resolve' >> /etc/my.cnf.d/docker.cnf && \
    echo 'bind-address=0.0.0.0' >> /etc/my.cnf.d/docker.cnf && \ 
    sed -i 's|skip-networking|skip-networking=0|g' /etc/my.cnf.d/mariadb-server.cnf


RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY requirements/mariadb/conf/init_db.sh .

RUN sh init_db.sh && rm init_db.sh

USER mysql

CMD ["/usr/bin/mysqld", "--skip-log-error"]
