#!/bin/bash
echo content-type: text/html
echo
read CONTENT

USERNAME=$(echo $CONTENT | jq -r '.username')
PASSWORD=$(echo $CONTENT | jq -r '.password')
RESULT=$(grep "$USERNAME&$PASSWORD" ../data/accounts)

if [ -z "$RESULT" ]; then
  echo ''
else
  echo $(cat ../public_html/faces/header.html)
  echo $(cat ../public_html/faces/map.html)
  echo $(cat ../public_html/faces/footer.html)
fi