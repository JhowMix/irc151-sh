#!/bin/bash

echo "#####################################################";
echo "                       ATENÇÃO";
echo "#####################################################";
echo -e "Todos arquivos vinculados a instalações de apache2\nserão removidos. Deseja continuar? [S/n] ";
read CONTINUE

if [ $CONTINUE == 'S' ] ; then
	apt remove --purge apache2 -y;
	apt remove --purge samba -y;
	
	if [ -e '/var/www/html' ] ; then 
		rm -rf /var/www/html;
	fi

	if [ -e '/etc/apache2' ] ; then
		rm -rf /etc/apache2;
	fi

	apt install apache2 jq samba -y;
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

	rsync --remove-source-files -r . /var/www/html/site00/
	cd /var/www/html/site00/
	rm -rf ~/irc151-sh
	chmod a+x /var/www/html/site00/shell/teste.sh
	a2enmod cgid
	a2enmod cgi
	systemctl restart apache2
	service apache2 reload
	service apache2 restart

	cp /etc/samba/smb.conf /etc/samba/smb.conf.org
	echo -e "# ======================= Global Settings =======================\n" > /etc/samba/smb.conf
	echo "[global]" >> /etc/samba/smb.conf
	echo "    workgroup = workgroup" >> /etc/samba/smb.conf
	echo "    security = user" >> /etc/samba/smb.conf
	echo "    server string = Samba Server %v" >> /etc/samba/smb.conf
	echo "    log file = /var/log/samba/%m.log" >> /etc/samba/smb.conf
	echo -e "    max log file = 50\n" >> /etc/samba/smb.conf
	echo -e "# ====================== Share Definitions ======================\n" >> /etc/samba/smb.conf

	service smbd restart
	apt autoremove -y;
	clear

	echo "#####################################################";
	echo "                 INSTALAÇÃO CONCLUÍDA !!";
	echo "#####################################################";
fi