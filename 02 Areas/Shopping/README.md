# 🛒 Shopping & Preisvergleiche

Zentrale Verwaltung für Preisrecherchen und Kaufentscheidungen.

---

## 📊 Aktive Preisvergleiche

### 🎧 Kopfhörer-Preisvergleich (TÄGLICH AKTUALISIERT)

**Projekt:** [[01 Projects/Kopfhörer-Recherche/Kopfhörer-Vergleich_2026]]

**Automatische Updates:** ✅ **Täglich 14:00 Uhr** (Agent: Max)

**Verfolgte Modelle:**
1. Soundcore Liberty 4 NC (Budget)
2. CMF Buds Pro 2 (Ultra-Budget)
3. JBL Tune Beam 2 (Mid-Range)
4. Sony WF-1000XM6 (Premium)
5. Samsung Galaxy Buds 3 Pro (Android)

**Speicherort tägliche Reports:**
```
02 Areas/Shopping/Kopfhörer-Preise_[DATUM].md
```

---

## 🤖 Agenten in diesem Bereich

| Agent | Aufgabe | Rhythmus | Status |
|-------|---------|----------|--------|
| **Max** | Tägliche Kopfhörer-Preisrecherche | ✅ Täglich 14:00 Uhr | AUTOMATISIERT |
| **Karl** | Wöchentliche Preis-Trends | ⏳ Sonntag 10:00 Uhr | GEPLANT |

---

## 📁 Dateien in diesem Ordner

- `README.md` – Diese Datei
- `Kopfhörer-Preise_[DATUM].md` – Tägliche Updates (automatisch erstellt)
- `Kopfhörer-Preise_INDEX.md` – Übersicht aller Reports

---

## 🔄 Automatisierung Details

### Max – Tägliche Kopfhörer-Recherche

**Windows Task Scheduler:**
```
Task Name: Max - Kopfhörer-Preisrecherche täglich
Zeitplan: Täglich 14:00 Uhr
Skript: max-kopfhoerer-daily.ps1
Status: ⏳ EINZURICHTEN
```

**Aufgabe:**
1. Amazon.de & Amazon.eu abfragen für 5 Kopfhörer-Modelle
2. Aktuelle Preise extrahieren
3. Mit gestern vergleichen (Trend: ↑/↓/=)
4. Als `.md` speichern: `02 Areas/Shopping/Kopfhörer-Preise_[DATUM].md`
5. Rabatt-Highlights dokumentieren

**Output-Format:**
```markdown
# Kopfhörer-Preise [DATUM]

| Modell | Aktuell EUR | Gestern | Trend | Link | Info |
|--------|-------------|---------|-------|------|------|
| Soundcore Liberty 4 NC | €59,99 | €59,99 | = | [Link] | Verfügbar |
| CMF Buds Pro 2 | €39,99 | €42,99 | ↓ | [Link] | -3€ Rabatt |
| ...
```

---

## 📅 Preis-Tracking Archiv

**Verfügbare Reports:**
- 2026-07-06: Erste Recherche (manuell von Max & Vera)
- 2026-07-07: (wird um 14:00 Uhr erstellt)
- [weitere folgen täglich]

---

## 🎯 Nächste Schritte

- [ ] PowerShell-Script für Max erstellen (`max-kopfhoerer-daily.ps1`)
- [ ] Windows Task Scheduler Aufgabe einrichten
- [ ] Erste automatische Ausführung um 14:00 Uhr testen
- [ ] Karl für wöchentliche Trend-Analyse aktivieren (optional)

---

**Verwaltung:** Claude Code  
**Letztes Update:** 2026-07-06  
**Status:** ✅ STRUKTUR BEREIT – Automatisierung in Einrichtung
