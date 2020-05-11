#!/bin/bash
echo content-type: text/html
echo
read CONTENT
echo '<h2>CGI FUNCIONANDO</h2>'
echo '<p>POST BODY:</p>'
echo '</br>'
echo $CONTENT
