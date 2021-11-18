Print() {
  LSPACE=$(echo $1 | awk '{print length}')
  SPACE=$(($MSPACE-$LSPACE))
  SPACES=""
  while [ $SPACE -gt 0 ]; do
    SPACES="$SPACES$(echo ' ')"
    SPACE=$(($SPACE-1))
  done
  echo -n -e "\e[1m$1${SPACES}\e[0m  ... "
  echo -e "\n\e[36m======================== $1 ========================\e[0m" >>$Log
}

Stat() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32mSUCCESS\e[0m"
  else
    echo -e "\e[1;31mFAILURE\e[0m"
    echo -e "\e[1;33mScript Failed and check the detailed log in $Log file\e[0m"
    exit 1
  fi
}

LOG=/tmp/roboshop.log
rm -f $Log

DOWNLOAD() {
  Print "Download $COMPONENT_NAME"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$Log
  Stat $?
  Print "Extract $COMPONENT_NAME Content"
  unzip -o -d $1 /tmp/${COMPONENT}.zip &>>$Log
  Stat $?
  if [ "$1" == "/home/roboshop" ]; then
    Print "Remove Old Content"
    rm -rf /home/roboshop/${COMPONENT}
    Stat $?
    Print "Copy Content"
    mv /home/roboshop/${COMPONENT}-main /home/roboshop/${COMPONENT}
    Stat $?
  fi
}

ROBOSHOP_USER() {
  Print "Add RoboShop User"
  id roboshop &>>$Log
  if [ $? -eq 0 ]; then
    echo User RoboShop already exists &>>$Log
  else
    useradd roboshop  &>>$Log
  fi
  Stat $?
}

SYSTEMD() {
  Print "Fix App Permissions"
  chown -R roboshop:roboshop /home/roboshop
  Stat $?

  Print "Update DNS records in SystemD config"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTHOST/cart.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' -e 's/AMQPHOST/rabbitmq.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service  &>>$Log
  Stat $?

  Print "Copy SystemD file"
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>$Log
  Stat $?

  Print "Start ${COMPONENT_NAME} Service"
  systemctl daemon-reload &>>$Log && systemctl restart ${COMPONENT} &>>$Log && systemctl enable ${COMPONENT} &>>$Log
  Stat $?
}

CHECK_MONGO_FROM_APP() {
  print "Checking DB Connections From APP"
  sleep 5
  STAT=$(curl -s localhost:8080/health | jq .mongo)
  if [ "$STAT" == "true" ];then
    stat 0
  else
    stat 1
  fi

}
