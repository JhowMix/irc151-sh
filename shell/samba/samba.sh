#!/bin/bash


function CRIARUSUARIO(){
USUARIO=$(dialog --inputbox "Digite o nome do usuario" 0 0 0 --stdout)


useradd -m $USUARIO
passwd $USUARIO

smbpasswd -a $USUARIO
}


function CRIARCOMPARTILHAMENTO(){
COMPARTILHAMENTO=$(dialog --inputbox "Digite o nome do compartilhamento" 0 0 0 --stdout)
ACESSO=$(dialog --inputbox "Digite o nome do usuario que tem acesso:" 0 0 0 --stdout)

mkdir /home/LPAR/$COMPARTILHAMENTO

chmod  +x /home/LPAR/$COMPARTILHAMENTO
echo "[$COMPARTILHAMENTO]
PATH = /home/LPAR/$COMPARTILHAMENTO
BROWSEABLE = YES
VALID USERS = $ACESSO" >> /etc/samba/smb.conf
}

function CRIARGRUPO(){
GRUPO=$(dialog --inputbox "Digite o nome do grupo:" 0 0 0 --stdout)
groupadd $GRUPO
}

function ADD_USU_GRUPO(){
USUARIO=$(dialog --inputbox "Digite o nome do usuario:" 0 0 0 --stdout)
GRUPO=$(dialog --inputbox "Digite o nome do grupo:" 0 0 0 --stdout)

gpasswd -a $USUARIO $GRUPO
}

function DESENVOLVEDORES(){
dialog --title "DESENVOLVEDORES" --msgbox "FELIPE GABRIEL RA:123321123
JAMES SOUSA RA: 122333444" 0 0

}

while : ; do

OPCAO=$(dialog --title "menu" --inputbox "
SELECIONE A OPCAO DESEJADA

1 CRIAR USUARIO SAMBA
2 CRIAR COMPARTILHAMENTO
3 CRIAR GRUPO
4 ADICIONAR USUARIO AO GRUPO
5 DESENVOLVEDORES
0 SAIR
" 0 0 --stdout)

case $OPCAO in
1)CRIARUSUARIO ;;
2)CRIARCOMPARTILHAMENTO ;;
3)CRIARGRUPO ;;
4)ADD_USU_GRUPO ;;
5)DESENVOLVEDORES ;;
0)exit ;;

esac
done

