#!/bin/bash
echo content-type: text/html
echo
read CONTENT

NOME=$(echo $CONTENT | jq -r '.nome')
DIRETORIO=$(echo $CONTENT | jq -r '.path')
USUARIOS=$(echo $CONTENT | jq -r '.usuarios')
PASSWORD="123605"

echo -e "[$NOME]
  path = $DIRETORIO
  writeable = yes
  browseable = yes
  valid users = $USUARIOS
#END">> /etc/samba/smb.conf

IFS=',' read -ra ARRAY_USUARIOS <<< $USUARIOS

for USUARIO in "${ARRAY_USUARIOS[@]}"
do
  useradd $USUARIO;
  echo $PASSWORD | sudo -S -u root bash -c \
  "echo -e '123456\n123456' | smbpasswd -a -s $USUARIO"
  echo $USUARIO
done

echo $PASSWORD | sudo -S -u root service smbd restart