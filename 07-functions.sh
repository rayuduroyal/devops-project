#!/bin/bash

## functions should be always declared before using it, same like variable
## so that is the reason, functio we always find in starting of the scripts

function abc() {
  echo iam a function abc
  a=100
  echo a in function =$a
  b=20
  echo first argument in function = $1
}
xyz() {
  iam a function xyz
}

## main program
a=10
abc rahul
echo b in main program =$b
xyz

echo first argument in main program = $1
