#!/bin/bash

echo content-type: text/html
echo

ping -c1 10.0.0.109 > /dev/null ; PC1_STATUS=$?

jq -n "{ pc1_status: $PC1_STATUS }" | jq .
