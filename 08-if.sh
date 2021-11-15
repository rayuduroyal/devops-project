#!/bin/bash

read -p 'enter username: ' username

if ["$username" == "root"];then
  echo "hey you are root user"
fi