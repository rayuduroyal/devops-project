#!/bin/bash

# Loops are two major commands , while & for

# While loop marks on Expressions that we used in if statements

a=10
while [ $a -gt 0 ]; do
  echo while Loop
  sleep 0.5
  a=$(($a-1))
done

