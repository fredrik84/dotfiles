#!/bin/bash
FILE="schemas/$(echo $0 | cut -c '4-' | sed -e 's#.sh\$#.txt#')"
IFS="
"
for row in $(cat $FILE); do
  src=$(echo $row | awk {'print $1'} | sed -e "s#^~#$HOME#")
  dst=$(echo $row | awk {'print $2'} | sed -e "s#^~#$HOME#")
  cp -f $src $dst
done
