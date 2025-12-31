#!/bin/bash
echo "Install docker ..."
# --- System aktualisieren ---
dnf update -y

# --- Docker installieren ---
dnf install -y docker git
systemctl enable docker
systemctl start docker

# --- ec2-user zu docker-Gruppe hinzufügen ---
usermod -aG docker ec2-user

# --- Docker Compose Plugin installieren (für Amazon Linux 2023) ---
#download current version of docker compose plugin
sudo curl -LS https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# Fix permissions after download
sudo chmod +x /usr/local/bin/docker-compose

# --- Versionen prüfen ---
docker --version
docker-compose version
echo "... docker installed"
