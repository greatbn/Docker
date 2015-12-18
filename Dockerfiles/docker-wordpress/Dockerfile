FROM ubuntu:14.04

MAINTAINER Sa Phi <saphi070@gmail.com>

ENV \
DB_max_allowed_packet=64M \
DB_query_cache_size=0 \ 
DB_query_cache_type=0 \ 
DB_sync_binlog=0 \ 
DB_innodb_buffer_pool_size=768M \
DB_innodb_log_file_size=128M \ 
DB_innodb_flush_method=O_DIRECT \ 
DB_innodb_old_blocks_time=1000 \
DB_innodb_flush_log_at_trx_commit=0 \
DB_PASSWD="toor" \
WP_DB_USER="wordpress" \
WP_DB_PASSWD='wordpress' \
WP_DB_NAME='wordpress'

RUN \
echo "nameserver 8.8.8.8" > /etc/resolve.conf &&\
apt-get -y --force-yes update && \ 
export DEBIAN_FRONTEND=noninteractive && \
apt-get -q -y --force-yes install mysql-server && \
apt-get install wget apache2 mysql-server php5-mysql php5 libapache2-mod-php5 php5-mcrypt -y && \ 
service mysql start && \
wget https://wordpress.org/latest.tar.gz && \
tar -xzvf latest.tar.gz -C /var/www/html/ && \
rm latest.tar.gz && \
mv /var/www/html/wordpress/* /var/www/html/ && \
rm -r /var/www/html/wordpress && \
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php && \ 
chown -R www-data:www-data /var/www/html/* && \ 
mkdir /var/www/html/wp-content/uploads && \
chown -R :www-data /var/www/html/wp-content/uploads && \
chmod 775 -R /var/www/html/* && \
sed -i 's/index.html/index.php index.html/g' /etc/apache2/mods-enabled/dir.conf && \
service apache2 start && \
service mysql restart 


ADD sql.sh sql.sh

EXPOSE 80


RUN chmod 755 /sql.sh
CMD /sql.sh


		
		
		
		
		