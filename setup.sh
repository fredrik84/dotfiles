#!/bin/bash
IFS="
"
for row in $(cat files.txt); do
  src=$(echo $row | awk {'print $1'} | sed -e "s#^~#$HOME#")
  dst=$(echo $row | awk {'print $2'} | sed -e "s#^~#$HOME#")
  cp -f $src $dst
done

for script in $(find scripts/ -type f); do
  bash $script
done
