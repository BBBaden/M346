#!/bin/bash

# Folgende Variablen auf eigene Umgebung anpassen
export MYSQL_DB_ADDRESS="db-0474-pri-1a.canxietcztcs.us-east-1.rds.amazonaws.com"
export MYSQL_USER="admin"
export MYSQL_USER_PASSWORD="test12345"
# Ende Variable anpassen

# --- Hier nichts anpassen ---
echo "Initialise the system..."
LADIR="/home/ec2-user/M346/346_0304_LA_GA_Variante_3/1_frontbackend/deployment"

# --- System aktualisieren ---
dnf update -y

# --- Docker installieren ---
dnf install -y git

echo "Clone git repo ..."
cd /home/ec2-user
git clone https://github.com/BBBaden/M346.git
echo "... git repo cloned"

SCRIPTDIR="/home/ec2-user/M346/Common"
WORKDIR="/home/ec2-user/working-directory"

# Install Docker
sh "$SCRIPTDIR/install-docker.sh"

# Create working directory
mkdir -p "$WORKDIR"

# Move files to working-directory
mv "$LADIR/.env" "$WORKDIR"
mv "$LADIR/docker-compose.yml" "$WORKDIR"
mv "$SCRIPTDIR/m346-docker.service" "$WORKDIR"

# --- Platzhalter ersetzen ---
# Ersetzt exakt den String ${...} durch den Inhalt der Variable
sed -i "s/\${MYSQL_DB_ADDRESS}/$MYSQL_DB_ADDRESS/g" "$WORKDIR/.env"
sed -i "s/\${MYSQL_ROOT_PASSWORD}/$MYSQL_USER_PASSWORD/g" "$WORKDIR/.env"
sed -i "s/\${MYSQL_USER}/$MYSQL_USER/g" "$WORKDIR/.env"

#Configure Service
cd "$WORKDIR"
sh "$SCRIPTDIR/configer-service.sh"

echo "... system initialised"
