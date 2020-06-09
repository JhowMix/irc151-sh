#!/bin/bash

echo content-type: text/html
echo

ping -c1 172.20.0.28 > /dev/null ; PC1_STATUS=$?

jq -n "{ pc1_status: $PC1_STATUS }" | jq .