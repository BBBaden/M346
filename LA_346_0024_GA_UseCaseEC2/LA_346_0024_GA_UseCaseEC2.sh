#!/bin/bash

echo "Initialise the system..."

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
LADIR="/home/ec2-user/M346/LA_346_0024_GA_UseCaseEC2"

mv "$LADIR/.env.base" "$WORKDIR"
mv "$LADIR/docker-compose.yml" "$WORKDIR"

#Generate .env
cd "$WORKDIR"
sh "$SCRIPTDIR/generate-prod-env.sh"

#Configure Service
cd "$WORKDIR"
sh "$SCRIPTDIR/configer-service.sh"

echo "... system initialised"
