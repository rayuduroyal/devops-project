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


exit
$ mv catalogue-main catalogue
$ cd /home/roboshop/catalogue
$ npm install --unsafe-perm
NOTE: We need to update the IP address of MONGODB Server in systemd.service file
Now, lets set up the service with systemctl.

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue
26 visits in last 30 days
