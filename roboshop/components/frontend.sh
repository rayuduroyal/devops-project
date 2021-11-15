#!/bin/bash

source components/common.sh

print "installing nginx"
yum install nginx -y &>>$Log
stat $?

print "enabling nginx"
systemctl enable nginx &>>$Log
stat $?

print "starting nginx"
systemctl start nginx &>>$Log
stat $?

print "download Html pages"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$Log
stat $?

exit
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx

