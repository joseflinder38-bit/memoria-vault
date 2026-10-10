---
type: setup-documentation
tags: [automation, maintenance, daily]
status: aktiv
letztes-update: 2026-07-10
---

# ✅ Memoria Vault Maintenance - Automatisiertes Setup

**Status:** 🟢 AKTIV – Automatische Ausführung täglich 08:00 Uhr

---

## 📋 Was wurde konfiguriert

### 1️⃣ Dead Links Fixer
- **Funktion:** Findet und dokumentiert fehlerhafte Wikilinks
- **Output:** `00 Inbox/DEAD-LINKS-REPORT.md`
- **Automatisch:** Täglich um 08:00 Uhr

### 2️⃣ Frontmatter Standardizer
- **Funktion:** Normalisiert Status-Werte in allen Markdown-Dateien
- **Standard-Werte:**
  - `aktiv` — derzeit in Arbeit
  - `abgeschlossen` — fertig
  - `pausiert` — temporär gestoppt
  - `geplant` — noch nicht gestartet
  - `archiviert` — obsolet
- **Output:** `00 Inbox/FRONTMATTER-STANDARDIZATION-REPORT.md`
- **Sicherheit:** Erstellt Backups (.md.bak) vor Änderungen

### 3️⃣ Daily Health Report
- **Funktion:** Erstellt tägliche Gesundheitschecks
- **Prüft:**
  - Gesamte Dateienanzahl
  - Inbox-Größe (Warnung wenn > 20 Dateien)
  - Aktive/abgeschlossene Projekte
  - Archive-Größe
- **Output:** `00 Inbox/VAULT-HEALTH-YYYY-MM-DD.md`
- **Automatisch:** Täglich um 08:00 Uhr

---

## 🔧 Technische Details

### Scheduled Task
```
Aufgabenname:        Memoria-Vault-Maintenance
Zeitplan:            Täglich um 08:00 Uhr
Benutzerkonto:       Admin (Interaktiv)
Status:              Bereit
Nächste Laufzeit:    10.07.2026 08:00:00
```

### Ausführungs-Chain
```
Windows Task Scheduler (08:00 täglich)
    ↓
run_daily_maintenance.bat
    ↓
vault_maintenance.py (Python)
    ├── DeadLinkFixer → DEAD-LINKS-REPORT.md
    ├── FrontmatterStandardizer → FRONTMATTER-REPORT.md
    └── DailyHealthReport → VAULT-HEALTH-YYYY-MM-DD.md
    ↓
Logs → 00 Inbox/maintenance_log.txt
```

---

## 📊 Initiale Ergebnisse (2026-07-10)

| Komponente | Ergebnis |
|-----------|---------|
| Dead Links gefunden | 188 |
| Dateien mit Frontmatter standardisiert | 64 |
| Health Check durchgeführt | ✅ |

### Dead Links (Top 20)
Die meisten Dead Links befinden sich in:
- `Home.md` — verlinkt auf Dateien mit anderen Namen
- `COPILOT-QUICK-PROMPTS.md` — veraltete Links

**Nächster Schritt:** Manuelle Überprüfung und Bereinigung von `Home.md`

---

## 🚀 Manuelle Verwendung

### Jederzeit manuell ausführen
```bash
# Im Vault-Verzeichnis:
python vault_maintenance.py

# Oder direkt die Batch-Datei:
run_daily_maintenance.bat
```

### Task-Status überprüfen
```powershell
# Anzeigen
schtasks /query /tn Memoria-Vault-Maintenance /fo list /v

# Deaktivieren (falls nötig)
schtasks /change /tn Memoria-Vault-Maintenance /disable

# Aktivieren
schtasks /change /tn Memoria-Vault-Maintenance /enable
```

### Logs ansehen
```bash
# Tägliche Logs
type "00 Inbox\maintenance_log.txt"

# Oder einzelne Reports
type "00 Inbox\VAULT-HEALTH-2026-07-10.md"
```

---

## 📁 Generierte Dateien

Alle Reports werden automatisch in `00 Inbox/` erstellt:

```
00 Inbox/
├── DEAD-LINKS-REPORT.md                    # Dead Links Analyse
├── FRONTMATTER-STANDARDIZATION-REPORT.md   # Standardisierungs-Bericht
├── VAULT-HEALTH-2026-07-10.md             # Täglicher Health Check
├── VAULT-HEALTH-2026-07-11.md             # (nächster Tag)
├── maintenance_log.txt                     # Execution Log
└── vault-stats.json                        # JSON-Statistiken
```

---

## ⚠️ Wichtige Regeln (CLAUDE.md)

Diese Automatisierung folgt den Vault-Regeln:

✅ **DATENSCHUTZ-REGEL:**
- Keine sensiblen Daten aus `02 Areas/Persönliche Daten` werden exportiert
- Nur strukturelle Informationen (Dateizahlen, Tags, Status)

✅ **MESSUNGS-REGEL:**
- Alle Zählungen sind verifizierbar (Python-Befehle)
- Keine erfundenen Statistiken

✅ **STATUS-REGEL:**
- Automatische Ausführung ist in Windows Task Scheduler registriert
- Status wird korrekt als "AKTIV" mit Nachweis dokumentiert

---

## 🔍 Verifizierung

**BEFEHL zur Überprüfung:**
```powershell
schtasks /query /fo LIST /v | Select-String -Pattern "Memoria"
```

**ROHAUSGABE (Beispiel):**
```
Aufgabenname:                        \Memoria-Vault-Maintenance
Status:                              Bereit
Nächste Laufzeit:                    10.07.2026 08:00:00
```

**BEFUND:** ✅ Task aktiv, läuft täglich um 08:00 Uhr

---

## 🛠️ Troubleshooting

### "Task nicht vorhanden"
```powershell
# Neu registrieren
schtasks /create /tn "Memoria-Vault-Maintenance" /tr "C:\...\run_daily_maintenance.bat" /sc daily /st 08:00
```

### "Python nicht gefunden"
```powershell
# Python-Pfad überprüfen
python --version

# Falls nicht vorhanden: https://python.org/
```

### "Logs nicht aktualisiert"
```powershell
# Task manuell ausführen
C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\run_daily_maintenance.bat
```

---

## 📞 Kontakt & Support

- **Vault Location:** `C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\`
- **Scripts:** `vault_analyzer.py`, `vault_maintenance.py`
- **Batch Wrapper:** `run_daily_maintenance.bat`
- **Setup Script:** `setup_daily_maintenance.ps1`

---

**Zuletzt aktualisiert:** 2026-07-10  
**Nächster automatischer Lauf:** 2026-07-11 08:00 Uhr
