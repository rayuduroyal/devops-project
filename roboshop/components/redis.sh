#!/bin/bash

source components/common.sh
MSPACE=$(cat $0 | grep ^print | awk -F '"' '{print $2}' | awk '{ print length }' | sort | tail -1)

print"Install Redis Repos"
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$Log
stat $?

print "Enable Redis Repos"
yum-config-manager --enable remi &>>$Log
stat $?

print "Install Redis"
yum install redis -y &>>$Log
stat $?

print "Update Redis Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>$Log
stat $?

print "Start Redis Database"
systemctl enable redis &>>$Log && systemctl start redis &>>$Log
stat $?
