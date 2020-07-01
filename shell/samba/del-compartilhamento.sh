#!/bin/bash

echo content-type: text/html
echo

read CONTENT

NOME=$(echo $CONTENT | jq -r '.nome')
PASSWORD="123605"
echo $PASSWORD | sudo -S -u root sed -i "/\[$NOME\]/,/\#END/d" /etc/samba/smb.conf;
echo $PASSWORD | sudo -S -u root service smbd restart