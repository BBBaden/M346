#!/bin/bash

# --- Variable definieren ---
export MYSQL_DB_ADDRESS="127.0.0.1"
export MYSQL_DB_PORT="3306"

# --- Prüfen, ob ein Parameter mitgegeben wurde ---
if [ -n "$1" ]; then
    echo "Parameter gefunden: Setze MYSQL_DB_ADDRESS auf $1"
    export MYSQL_DB_ADDRESS="$1"
fi

echo "Initialise the system..."

# --- System aktualisieren ---
dnf update -y

# --- Apache, PHP und MySQL-Erweiterung installieren ---
dnf install -y httpd php php-mysqlnd php-mbstring php-xml php-fpm

# --- Dienste starten und aktivieren ---
systemctl start httpd
systemctl enable httpd
systemctl start php-fpm
systemctl enable php-fpm

# --- phpMyAdmin herunterladen ---
cd /var/www/html
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
mkdir phpmyadmin
tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpmyadmin --strip-components 1

# --- Aufräumen und Rechte an Apache übertragen ---
rm phpMyAdmin-latest-all-languages.tar.gz
chown -R apache:apache /var/www/html/phpmyadmin
chmod -R 755 /var/www/html/phpmyadmin

# --- Verbindung zur RDS-Datenbank konfigurieren ---
cd /var/www/html/phpmyadmin
cp config.sample.inc.php config.inc.php

# RDS Host und Port setzen
sed -i "s|'localhost'|'$MYSQL_DB_ADDRESS'|" config.inc.php
sed -i "/\['host'\] = /a \$cfg['Servers'][\$i]['port'] = '$MYSQL_DB_PORT';" config.inc.php

echo "... phpMyAdmin erreichbar unter http://<public-ip>/phpmyadmin"
echo "... system initialised"
