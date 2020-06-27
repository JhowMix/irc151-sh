#!/bin/bash

echo content-type: text/html
echo

echo -e "$(cat /etc/samba/smb.conf)"