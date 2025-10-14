#!/bin/bash
# ==========================================
# generate-prod-env.sh
# Erzeugt eine .env.prod mit öffentlicher IP
# ==========================================
echo "Create .env ..."
set -e  # Beende bei Fehlern

# --- Öffentliche IP holen ---
PUBLIC_IP=$(curl -s http://checkip.amazonaws.com)

if [[ -z "$PUBLIC_IP" ]]; then
  echo "Fehler: Konnte öffentliche IP nicht ermitteln."
  exit 1
fi

echo "Öffentliche IP: $PUBLIC_IP"

# --- .env.prod erzeugen ---
cat > .env.prod <<EOF
# Automatisch generierte Produktions-Umgebung
BACKEND_IP=${PUBLIC_IP}
EOF

echo ".env.prod erfolgreich erstellt:"
cat .env.prod

echo "... .env created"