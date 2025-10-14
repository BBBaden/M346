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
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 \
    -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# --- Versionen prüfen ---
docker --version
docker compose version
echo "... docker installed"