#!/usr/bin/env python3
"""Erzeugt version.json sowie je ein Badge (SVG) und eine Karte (HTML) fuer
Korrektur-Tool und draw.io-Bibliothek fuer die GitHub Page.

Quelle: files.json (Felder korrekturtool, bibliothek, stand; vom Sync-Workflow gesetzt).
Aufruf: python3 version_dateien.py <files.json> <ausgabe-ordner> <page-url>

Moodle: version-<korrekturtool|bibliothek>.svg als Bild einbinden (siehe README), .html per iframe,
version.json fuer eigene Skripte (GitHub Pages sendet Access-Control-Allow-Origin: *).
"""
import html
import json
import sys
from pathlib import Path

cfg = json.load(open(sys.argv[1], encoding="utf-8"))
out = Path(sys.argv[2])
base = sys.argv[3].rstrip("/") + "/"

checker = (cfg.get("korrekturtool") or {}).get("version", "?")
bib = (cfg.get("bibliothek") or {}).get("version", "?")
bib_datei = (cfg.get("bibliothek") or {}).get("datei", f"M346_Bibliothek_V{bib}.zip")
stand = cfg.get("stand", "")

daten = {
    "korrekturtool": {"version": checker, "docker": f"fabricethutbbbaden/m346-checker:{checker}"},
    "bibliothek": {"version": bib, "datei": bib_datei, "url": base + bib_datei},
    "stand": stand,
    "seite": base,
}
(out / "version.json").write_text(json.dumps(daten, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


# --- je eine Anzeige fuer Korrektur-Tool und Bibliothek ---
def breite(text):  # Verdana 11px, grob geschaetzt
    return int(sum(7.2 if c.isupper() or c.isdigit() else 6.1 for c in text)) + 12


def badge(label, wert, farbe, titel):
    wl, wv = breite(label), breite(wert)
    return (
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{wl + wv}" height="20" role="img" aria-label="{html.escape(titel)}">'
        f"<title>{html.escape(titel)}</title>"
        f'<g font-family="Verdana,DejaVu Sans,sans-serif" font-size="11" fill="#fff" text-anchor="middle">'
        f'<rect width="{wl}" height="20" fill="#555"/><rect x="{wl}" width="{wv}" height="20" fill="{farbe}"/>'
        f'<text x="{wl / 2}" y="14">{html.escape(label)}</text>'
        f'<text x="{wl + wv / 2}" y="14" font-weight="bold">{html.escape(wert)}</text></g></svg>\n'
    )


def karte(titel, version, link_text, link_url):
    return f"""<!DOCTYPE html>
<html lang="de"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{html.escape(titel)}</title>
<style>
  body {{ margin: 0; font-family: -apple-system, "Segoe UI", Helvetica, Arial, sans-serif; font-size: 14px; color: #1a1a1a; background: #fff; }}
  .karte {{ border: 1px solid #ddd; border-radius: 6px; padding: 10px 14px; }}
  .titel {{ font-weight: 600; }}
  .v {{ font-size: 18px; font-weight: 700; margin: 2px 0; }}
  .stand {{ color: #666; font-size: 12px; }}
  a {{ color: #2a6fb0; }}
</style></head>
<body><div class="karte">
  <div class="titel">{html.escape(titel)}</div>
  <div class="v">{html.escape(version)}</div>
  <div><a href="{html.escape(link_url)}" target="_blank" rel="noopener">{html.escape(link_text)}</a></div>
  <div class="stand">{("Stand " + html.escape(stand)) if stand else ""}</div>
</div></body></html>
"""


zusatz = f" (Stand {stand})" if stand else ""
anzeigen = {
    "korrekturtool": (
        badge("Korrektur-Tool", checker, "#e30613", f"Korrektur-Tool Version {checker}{zusatz}"),
        karte("M346 Korrektur-Tool", f"Version {checker}", "Docker Hub",
              "https://hub.docker.com/r/fabricethutbbbaden/m346-checker/tags"),
    ),
    "bibliothek": (
        badge("draw.io-Bibliothek", f"V{bib}", "#2a6fb0", f"draw.io-Bibliothek Version {bib}{zusatz}"),
        karte("M346 draw.io-Bibliothek", f"Version {bib}", bib_datei, base + bib_datei),
    ),
}
for name, (svg, card) in anzeigen.items():
    (out / f"version-{name}.svg").write_text(svg, encoding="utf-8")
    (out / f"version-{name}.html").write_text(card, encoding="utf-8")
print(f"version.json, version-korrekturtool.svg/html, version-bibliothek.svg/html: "
      f"Korrektur-Tool {checker}, Bibliothek V{bib}, Stand {stand}")
