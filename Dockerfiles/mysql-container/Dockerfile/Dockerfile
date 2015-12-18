FROM ubuntu:14.04

MAINTAINER Sa Phi <saphi070@gmail.com>

ENV DB_USER='mysql' \
	DB_PASSWD='mysql' \
	DB_NAME='database'
RUN	export DEBIAN_FRONTEND=noninteractive && \ 
echo "deb-src http://repo.mysql.com/apt/ubuntu/ trusty mysql-5.7" > /etc/apt/sources.list.d/mysql.list && \
apt-get update && \ 
apt-get install -y mysql-server

ADD run.sh run.sh
RUN chmod 775 /run.sh
VOLUME ["/var/lib/mysql"]
CMD ["/run.sh"]