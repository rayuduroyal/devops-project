#!/bin/bash

## To print some text on screen then we can use echo command or printf command
## we choose to go with echo command because of its less syntaxing

# syntax
# echo message to print

echo hello world
echo welcome

# ESC sequeces , \n (new line) ,\t (tab space) ,\e (new tab)

#syntax: echo -e "message\nNew line"
# to enable any esc seq we need to enable -e option
# also the input should be in quotes, preferably double quotes

# echo -e "hello world\nwelcome"

# echo -e "word1\tword2"

