#!/bin/bash

source components/common.sh

print "Install NodeJS"
yum install nodejs make gcc-c++ -y &>>$Log
stat $?

print "Add RoboShop User"
id roboshop &>>$Log
if [ $? -eq 0 ]; then
  echo User Roboshop already exists &>>$Log
else
  useradd roboshop &>>$Log
fi
stat $?

print "Download Catalogue"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$Log
stat $?

print "Remove Old content"
rm -rf /home/roboshop/catalogue &>>$Log
stat $?

print "Extract Catalogue"
unzip -o -d  /home/roboshop /tmp/catalogue.zip &>>$Log
stat $?

print "Copy Content"
mv /home/roboshop/catalogue-main /home/roboshop/catalogue &>>$Log
stat $?

print "Install NodeJS Dependencies"
cd /home/roboshop/catalogue
npm install --unsafe-perm &>>$Log
stat $?

print "Fix App Permissions"
chown -R roboshop:roboshop /home/roboshop &>>$Log
stat $?

print "Update Dns records in SystemD Config"
set -i -e 's/MONGO DNSNAME/mongodb.roboshop.internal'/home/roboshop/catalogue/systemd.service &>>$Log
stat $?

print "Copy SystemD File"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$Log
stat $?

print "Start Catalogue Service"
systemctl daemon-reload &>>$Log
systemctl restart catalogue &>>$Log
systemctl enable catalogue &>>$Log
stat $?

