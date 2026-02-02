#!/bin/bash

# Funktion zum Löschen von Verzeichnissen
delete_directory() {
    if [ -d "$1" ]; then
        rm -rf "$1"
        echo "[OK] Ordner '$1' wurde gelöscht."
    else
        echo "[INFO] Ordner '$1' existiert nicht, überspringe."
    fi
}

# Funktion zum Löschen von Dateien
delete_file() {
    if [ -f "$1" ]; then
        rm "$1"
        echo "[OK] Datei '$1' wurde gelöscht."
    else
        echo "[INFO] Datei '$1' existiert nicht, überspringe."
    fi
}

# --- Hauptteil des Scripts ---

echo "Starte Bereinigungsprozess..."

# Aufruf der Funktionen mit deinen spezifischen Pfaden
delete_directory "M346"
delete_directory "working-directory"
delete_file "docker_status.log"

echo "Bereinigung abgeschlossen."
