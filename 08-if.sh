#!/bin/bash

read -p 'enter username: ' username

if [ "$username" == "root" ]; then
  echo "hey, you are root user"
else
  echo Hey, you are nonroot user
fi

if [ $UID -eq 0 ]; then
  echo you are a root user
else
   echo you are nonroot user
fi
