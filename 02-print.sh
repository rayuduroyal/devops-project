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

# echo -e "word1\t\tword2"

# coloured output
# syntax echo -e "\e[COLmMessage"

## colours        CODE
# Red               31
# Green             32
# Yellow            33
# Blue              34
# magenta           35
# cyan              36

# echo -e "\e[31mText in Red colour"
# echo -e "\e[32mText in Green colour"
# echo -e "\e[33mText in Yellow colour"
# echo -e "\e[34mText in Blue colour"
# echo -e "\e[35mText in Magenta colour"
# echo -e "\e[36mText in Cyan colour"

# https://misc.flogisoft.com/bash/tip_colors_and_formatting

## color always follows
echo -e "\e[31mText in Red color"

echo Text in normal color




