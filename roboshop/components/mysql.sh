#!/bin/bash

source components/common.sh

MSPACE=$(cat $0 components/common.sh | grep Print | awk -F '"' '{print $2}' | awk '{ print length }' | sort | tail -1)


COMPONENT_NAME=MySQL
COMPONENT=mysql

Print "Setup MySQL Repo"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
Stat $?

Print "Install MariaDB Service"
yum remove mariadb-libs -y &>>$Log  && yum install mysql-community-server -y &>>$Log
Stat $?

Print "Start MySQL Service"
systemctl enable mysqld &>>$Log && systemctl start mysqld &>>$Log
Stat $?

DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
NEW_PASSWORD="RoboShop@1"

echo 'show databases;' | mysql -uroot -p"${NEW_PASSWORD}"  &>>$Log
if [ $? -ne 0 ]; then
  Print "Changing the Default Password"
  echo -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${NEW_PASSWORD}';\nuninstall plugin validate_password;" >/tmp/pass.sql
  mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" </tmp/pass.sql &>>$Log
  Stat $?
fi

DOWNLOAD "/tmp"

Print "Load Schema"
cd /tmp/mysql-main
mysql -u root -pRoboShop@1 <shipping.sql &>>$Log
Stat $?