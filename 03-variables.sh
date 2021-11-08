#!/bin/bash

## if we assign a name to a set of data , then that is a variable
# syntax VAR=DATA

# number
a=100
# string
b=abc

# in bash shell and also wby default there are no data types, shell considers everything as string

# access the data in shell using $ charecter prifixing the variable name, or you can access variable with ${}

# echo value of a=$a
# echo value of b=$b

# echo value of a=${a}
# echo value of b=${b}

x=10
y=20
# echo ${x}X${y} = 200

# Date=2021-10-20
# Date = $(Date +%f)
# echo Good Morning , Welcome , Today date is $Date

# arthematic substitution
# ADD = $((2+3+4+5+6*7/2-5))
# echo Added = $Add