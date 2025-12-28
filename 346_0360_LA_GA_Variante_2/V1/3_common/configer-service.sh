#!/bin/bash
# --- systemd-Service aus dem Repo verschieben ---
sudo mv m346-docker.service /etc/systemd/system/m346-docker.service

# --- systemd Service aktivieren und starten ---
sudo systemctl daemon-reload
sudo systemctl enable m346-docker.service
sudo systemctl start m346-docker.service

# --- Containerstatus prüfen und loggen ---
docker ps > /home/ec2-user/docker_status.log

echo "Deployment abgeschlossen. Container starten automatisch beim Boot."