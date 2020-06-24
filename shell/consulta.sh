#!/bin/bash

echo content-type: text/html
echo

#verificar status da maquina 

#verificar hostname
echo ===============================================

echo o nome da sua maquina é:

hostname

echo ===============================================
#Informação do IP da maquina
echo seu IP é:
ip a  | grep enp0s3 | grep brd | cut -d " " -f6 | cut -d "/" -f1 

echo ===============================================
#consultar a memoria
echo Memoria de sua maquina:

free -m -t 

free | tr -s ' ' | sed '/^Mem/!d' | cut -d" " -f2
echo ===============================================
