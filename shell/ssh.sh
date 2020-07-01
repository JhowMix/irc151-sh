#!/bin/bash
echo content-type: text/html
echo

read content
N=$(echo $content | cut -d "=" -f2 | cut -d "&" -f1) 
echo $N
echo "<br>"
I=$(echo $content | cut -d "=" -f3) 
echo $I
ssh://$n@$I
#TESTE=$(echo "aluno12345" | sudo -S -u root ssh $N@$I "service ssh status")
#echo $TESTE
#echo $(echo $content | cut -d "&" -f2)
#echo "##################### MENU ################################"

#function atualizar()  
# {
#echo "sera feito um update das bibliotecas"
#apt-get update
#}

#function ssh()
# {
#echo "vai ser instalado o ssh"
#    apt-get install openssh-server

#}

#function statusssh()
# {
#echo "esse é o status do serviço"
#service ssh status
#}

#function reiniciarssh()
# {
#service ssh restart
#}

#function acessoviassh()

#echo nome usuario"
#a= jonatan
 
#echo ip da maquina"
#b= 10.0.0.113
 # {
#ssh-keygen jonatan@10.0.0.113 -p 22
#}

#echo "escolha uma opção do menu"

#while :
 #do
##echo "
#1- update 
#2- instalar ssh
#3- status ssh
#4- resetar ssh
#5- acessar via ssh
#6-
#0- sair
#"
#read OPCAO


#case $OPCAO in 

#1) atualizar ;;
#2) ssh ;;
#3) statusssh ;;
#4) reiniciarssh ;;
#5) acessoviassh ;;
#0) exit ;;
#*) echo "nao é valido"
#exit;;

#esac
#done
