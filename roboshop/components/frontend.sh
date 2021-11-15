#!/bin/bash

print() {
  echo -n -e "\e[1m$1\e[0m ..."
  echo -e "\n\e[36m==================== $1 ====================\e[0m" >>$Log
  }

Log=/tmp/roboshop.log
rm -rf $Log

print "installing nginx"
yum install nginx -y &>>$Log
if [ $? -eq 0 ]; then
  echo -e "\e[1;32mSUCCESS\e[0m"
else
  echo -e "\e[1;31mFAILURE\e[0m"
fi


print "enabling nginx"
systemctl enable nginx
print "starting nginx"
systemctl start nginx

exit
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx

