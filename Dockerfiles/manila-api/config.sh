#!/bin/sh
sed -i 's/HOSTNAME/'$HOSTNAME'/g' /etc/manila/manila.conf
sed -i 's/MANILA_DBUSER/'$MANILA_DBUSER'/g' /etc/manila/manila.conf
sed -i 's/MANILA_DBPASS/'$MANILA_DBPASS'/g' /etc/manila/manila.conf
sed -i 's/MANILADB_ADDR/'$MANILADB_ADDR'/g' /etc/manila/manila.conf
sed -i 's/MANILA_DBNAME/'$MANILA_DBNAME'/g' /etc/manila/manila.conf
sed -i 's/CONTROLLER_ADDR/'$CONTROLLER_ADDR'/g' /etc/manila/manila.conf
sed -i 's/MANILA_USER/'$MANILA_USER'/g' /etc/manila/manila.conf
sed -i 's/MANILA_PASS/'$MANILA_PASS'/g' /etc/manila/manila.conf
sed -i 's/RABBIT_ADDR/'$RABBIT_ADDR'/g' /etc/manila/manila.conf
sed -i 's/RABBIT_USER/'$RABBIT_USER'/g' /etc/manila/manila.conf
sed -i 's/RABBIT_PASS/'$RABBIT_PASS'/g' /etc/manila/manila.conf
