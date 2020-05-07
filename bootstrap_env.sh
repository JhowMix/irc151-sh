#!/bin/bash

#apt install ssh -y;
apt install apache2 -y;
HOSTS_CONF='/etc/apache2/sites-available/000-default.conf';
MIMES_CONF='/etc/apache2/mods-available/mime.conf';
CGI_CONF='/etc/apache2/conf-available/serve-cgi-bin.conf';
sed -i '/DocumentRoot.*/ a \\t<Directory "/var/www/html/site00/public_html">\n\t\tOptions Indexes FollowSymLinks\n\t\tAllowOverride All\n\t\tRequire all granted\n\t</Directory>' $HOSTS_CONF;

sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/site00\/public_html/' $HOSTS_CONF;
sed -i 's/\#Include conf\-available\/serve\-cgi\-bin\.conf/Include conf\-available\/serve\-cgi\-bin\.conf/' $HOSTS_CONF;
sed -i 's/\#AddHandler cgi\-script \.cgi/AddHandler cgi\-script \.cgi \.sh/' $MIMES_CONF;
sed -i 's/ScriptAlias \/cgi\-bin\/ \/usr\/lib\/cgi\-bin\//ScriptAlias \/cgi\-bin\/ \/var\/www\/html\/site00\//' $CGI_CONF;
sed -i 's/\"\/usr\/lib\/cgi\-bin\"/\"\/var\/www\/html\/site00\/shell\"/' $CGI_CONF;
echo "LoadModule cgi_module /usr/lib/apache2/modules/mod_cgi.so" >  /etc/apache2/mods-available/cgi.load
echo "LoadModule cgi_module /usr/lib/apache2/modules/mod_cgi.so" > /etc/apache2/mods-enabled/cgi.load

rm /var/www/html/index.html;
mkdir -p /var/www/html/site00/shell;
mkdir -p /var/www/html/site00/public_html;
echo "<h3>Ambiente em funcionamento...<h3>" > /var/www/html/site00/public_html/index.html;
a2enmod cgid
a2enmod cgi
systemctl restart apache2
service apache2 reload
service apache2 restart;

