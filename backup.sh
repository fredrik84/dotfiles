#!/bin/bash
IFS="
"
for row in $(cat schemas/files.txt); do
  src=$(echo $row | awk {'print $2'} | sed -e "s#^~#$HOME#")
  dst=$(echo $row | awk {'print $1'} | sed -e "s#^~#$HOME#")
  cp -f $src $dst
done

if [ $? -eq 0 ]; then
  git commit -am "Update files @ $(date +%Y-%m-%d)"
  git push origin main
fi
