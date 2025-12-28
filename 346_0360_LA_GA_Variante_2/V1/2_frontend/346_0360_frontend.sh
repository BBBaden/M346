#!/bin/bash

# --- Variable definieren ---
# Hier wird die IP gesetzt.
export BACKEND_ADDRESS="127.0.0.1"

echo "Initialise the system..."

# --- System aktualisieren ---
dnf update -y
dnf install -y git

echo "Clone git repo ..."
cd /home/ec2-user
git clone https://github.com/BBBaden/M346.git
echo "... git repo cloned"

SCRIPTDIR="/home/ec2-user/M346/346_0360_LA_GA_Variante_2/V1/3_common"
LADIR="/home/ec2-user/M346/346_0360_LA_GA_Variante_2/V1/1_frontend"
WORKDIR="/home/ec2-user/working-directory"

# Install Docker
sh "$SCRIPTDIR/install-docker.sh"

# Create working directory
mkdir -p "$WORKDIR"

# Move files to working-directory
# Wir kopieren die .env.base direkt als .env in das Zielverzeichnis
cp "$LADIR/.env" "$WORKDIR/.env"
mv "$LADIR/docker-compose.yml" "$WORKDIR"
mv "$SCRIPTDIR/m346-docker.service" "$WORKDIR"

# --- Platzhalter ersetzen ---
# Ersetzt exakt den String ${BACKEND_ADDRESS} durch den Inhalt der Variable
sed -i "s/\${BACKEND_ADDRESS}/$BACKEND_ADDRESS/g" "$WORKDIR/.env"

# Configure Service
cd "$WORKDIR"
sh "$SCRIPTDIR/configer-service.sh"

echo "... system initialised"