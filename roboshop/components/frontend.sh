#!/bin/bash

source components/common.sh
MSPACE=$(cat $0 | grep ^print | awk -F '"' '{print $2}' | awk '{ print length }' | sort | tail -1)

print "installing nginx"
yum install nginx -y &>>$LOG
stat $?

print "enabling nginx"
systemctl enable nginx &>>$LOG
stat $?

print "starting nginx"
systemctl start nginx &>>$LOG
stat $?

print "download Html pages"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
stat $?

print "remove old Html pages"
rm -rf /usr/share/nginx/html/* &>>$LOG
stat $?

print "extract frontend archive"
unzip -o -d /tmp /tmp/frontend.zip &>>$LOG
stat $?

print "copy files to nginx path"
mv /tmp/frontend-main/static/* /usr/share/nginx/html/. &>>$LOG
stat $?

print "copy Nginx Roboshop config file"
cp /tmp/frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
stat $?

print "Enabling nginx"
systemctl enable nginx &>>$LOG
stat $?

print "starting nginx"
systemctl start nginx &>>$LOG
stat $?

