#!/bin/bash

source components/common.sh

print "download repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo.
stat $?

print "Install MongoDB"
yum install -y mongodb-org
stat $?

print "Update MongoDB Config"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
stat $?

print "Start MongoDB"
systemctl Restart mongod
stat $?

print "Enabling MongoDB"
syste#mctl enable mongod
stat $?

print "Download schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
stat $?

print "Extract Schema"
Unzip -o -d /tmp mongodb.zip
stat $?

print "Load schema"
cd /tmp/mongodb-main
mongo < catalogue.js
mongo < users.js
stat $?


