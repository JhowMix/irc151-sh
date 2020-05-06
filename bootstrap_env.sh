#!/bin/bash

apt install ssh -y;
apt install apache2 -y;
sed -ri \
'/DocumentRoot.*/ a \\t<Directory "/var/www/html/site00/public_html">\n\t\tOptions Indexes FollowSymLinks\n\t\tAllowOverride All\n\t\tRequire all granted\n\t</Directory>' \ 
/etc/apache2/sites-available/000-default.conf && \
sed -ri  \
's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/site00\/public_html/' 
/etc/apache2/sites-available/000-default.conf