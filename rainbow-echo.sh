#!/bin/bash

# A script to output colored text
VERSION="1.1"

# $# = argc
# $@ = argv
argc=$#

# color codes
NO_COLOR='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'

# color code without last 2 characters
base_color='\033[1;3'
color=""

# functions
print_help_text()
{
    echo -e "\t -h \t print this help text"
    echo -e "\t -f \t print content of a file"
    echo -e "\t -v \t print version"
    echo -e ""
    echo -e "\t usage: "
    echo -e "\t rainbow-echo Make this text colorful"
}

print_version()
{
    echo $VERSION
}

print_file_content()
{
    if [ $argc != 2 ]    # check for 2 args
    then
        echo "missing filename"
        exit
    fi

    text_from_file=""
    text=""
    i=0
    filename=$2         # second argument

    # read text from file to variable text_from_file
    while read -r line
    do
        text_from_file="$text_from_file $line"
    done < "$filename"

    # add color code + every word to $text
    for word in $text_from_file
    do
      i=$((i + 1))                  # i++
      if (( $i > 6 ))               # if i > 6
      then
        i=$((1))                    # i = 1
      fi
      color="${base_color}${i}m"    # create color code
      text="$text $color $word"     # text += text + color + word
    done

    # print the text and reset terminal color
    echo -e $text $NO_COLOR
}

print_arg_text()
{
    text=""
    i=0

    # add color code + every word to $text
    for word in $@
    do
      i=$((i + 1))                  # i++
      if (( $i > 6 ))               # if i > 6
      then
        i=$((1))                    # i = 1
      fi
      color="${base_color}${i}m"    # create color code
      text="$text $color $word"     # text += text + color + word
    done

    # print the text and reset terminal color
    echo -e $text $NO_COLOR
}

###################### start ######################
if [ $argc == 0 ]; then
    exit
elif [ "$1" == "-h" ]; then
    print_help_text
elif [ "$1" == "-f" ]; then
    print_file_content $@
elif [ "$1" == "-v" ]; then
    print_version
else
    print_arg_text $@   # pass the command line arguments
fi
