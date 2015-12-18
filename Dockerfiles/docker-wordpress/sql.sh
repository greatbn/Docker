#!/bin/bash
touch mysql

cat << EOF > /mysql
USE mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("$DB_PASSWD") WHERE user='root';
FLUSH PRIVILEGES;
CREATE DATABASE $WP_DB_NAME;
CREATE USER $WP_DB_USER@localhost IDENTIFIED BY '$WP_DB_PASSWD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO $WP_DB_USER@localhost;
FLUSH PRIVILEGES;
EOF
/usr/sbin/mysqld --bootstrap --verbose=0 < /mysql
rm -f /mysql
sed -i "s/database_name_here/$WP_DB_NAME/g" /var/www/html/wp-config.php && \
sed -i "s/username_here/$WP_DB_USER/g" /var/www/html/wp-config.php && \
sed -i "s/password_here/$WP_DB_PASSWD/g" /var/www/html/wp-config.php 
exec /usr/sbin/mysqld
exec /usr/sbin/apache2 -DFOREGROUND