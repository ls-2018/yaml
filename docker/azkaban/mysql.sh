yum autoremove mysql*
rpm -ivh https://repo.mysql.com//mysql80-community-release-el7-3.noarch.rpm
yum-config-manager --disable mysql80-community
yum-config-manager --enable mysql57-community
yum install -y mysql-community-server

systemctl enable mysqld.service
systemctl start mysqld.service
systemctl status mysqld.service

AZKABAN_PATH=/opt/bigdata/azkaban-3.90.0


mysql -uroot -p20153367@aA -e "ALTER USER USER() IDENTIFIED WITH mysql_native_password BY '123456';"
mysql -uroot -p20153367@aA -e "update user set host='%' where user='root';flush privileges;"
mysql -uroot -p20153367@aA -e "drop database if exists azkaban;create database azkaban;use azkaban;source $AZKABAN_PATH/azkaban-db/create-all-sql-0.1.0-SNAPSHOT.sql;"
