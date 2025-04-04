#!/bin/bash
IFS="
"
for row in $(cat files.txt); do
  row=$(echo $row | sed -e "s#^~#$HOME#")
  echo row
  src=$(echo $row | awk {'print $1'})
  dst=$(echo $row | awk {'print $2'})
  cp -f $src $dst
done
