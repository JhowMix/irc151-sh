#!/bin/bash
echo content-type: text/html
echo
read CONTENT

ROOT_PASS="123605aBc@"

NOME=$(echo $CONTENT | jq -r '.nome')
DIRETORIO=$(echo $CONTENT | jq -r '.path')
USUARIOS=$(echo $CONTENT | jq -r '.usuarios')

# echo -e "
# [$NOME]
#   path = $DIRETORIO
#   writeable = yes
#   browseable = yes
#   valid users = $USUARIOS ??" >> /etc/samba/smb.conf

IFS=',' read -ra ARRAY_USUARIOS <<< $USUARIOS

for USUARIO in "${ARRAY_USUARIOS[@]}";
do
  export USUARIO=$USUARIO
  useradd $USUARIO;
  echo $ROOT_PASS | sudo -S --preserve-env -u root echo $USUARIO
done

echo $ROOT_PASS | sudo -S -u root service smbd restart

addUsuarioSamba() {
   
}