#!/bin/bash

echo content-type: text/html
echo

PC01=$(head -1 ../data/hosts | tail -1 | sed 's/PC01=//')
PC02=$(head -2 ../data/hosts | tail -1 | sed 's/PC02=//')
PC03=$(head -3 ../data/hosts | tail -1 | sed 's/PC03=//')
PC04=$(head -4 ../data/hosts | tail -1 | sed 's/PC04=//')
PC05=$(head -5 ../data/hosts | tail -1 | sed 's/PC05=//')
PC06=$(head -6 ../data/hosts | tail -1 | sed 's/PC06=//')

ping -c1 $PC01 > /dev/null ; PC01_STATUS=$?
ping -c1 $PC02 > /dev/null ; PC02_STATUS=$?
ping -c1 $PC03 > /dev/null ; PC03_STATUS=$?
ping -c1 $PC04 > /dev/null ; PC04_STATUS=$?
ping -c1 $PC05 > /dev/null ; PC05_STATUS=$?
ping -c1 $PC06 > /dev/null ; PC06_STATUS=$?

jq -n "{ pc1_status: $PC01_STATUS, pc2_status: $PC02_STATUS, pc3_status: $PC03_STATUS, pc4_status: $PC04_STATUS, pc5_status: $PC05_STATUS, pc6_status: $PC06_STATUS }" | jq .
