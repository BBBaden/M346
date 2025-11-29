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
mkdir -p /usr/local/lib/docker/cli-plugins
#download current version of docker compose plugin
sudo curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m)" -o /usr/libexec/docker/cli-plugins/docker-compose
#make plugin executable
sudo chmod +x /usr/libexec/docker/cli-plugins/docker-compose

# --- Versionen prüfen ---
docker --version
docker-compose version
echo "... docker installed"
