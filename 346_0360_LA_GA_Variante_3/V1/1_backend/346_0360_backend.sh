#!/bin/bash


# --- Variable definieren ---
# Hier wird die IP gesetzt.
export MYSQL_DB_ADDRESS="127.0.0.1"
export MYSQL_ROOT_PASSWORD="rootpass"
export MYSQL_USER="admin"

echo "Initialise the system..."

# --- System aktualisieren ---
dnf update -y

# --- Docker installieren ---
dnf install -y git

echo "Clone git repo ..."
cd /home/ec2-user
git clone https://github.com/BBBaden/M346.git
echo "... git repo cloned"

SCRIPTDIR="/home/ec2-user/M346/346_0360_LA_GA_Variante_2/V1/3_common"
LADIR="/home/ec2-user/M346/346_0360_LA_GA_Variante_2/V1/1_backend"
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
sed -i "s/\${MYSQL_ROOT_PASSWORD}/$MYSQL_ROOT_PASSWORD/g" "$WORKDIR/.env"
sed -i "s/\${MYSQL_USER}/$MYSQL_USER/g" "$WORKDIR/.env"

#Configure Service
cd "$WORKDIR"
sh "$SCRIPTDIR/configer-service.sh"

echo "... system initialised"
