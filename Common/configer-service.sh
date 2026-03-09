#!/bin/bash
# --- systemd-Service aus dem Repo verschieben ---
sudo mv la-docker.service /etc/systemd/system/la-docker.service

# --- systemd Service aktivieren und starten ---
sudo systemctl daemon-reload
sudo systemctl enable la-docker.service
sudo systemctl start la-docker.service

# --- Containerstatus prüfen und loggen ---
docker ps > /home/ec2-user/docker_status.log

echo "Deployment abgeschlossen. Container starten automatisch beim Boot."