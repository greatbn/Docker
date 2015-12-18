#!/bin/bash
touch mysql
mysql_config='/mysql'
cat << EOF > $mysql_config
USE mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("$DB_PASSWD") WHERE user='root';
FLUSH PRIVILEGES;
CREATE DATABASE $WP_DB_NAME;
CREATE USER $WP_DB_USER@localhost IDENTIFIED BY '$WP_DB_PASSWD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO $WP_DB_USER@localhost;
FLUSH PRIVILEGES;
EOF
/usr/sbin/mysqld --bootstrap --verbose=0 < $mysql_config
rm -f $mysql_config
exec /usr/sbin/mysqld