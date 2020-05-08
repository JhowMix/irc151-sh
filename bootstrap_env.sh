#!/bin/bash


echo "#####################################################";
echo "                       ATENÇÃO";
echo "#####################################################";
echo -e "Todos arquivos vinculados a instalações de apache2\nserão removidos. Deseja continuar? [S/n] ";
read CONTINUE

if [ $CONTINUE == 'S' ] ; then
	apt remove --purge apache2 -y;
	apt autoremove -y;

	if [ -e '/var/www/html' ] ; then 
		rm -rf /var/www/html;
	fi

	if [ -e '/etc/apache2' ] ; then
		rm -rf /etc/apache2;
	fi

	apt install apache2 -y;
	HOSTS_CONF='/etc/apache2/sites-available/000-default.conf';
	MIMES_CONF='/etc/apache2/mods-available/mime.conf';
	CGI_CONF='/etc/apache2/conf-available/serve-cgi-bin.conf';

	sed -i '/DocumentRoot.*/ a \\t<Directory "/var/www/html/site00/public_html">\n\t\tOptions Indexes FollowSymLinks\n\t\tAllowOverride All\n\t\tRequire all granted\n\t</Directory>' $HOSTS_CONF;
	sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/site00\/public_html/' $HOSTS_CONF;
	sed -i 's/\#Include conf\-available\/serve\-cgi\-bin\.conf/Include conf\-available\/serve\-cgi\-bin\.conf/' $HOSTS_CONF;
	sed -i 's/\#AddHandler cgi\-script \.cgi/AddHandler cgi\-script \.cgi \.sh/' $MIMES_CONF;
	sed -i 's/ScriptAlias \/cgi\-bin\/ \/usr\/lib\/cgi\-bin\//ScriptAlias \/shell\/ \/var\/www\/html\/site00\/shell\//' $CGI_CONF;
	sed -i 's/\"\/usr\/lib\/cgi\-bin\"/\"\/var\/www\/html\/site00\/shell\"/' $CGI_CONF;

	echo "LoadModule cgi_module /usr/lib/apache2/modules/mod_cgi.so" >  /etc/apache2/mods-available/cgi.load
	echo "LoadModule cgi_module /usr/lib/apache2/modules/mod_cgi.so" > /etc/apache2/mods-enabled/cgi.load

	rm /var/www/html/index.html;
	mkdir -p /var/www/html/site00/shell;
	mkdir -p /var/www/html/site00/public_html;

	echo -e "<h2>TESTE CGI</h2>\n</br>\n<form method='post' action='shell/teste.sh'>\n\tCampo 1: <input type='text' name='campo_1' />\n\t</br>\n\tCampo 2: <input type='text' name='campo_2' />\n\t</br>\n\t<input type='submit'value='Enviar' />\n</form>" > /var/www/html/site00/public_html/index.html;
	echo -e "#!/bin/bash\necho content-type: text/html\necho\nread CONTENT\necho '<h2>CGI FUNCIONANDO</h2>'\necho '<p>POST BODY:</p>'\necho '</br>'\necho \$CONTENT" > /var/www/html/site00/shell/teste.sh

	chmod a+x /var/www/html/site00/shell/teste.sh
	a2enmod cgid
	a2enmod cgi
	systemctl restart apache2
	service apache2 reload
	service apache2 restart

	clear

	echo "#####################################################";
	echo "                 INSTALAÇÃO CONCLUÍDA !!";
	echo "#####################################################";
fi
