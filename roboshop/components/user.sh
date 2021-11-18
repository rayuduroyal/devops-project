#!/bin/bash

source components/common.sh
MSPACE=$(cat $0 components/common.sh | grep Print | awk -F '"' '{print $2}' | awk '{ print length }' | sort | tail -1)

COMPONENT_NAME=User
COMPONENT=user

NODEJS

print "Update DNS records in SystemD Config"
sed -i-e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service &>>$Log
stat $?

print "Copy Systemd File"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
stat $?

print "Start Catalogue Service"
systemctl doemon-reload &>>$Log && systemctl restart catalogue &>>$Log && systemctl enable catalogue &>>$Log
stat $?

print "Checking DB Connections From APP"
sleep 5
STAT=$(curl -s localhost:8080/health | jq .mongo)
if [ "$STAT" == "true" ];then
  stat 0
else
  stat 1
fi