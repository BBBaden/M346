# Verwende das Node.js-Image als Basis
FROM node:alpine3.20

# Erstelle einen neuen Benutzer und eine Benutzergruppe, z.B. "nodeuser"
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Exponiere den Port, auf dem die App läuft
EXPOSE 3000

# Startkommando für die Node.js-App
ENTRYPOINT ["npm", "start"]
CMD ["--default-arg"]

# Arbeitsverzeichnis in Docker erstellen
WORKDIR /app

# Kopiere die package.json und package-lock.json
COPY package*.json ./

# Installiere die Abhängigkeiten
RUN npm install

# Kopiere den Rest der Anwendung
COPY . .

# Wechsel zum neuen Benutzer
USER appuser
