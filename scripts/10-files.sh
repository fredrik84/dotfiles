#!/bin/bash
FILE="schemas/$(echo $0 | cut -c '4-' | sed -e 's#.sh\$#.txt#')"
IFS="
"
for row in $(cat $FILE); do
  src=$(echo $row | awk {'print $1'} | sed -e "s#^~#$HOME#")
  dst=$(echo $row | awk {'print $2'} | sed -e "s#^~#$HOME#")
  mkdir -p $(dirname $dst) 2> /dev/null
  ln -sf $src $dst
done

source ~/.bash_profile
