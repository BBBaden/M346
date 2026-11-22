# M346

Download-Portal: <https://bbbaden.github.io/M346/>

## Versions-Anzeigen (z. B. für Moodle)

Beim Veröffentlichen erzeugt die Page je eine Anzeige für das Korrektur-Tool und für die
draw.io-Bibliothek:

| Anzeige | Badge (Bild) | Karte mit Link (iframe) |
|---|---|---|
| Korrektur-Tool | <https://bbbaden.github.io/M346/version-korrekturtool.svg> | <https://bbbaden.github.io/M346/version-korrekturtool.html> |
| draw.io-Bibliothek | <https://bbbaden.github.io/M346/version-bibliothek.svg> | <https://bbbaden.github.io/M346/version-bibliothek.html> |

Beide Werte zusammen für eigene Skripte: <https://bbbaden.github.io/M346/version.json>

Einbinden in Moodle (Textfeld, HTML-Ansicht des Editors):

```html
<img src="https://bbbaden.github.io/M346/version-korrekturtool.svg" alt="Aktuelle Version Korrektur-Tool">
<img src="https://bbbaden.github.io/M346/version-bibliothek.svg" alt="Aktuelle Version draw.io-Bibliothek">
```

oder, falls iframes erlaubt sind:

```html
<iframe src="https://bbbaden.github.io/M346/version-bibliothek.html" width="320" height="110" style="border:0" title="M346 draw.io-Bibliothek"></iframe>
```

Die Werte stammen aus `files.json` (vom Sync-Workflow gesetzt), erzeugt werden die Dateien
von `.github/scripts/version_dateien.py`. Nach einer Änderung sind sie nach spätestens
10 Minuten sichtbar (Cache der GitHub Page).
