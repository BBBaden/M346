#!/bin/bash

# Folgende Variablen auf eigene Umgebung anpassen
export IMAGE_BUCKET_NAME="0474-is-s3-ue1-091ffbd5-d11c-4a31-afed-51424f705471"
export IMAGE_S3_URL="0474-is-s3-ue1-091ffbd5-d11c-4a31-afed-51424f705471.s3.us-east-1.amazonaws.com"
export FRONTEND_S3_URL="0474-is-s3-ue1-091ffbd5-d11c-4a31-afed-51424f705471.s3.us-east-1.amazonaws.com"
# Ende Variable anpassen


# Move files to working-directory
LADIR="/home/ec2-user/M346/346_0344_LA_GA_Variante_1/1_frontbackend/deployment"

echo "Initialise the system..."

# --- System aktualisieren ---
dnf update -y

# --- Docker installieren ---
dnf install -y git

echo "Clone git repo ..."
cd /home/ec2-user
git clone https://github.com/BBBaden/M346.git
echo "... git repo cloned"

SCRIPTDIR="/home/ec2-user/M346/Common"

# Install Docker
sh "$SCRIPTDIR/install-docker.sh"

# Create working directory
WORKDIR="/home/ec2-user/working-directory"
mkdir -p "$WORKDIR"

mv "$LADIR/.env" "$WORKDIR"
mv "$LADIR/docker-compose.yml" "$WORKDIR"
mv "$SCRIPTDIR/m346-docker.service" "$WORKDIR"

# --- Platzhalter ersetzen ---
# Ersetzt exakt den String ${BACKEND_ADDRESS} durch den Inhalt der Variable
sed -i "s|\${FRONTEND_HOST_URL}|https://$FRONTEND_S3_URL|g" "$WORKDIR/.env"
sed -i "s/\${FRONTEND_HOST}/$FRONTEND_S3_URL/g" "$WORKDIR/.env"
sed -i "s|\${IMAGE_HOST_URL}|https://$IMAGE_S3_URL|g" "$WORKDIR/.env"
sed -i "s/\${IMAGE_HOST}/$IMAGE_S3_URL/g" "$WORKDIR/.env"
sed -i "s/\${BUCKET_NAME}/$IMAGE_BUCKET_NAME/g" "$WORKDIR/.env"


#Configure Service
cd "$WORKDIR"
sh "$SCRIPTDIR/configer-service.sh"

echo "... system initialised"
