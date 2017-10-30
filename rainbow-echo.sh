#!/bin/bash

# A script to output colored text

# $# = argc
# $@ = argv

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

text=""
i=0

# add color code + every word to $text
for word in "$@"
do
  i=$((i + 1))
  if (( $i > 6 ))
  then
    i=$((1))
  fi
  color="${base_color}${i}m"
  text="$text $color $word"
done

# print the text and reset terminal color
echo -e $text $NO_COLOR

# TODO clear ' <-- that character from output
