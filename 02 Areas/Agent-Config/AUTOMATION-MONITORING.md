---
type: monitoring-dashboard
version: "1.0"
status: LIVE
letztes-update: 2026-07-19
---

# 📊 AUTOMATION MONITORING DASHBOARD

**Live-Status aller Automatisierungen (Cloud + Windows)**

---

## 🎯 TÄGLICHER AUTOMATION-FLOW

```
05:00 ┌─ Daily Note Creator (Cloud)
      │  └─ Neue Tagesnotiz in 06 Daily Notes/
      │
07:30 ├─ Otto Curator (Cloud)
      │  └─ Inbox sortieren, Freelance-Status
      │
08:00 ├─ Nina Scout (Cloud PRIMARY)
      │  └─ Job-Suche: 30km, alle 8 Portale
      │
08:00 ├─ Rainer Quick Check (Cloud)
      │  └─ Inbox-Anzahl, Broken Links, TODOs
      │
08:15 ├─ Nina Scout Backup (Windows fallback)
      │  └─ Nur wenn Cloud fehlgeschlagen
      │
18:00 ├─ Karl Market Watch (Windows)
      │  └─ Marktdaten aktualisieren
      │
20:00 ├─ Rainer Deep Scan (Cloud)
      │  └─ Tiefenscan + Health Score
      │
└─ Sonntag 19:00 ┌─ Weekly Review (Cloud)
                  └─ Wochenreport + Empfehlungen
```

---

## 📈 AUTOMATION STATUS CHECKS

**Führe täglich aus um 09:00 Uhr:**

### Check 1: Cloud Routines Status

```powershell
# Öffne: https://claude.ai/code/routines
# Check für jede Routine:
# ✅ ACTIVE
# ❌ ERROR
# ⏳ PENDING
```

### Check 2: Windows Tasks Status

```powershell
# PowerShell als Admin:
schtasks /query /fo LIST /v | grep -E "Nina|Karl|Rainer|Otto"

# Output sollte zeigen:
# - Status: Ready
# - Last Run Time: heute
# - Last Result: 0 (success)
```

### Check 3: Output Files Generated Today

```powershell
# Check Vault für heutige Reports:
ls 00 Inbox/VAULT-HEALTH-*.md          # Rainer Reports
ls 02 Areas/Jobsuche/Jobs_*.md         # Nina Reports
ls 02 Areas/Finanzen/Marktbeobachtung.md  # Karl Updates

# Alle sollten heute (2026-07-19) sein
```

---

## 🚨 FEHLERBEHANDLUNG

### Szenario 1: Cloud Routine Fehler

**Symptom:** Keine `Jobs_YYYY-MM-DD.md` um 08:30 Uhr

**Diagnose:**
```powershell
# 1. Check Cloud Routines Status
#    https://claude.ai/code/routines → View Execution Log

# 2. Prüfe Vault-Zugriff
#    Kann Claude auf 02 Areas/Jobsuche schreiben?

# 3. Check Fehler-Log
#    "Datei gesperrt", "Permission denied", etc.
```

**Fix:**
```powershell
# Windows-Backup sollte um 08:15 automatisch starten
# Wenn das auch nicht läuft:

# Option A: Manuell starten
Invoke-Item "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\Scripts\nina-scout-backup.ps1"

# Option B: Cloud Routine neu starten
# https://claude.ai/code/routines → Edit Nina Scout → Save & Test
```

### Szenario 2: Windows Task schlägt fehl

**Symptom:** Event Viewer zeigt Error in Task Scheduler

**Diagnose:**
```powershell
# Event Viewer öffnen:
eventvwr.msc

# Navigiere zu: Windows Logs > System
# Suche nach Tasks mit Status "Error"
# Kopiere Fehlermeldung
```

**Common Fixes:**

| Fehler | Lösung |
|--------|--------|
| `ERROR_SHARING_VIOLATION` | Obsidian sperrt Datei → Warte 5 Min + Retry |
| `Access Denied` | PowerShell-Fenster als Admin öffnen |
| `Python not found` | `pip install jobspy` erneut ausführen |
| `File not found` | Script-Pfad überprüfen: `C:\...\Scripts\name.ps1` |

---

## 📊 AUTOMATION HEALTH SCORE

**Berechnet täglich um 21:00 Uhr:**

```
Health Score = (Success-Rate %) × 100

Success-Rate = Successful Runs / Total Runs (letzte 7 Tage)

Beispiel:
- Nina: 7/7 Runs erfolgreich = 100%
- Karl: 6/7 Runs (1 Fehler) = 85%
- Rainer: 14/14 = 100%
- Otto: 7/7 = 100%

GESAMT: (100 + 85 + 100 + 100) / 4 = 96% ✅
```

### Score-Interpretation

```
90-100%  ✅ EXZELLENT – Alles läuft perfekt
75-89%   ⚠️ GUT – 1-2 Minor Issues
50-74%   🔴 PROBLEMATISCH – Mehrere Fehler
<50%     ❌ KRITISCH – Systemausfall
```

---

## 🔄 WÖCHENTLICHE WARTUNG (Sonntag 19:00)

**Automatischer Wochenreport von Rainer:**

```markdown
# 📊 Wochenreport – 2026-07-14 bis 2026-07-20

## Automation Health
- 🔥 Automation Score: 96%
- ✅ Nina Scout: 7/7 erfolgreich
- ✅ Karl Market Watch: 6/7 (1 Fehler 16.07)
- ✅ Rainer Maintenance: 14/14 erfolgreich
- ✅ Otto Curator: 7/7 erfolgreich

## Probleme diese Woche
- ⚠️ Karl: ERROR_SHARING_VIOLATION (16.07) – FIXED

## Recommendations
- 1. Beobachtungsliste für Karl erweitern (0 Aktien)
- 2. Freelance-Kunden aktualisieren (Otto tracking)
- 3. Archive alte Dateien (Rainer empfiehlt 5 Dateien)

## Nächste Woche
- Ziel: 98%+ Automation Score
- Aktion: Beobachtungsliste mit 5 Aktien befüllen
```

---

## 🛠️ NOTFALL-RESET (Wenn alles bricht)

**Verwendet nur im äußersten Fall:**

```powershell
# SCHRITT 1: Alte Tasks löschen
schtasks /delete /tn "Nina Scout*" /f
schtasks /delete /tn "Karl Market*" /f
schtasks /delete /tn "Rainer*" /f
schtasks /delete /tn "Otto*" /f

# SCHRITT 2: Warte 5 Minuten

# SCHRITT 3: Cloud Routines neu starten
# https://claude.ai/code/routines → Delete all → Create new

# SCHRITT 4: Windows Tasks neu installieren
# Führe Installation-Script aus (siehe Phase 2)

# SCHRITT 5: Test
# Warte auf nächste geplante Ausführung
# Prüfe 00 Inbox/ auf neue Reports
```

---

## 📋 TÄGLICHE CHECKS (Selbst-Checkliste)

### Jeden Morgen (09:00 Uhr)

```
☐ Öffne: 00 Inbox/VAULT-HEALTH-QUICK_YYYY-MM-DD.md
  └─ Inbox: < 10 Dateien? ✅
  └─ Broken Links: 0? ✅
  └─ TODOs: < 5? ✅

☐ Öffne: 02 Areas/Jobsuche/Jobs_YYYY-MM-DD.md
  └─ Neue Jobs gefunden? (>5?)
  └─ 🔥-Matches vorhanden?

☐ Check: https://claude.ai/code/routines
  └─ Alle 4 Routines "ACTIVE"?
```

### Jeden Abend (20:30 Uhr)

```
☐ Öffne: 00 Inbox/VAULT-HEALTH-DEEP_YYYY-MM-DD.md
  └─ Health Score: >85%?
  └─ Empfehlungen verstanden?

☐ Check: 02 Areas/Finanzen/Marktbeobachtung.md
  └─ Karl aktualisiert heute?
```

---

## 💾 BACKUP-STRATEGIE

**Tägliches Backup der Automation-Logs:**

```powershell
# Automatisch täglich um 23:00 Uhr
# Kopiere alle Logs nach:
# → 04 Archive/AUTOMATION-LOGS/

# Aufbewahrt für 30 Tage
# Ältere Logs werden gelöscht

$LogPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\00 Inbox\*LOG*.txt"
$BackupPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\04 Archive\AUTOMATION-LOGS"

Copy-Item -Path $LogPath -Destination $BackupPath -Force
```

---

## 🚀 QUICK REFERENCE

### If Nina doesn't report jobs
```
1. Check: 02 Areas/Jobsuche/Jobs_YYYY-MM-DD.md exists?
2. If not: schtasks /run /tn "Nina Scout - Backup"
3. Wait 5 minutes
4. Reload Vault
```

### If Karl fails
```
1. Check: 02 Areas/Finanzen/Marktbeobachtung.md last update
2. If >24h old: schtasks /run /tn "Karl Market Watch - Fixed"
3. Wait 5 minutes
4. Check for ERROR_SHARING_VIOLATION
```

### If Inbox overflows
```
1. Check: 00 Inbox/ count
2. If >20 files: Manually trigger Otto
3. Or wait for 07:30 automatic run
```

### If Health Score < 75%
```
1. Check: https://claude.ai/code/routines (execution logs)
2. Check: Event Viewer (Windows errors)
3. If persistent: Run NOTFALL-RESET
```

---

## 📞 SUPPORT CONTACTS

**When something breaks:**

1. **Cloud Routine Issue** → https://claude.ai/code/routines (view logs)
2. **Windows Task Issue** → Event Viewer (eventvwr.msc)
3. **Python Error** → Command Prompt: `pip install jobspy --upgrade`
4. **File Lock Error** → Obsidian schließen & neustarten
5. **General Help** → Diese Datei + AUTOMATION-STATUS.md

---

**Status:** ✅ MONITORING ACTIVE  
**Letzte Überprüfung:** 2026-07-19 10:00 Uhr  
**Nächste Überprüfung:** Täglich 09:00 Uhr automatisch
