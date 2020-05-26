#!/bin/bash


AlterandoIPDHCP(){
IP=$(dialog --title "Confirmacao" --inputbox "DIGITE O IP DESEJADO" 0 0 0 --stdout )

sed -i -r "10s|(addresses:).*|addresses: [$IP/24]|" /etc/netplan/50-cloud-init.yaml
netplan apply
}

function ReiniciarDHCP(){
dialog --title "CONFIRMACAO" --yesno "Deseja reiciniar o servico DHCP?" 0 0 && service isc-dhcp-server restart
}

function Range(){
IP_INICIO=$(dialog --title "Confirmacao" --inputbox "DIGITE O IP INICIAL" 0 0 0 --stdout )

IP_FINAL=$(dialog --title "Confirmacao" --inputbox "DIGITE O IP FINAL" 0 0 0 --stdout )

sed -i -r "12s|(range).*|range $IP_INICIO       $IP_FINAL;|" /etc/dhcp/dhcpd.conf
service isc-dhcp-server restart
}

function Apache(){
nano /var/www/html/index.html
}

function ReiniciarApache(){
dialog --title "CONFIRMACAO" --yesno "Deseja reiciniar o servico Apache?" 0 0 && service restart apache2
}

while : ; do
       OPCAO=$(dialog --title "menu" --inputbox "
        SELECIONE A OPCAO DESEJADA
        1  REINICIAR SERVICO APACHE
        2  ALTERAR O IP DO SERVIDOR DHCP
        3  REINICIAR O SERVICO DHCP
        4  DEFINIR O RANGE DE IP
        5  EDITAR PAGINA APACHE
        0  SAIR
        " 0 0 --stdout)



case $OPCAO in
1) ReiniciarApache ;;
2) AlterandoIPDHCP ;;
3) ReiniciarDHCP ;;
4) Range ;;
5) Apache ;;
0) exit ;;
esac
done
