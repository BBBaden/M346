#!/bin/bash

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

# Move files to working-directory
LADIR="/home/ec2-user/M346/346_0030_LA_TicTacToeInDerCloud"

shopt -s dotglob
mv "$LADIR"/* "$WORKDIR"
shopt -u dotglob
mv "$SCRIPTDIR/m346-docker.service" "$WORKDIR"

#Configure Service
cd "$WORKDIR"
sh "$SCRIPTDIR/configer-service.sh"

echo "... system initialised"
