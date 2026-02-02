#!/bin/bash

#Folgende Variablen auf eigene Umgebung anpassen
export BACKEND_ADDRESS="192.168.2.61"
export S3_URL="0474-is-s3-ue1-091ffbd5-d11c-4a31-afed-51424f705471.s3.us-east-1.amazonaws.com"
# Ende Variable anpassen

# --- Hier nichts anpassen ---
echo "Initialise the system..."
LADIR="/home/ec2-user/M346/346_0334_LA_GA_Variante_4/2_frontend/deployment"

# --- System aktualisieren ---
dnf update -y
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
# Wir kopieren die .env.base direkt als .env in das Zielverzeichnis
mv "$LADIR/.env" "$WORKDIR"
mv "$LADIR/docker-compose.yml" "$WORKDIR"
mv "$SCRIPTDIR/m346-docker.service" "$WORKDIR"

# --- Platzhalter ersetzen ---
# Ersetzt exakt den String ${BACKEND_ADDRESS} durch den Inhalt der Variable
sed -i "s/\${BACKEND_ADDRESS}/$BACKEND_ADDRESS/g" "$WORKDIR/.env"
sed -i "s|\${IMAGE_HOST_URL}|https://$S3_URL|g" "$WORKDIR/.env"
sed -i "s/\${IMAGE_HOST}/$S3_URL/g" "$WORKDIR/.env"

# Configure Service
cd "$WORKDIR"
sh "$SCRIPTDIR/configer-service.sh"

echo "... system initialised"
