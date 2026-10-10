---
type: implementation-guide
version: "3.0"
status: READY TO EXECUTE
created: 2026-07-19
estimated-time: "60 Minuten"
---

# 🚀 AUTOMATION SETUP – ULTRA CONFIGURATION (OPTION C)

**Vollständiges System: Cloud Routines + Windows Tasks + Python Backup**

---

## ⏱️ ZEITPLAN

```
07:30 – 08:00 ┌─ Phase 1: Cloud Routines Konfiguration
               │  └─ ~20 Minuten
               │
08:00 – 08:45 ├─ Phase 2: Windows Tasks Installation
               │  └─ ~30 Minuten
               │
08:45 – 09:00 ├─ Phase 3: Testing & Verification
               │  └─ ~15 Minuten
               │
TOTAL:        └─ ~60 Minuten
```

---

## 📋 PHASE 1: CLOUD ROUTINES (20 Min)

### SCHRITT 1: Vorbereitung

```
☐ Öffne Browser
☐ Gehe zu: https://claude.ai/code/routines
☐ Login mit: joseflinder38@gmail.com
☐ Klicke: "+ Create Routine"
```

### SCHRITT 2: Routine 1 – Nina Scout

**Name:** `Nina Scout - Daily Job Search`

**Schedule:** `0 8 * * *` (08:00 täglich, Berlin Zeit)

**Prompt (kopiere exakt):**

```
Du bist Nina Scout – täglich Job-Finder für Josef.

SEARCH CONFIGURATION:
- Positionen: Kaufmann Büromanagement, Fachkraft Arbeitssicherheit (ASiG), Gefahrstoffmanager
- Region: 30 km Radius um Heistenbach, Rheinland-Pfalz
- Sources: Indeed.de, LinkedIn, Glassdoor, StepStone, Xing, ArbeitsAgentur.de, Jooble, lokale Jobbörsen
- Filter: Nur Treffer >60% Match
- Zeitraum: Neue Angebote letzte 24h

OUTPUT FORMAT:
Speichere in: 02 Areas/Jobsuche/Jobs_YYYY-MM-DD.md

Verwende diese Tabelle:
| Match | Firma | Position | Ort | Gehalt | Deadline | Link |
|-------|-------|----------|-----|--------|----------|------|
| 🔥 90% | [Firma] | [Position] | [Ort] | [Gehalt] | [Deadline] | [Link] |

RATING:
- 🔥 wenn >80% Match & ASiG/Gefahrstoff-relevant
- 👍 wenn 60-80% Match
- 🤔 wenn <60% Match

Finde mindestens 5 Jobs pro Tag.
```

**Action:** Speichern & Test

---

### SCHRITT 3: Routine 2 – Rainer Quick Check

**Name:** `Rainer - Vault Quick Check`

**Schedule:** `0 8 * * *` (parallel zu Nina)

**Prompt:**

```
Du bist Rainer – Vault-Wächter.

DAILY QUICK CHECK (Dauer: 2 Min):
1. Zähle Dateien in 00 Inbox/ (warn wenn >10)
2. Suche broken [[wikilinks]] in Vault
3. Finde doppelte Dateinamen
4. Zähle [TODO] und [FIXME] Tags
5. Prüfe Frontmatter in: ARBEITSSTAND.md, Profil.md

OUTPUT:
Speichere in: 00 Inbox/VAULT-HEALTH-QUICK_YYYY-MM-DD.md

Format:
# ✅ Vault Quick Check – YYYY-MM-DD HH:MM

## Status
- 📂 Inbox: X Dateien (⚠️ warn if >10)
- 🔗 Broken Links: X gefunden
- 📋 Duplikate: X gefunden
- ✍️ TODOs: X offene
- ✅ Health Score: X%
```

**Action:** Speichern & Test

---

### SCHRITT 4: Routine 3 – Rainer Deep Scan

**Name:** `Rainer - Vault Deep Scan`

**Schedule:** `0 20 * * *` (20:00 täglich)

**Prompt:**

```
Du bist Rainer – Tiefenscan-Expert.

DEEP SCAN (Dauer: 5 Min):
1. Finde Dateien >60 Tage ohne Änderung
2. Identifiziere break links
3. Prüfe alle Frontmatter auf Fehler
4. Berechne Vault-Health Score (%)
5. Empfehle konkrete Aktionen

OUTPUT:
Speichere in: 00 Inbox/VAULT-HEALTH-DEEP_YYYY-MM-DD.md

Format:
# 📊 Vault Deep Scan – YYYY-MM-DD

## Vault Metrics
- 📁 Total Files: X
- 📂 Total Size: X MB
- 📝 Files >60 days: X (archivieren?)

## Issues Found
- 🔗 Broken Links: X
- ❌ Frontmatter Errors: X
- 📋 Missing fields: X

## Recommendations
1. Archiviere diese N Dateien
2. Repariere diese M Links
3. [Konkrete Aktion]

## Health Score: XX%
```

**Action:** Speichern & Test

---

### SCHRITT 5: Routine 4 – Otto Curator

**Name:** `Otto - Inbox Curator`

**Schedule:** `30 7 * * *` (07:30 täglich, VOR Nina!)

**Prompt:**

```
Du bist Otto – Inbox-Organizer & Freelance-Tracker.

DAILY CURATION (Dauer: 2 Min):
1. Scan 00 Inbox/ für neue Dateien
2. Auto-klassifiziere & verschiebe nach:
   - "*Bewerbung*" → 01 Projects/Bewerbungen/
   - "*Freelance*" → 01 Projects/Freelance Gefahrstoffe Aufbau/
   - "*Kunde*" → 01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/
   - "*Finanzen*" → 02 Areas/Finanzen/
   - "*Rechnung*" → 02 Areas/Finanzen/
3. Track Freelance-Kunden Status:
   - Anzahl aktiver Kunden
   - Wer wartet auf Rückmeldung?
   - Nächste Kontakt-Termine?

OUTPUT:
Update in: 02 Areas/Persönliche Daten/ARBEITSSTAND.md

Schreibe in die Inbox-Section:
## 📂 Inbox Status (Otto Report – YYYY-MM-DD)
- ✅ Sorted: X files moved today
- 📊 Inbox Files: X (↓ from yesterday if improved)
- 💼 Active Customers: X
- ⏳ Awaiting Response: X
- 📅 Next Contact: [Dates]
```

**Action:** Speichern & Test

---

### ✅ Phase 1 Complete

Alle 4 Cloud Routines sollten jetzt im Dashboard sichtbar sein:
- https://claude.ai/code/routines

---

## 📋 PHASE 2: WINDOWS TASKS (30 Min)

### Voraussetzungen

```powershell
# PowerShell als ADMIN öffnen
# (Nicht PowerShell ISE, nur PowerShell)

# Prüfe Python Installation
python --version

# Output sollte: Python 3.9 oder höher zeigen
# Wenn nicht: https://www.python.org/downloads/

# Installiere JobSpy
pip install jobspy

# Verify
python -c "import jobspy; print('✓ Ready')"
```

### SCHRITT 1: Scripts Verzeichnis erstellen

```powershell
$ScriptsDir = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\Scripts"
New-Item -ItemType Directory -Path $ScriptsDir -Force
Write-Host "✅ Scripts folder created: $ScriptsDir"
```

### SCHRITT 2: Automation Scripts kopieren

**Datei 1:** `nina-scout-backup.ps1`  
(Kopiere vollständigen Code aus `WINDOWS-TASKS-CONFIG.md`)

```powershell
# Speichere in: $ScriptsDir\nina-scout-backup.ps1
```

**Datei 2:** `karl-market-watch-fixed.ps1`  
(Kopiere vollständigen Code aus `WINDOWS-TASKS-CONFIG.md`)

```powershell
# Speichere in: $ScriptsDir\karl-market-watch-fixed.ps1
```

### SCHRITT 3: Windows Tasks registrieren

**Führe dieses Skript als Admin aus:**

```powershell
# =====================================================
# MASS TASK INSTALLATION
# =====================================================

$ScriptsDir = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\Scripts"

# ─────────────────────────────────────────────────
# TASK 1: Nina Scout Backup (08:15 täglich)
# ─────────────────────────────────────────────────
Write-Host "📦 Installing Task 1: Nina Scout Backup..."

$TaskName1 = "Nina Scout - Backup"
$ScriptPath1 = "$ScriptsDir\nina-scout-backup.ps1"
$Time1 = "08:15"

$Action1 = New-ScheduledTaskAction -Execute "powershell.exe" `
  -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath1`""

$Trigger1 = New-ScheduledTaskTrigger -Daily -At $Time1

$Settings1 = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable `
  -StartWhenAvailable -MultipleInstances Parallel

Register-ScheduledTask -TaskName $TaskName1 `
  -Action $Action1 `
  -Trigger $Trigger1 `
  -Settings $Settings1 `
  -Description "Backup job search if Cloud Routine fails" `
  -Force

Write-Host "✅ Task 1 installed"

# ─────────────────────────────────────────────────
# TASK 2: Karl Market Watch (18:00 täglich)
# ─────────────────────────────────────────────────
Write-Host "📦 Installing Task 2: Karl Market Watch..."

$TaskName2 = "Karl Market Watch - Fixed"
$ScriptPath2 = "$ScriptsDir\karl-market-watch-fixed.ps1"
$Time2 = "18:00"

$Action2 = New-ScheduledTaskAction -Execute "powershell.exe" `
  -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath2`""

$Trigger2 = New-ScheduledTaskTrigger -Daily -At $Time2

$Settings2 = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable `
  -StartWhenAvailable -RestartCount 3 -RestartInterval (New-TimeSpan -Hours 1)

Register-ScheduledTask -TaskName $TaskName2 `
  -Action $Action2 `
  -Trigger $Trigger2 `
  -Settings $Settings2 `
  -Description "Market data (fixed with retry-logic)" `
  -Force

Write-Host "✅ Task 2 installed"

# ─────────────────────────────────────────────────
# VERIFY
# ─────────────────────────────────────────────────
Write-Host ""
Write-Host "✅ ALL TASKS INSTALLED!"
Write-Host ""
Write-Host "Verify with:"
Write-Host "schtasks /query /fo LIST /v | findstr /i 'Nina\|Karl'"
Write-Host ""
Write-Host "Next: Phase 3 – Testing & Verification"
```

**Action:** Kopiere + Führe aus als Admin

### ✅ Phase 2 Complete

Überprüfe Installation:

```powershell
schtasks /query /fo LIST /v | findstr /i "Nina\|Karl"

# Output sollte zeigen:
# TaskName: Nina Scout - Backup
#     Status: Ready
#     Scheduled Task State: Enabled
#
# TaskName: Karl Market Watch - Fixed
#     Status: Ready
#     Scheduled Task State: Enabled
```

---

## ✅ PHASE 3: TESTING & VERIFICATION (15 Min)

### TEST 1: Cloud Routine – Nina Scout

```
☐ Gehe zu: https://claude.ai/code/routines
☐ Finde: "Nina Scout - Daily Job Search"
☐ Klicke: "Test Run"
☐ Warte: 2-3 Minuten
☐ Check: 02 Areas/Jobsuche/Jobs_TEST_YYYY-MM-DD.md
   └─ Sollte Test-Jobs enthalten
```

**Erwartetes Ergebnis:**
```
Jobs_TEST_2026-07-19.md (oder ähnlich)
mit einer Tabelle von mindestens 5 Jobs
```

### TEST 2: Cloud Routine – Rainer Quick

```
☐ Gehe zu: https://claude.ai/code/routines
☐ Finde: "Rainer - Vault Quick Check"
☐ Klicke: "Test Run"
☐ Warte: 1-2 Minuten
☐ Check: 00 Inbox/VAULT-HEALTH-QUICK_*.md
   └─ Sollte Status zeigen
```

### TEST 3: Windows Task – Nina Scout Backup

```powershell
# PowerShell als Admin:
schtasks /run /tn "Nina Scout - Backup"

# Warte 5 Minuten
# Check: 02 Areas/Jobsuche/Jobs_YYYY-MM-DD.md
```

### TEST 4: Windows Task – Karl Market Watch

```powershell
# PowerShell als Admin:
schtasks /run /tn "Karl Market Watch - Fixed"

# Warte 2 Minuten
# Check: 02 Areas/Finanzen/Marktbeobachtung.md (oder .txt log)
```

### ✅ ALLE TESTS ERFOLGREICH?

Wenn ja → **AUTOMATION AKTIV!** 🎉

Wenn nein → Konsultiere `AUTOMATION-MONITORING.md` (Fehlerbehandlung)

---

## 🎯 FINAL SETUP CHECKLIST

```
CLOUD ROUTINES:
☐ Nina Scout konfiguriert & Test erfolgreich
☐ Rainer Quick konfiguriert & aktiv
☐ Rainer Deep konfiguriert & aktiv
☐ Otto Curator konfiguriert & aktiv
☐ Alle 4 Routines zeigen Status "Active" auf Dashboard

WINDOWS TASKS:
☐ Nina Scout Backup Task installiert & ready
☐ Karl Market Watch Task installiert & ready
☐ Event Viewer zeigt "Task Started Successfully"

MONITORING:
☐ 00 Inbox/ hat heute VAULT-HEALTH-QUICK_*.md
☐ 00 Inbox/ hat heute VAULT-HEALTH-DEEP_*.md (20:00)
☐ 02 Areas/Jobsuche/ hat heute Jobs_*.md
☐ ARBEITSSTAND.md hat Otto Report

FINAL STATUS:
☐ Automation Score: >90%
☐ Kein Fehler in Event Viewer
☐ Alle Logs sauber
```

---

## 📊 EXPECTED DAILY TIMELINE

```
05:00 ✅ Daily Note auto-created
07:30 ✅ Otto: Inbox organized
08:00 ✅ Nina: Jobs found & stored
08:00 ✅ Rainer Quick: Health check done
08:15 ⏳ Backup starts (wenn Cloud failed)
18:00 ✅ Karl: Market data updated
20:00 ✅ Rainer Deep: Full scan done
21:00 ✅ Health score calculated
```

---

## 🚀 NEXT STEPS (Nach Setup)

1. **Morgen früh (09:00)**
   - Check: https://claude.ai/code/routines (alle "Active"?)
   - Check: 00 Inbox/ (neue Reports?)
   - Check: 02 Areas/Jobsuche/ (neue Jobs?)

2. **Diese Woche**
   - Beverage eine 🔥-Bewerbung (Nina findet sie)
   - Überwache Health Score (sollte 90%+ sein)

3. **Nächste Woche**
   - Befülle Karls Beobachtungsliste (5 Aktien)
   - Überprüfe Freelance-Kunden Status (Otto tracked das)

---

## 💡 QUICK REFERENCE (Wenn etwas schiefgeht)

| Symptom | Fix |
|---------|-----|
| Keine Jobs um 08:30 | `schtasks /run /tn "Nina Scout - Backup"` |
| Inbox zu voll | Warte auf 07:30 Uhr (Otto läuft) |
| Health Score <80% | Check: https://claude.ai/code/routines (errors) |
| Karl meldet keine Daten | `schtasks /run /tn "Karl Market Watch - Fixed"` |

---

## 📞 HILFE

Wenn was nicht klappt:
1. Öffne: `07 Agents/AUTOMATION-MONITORING.md`
2. Suche dein Problem unter "Fehlerbehandlung"
3. Folge den Steps

---

**Status:** ✅ READY TO IMPLEMENT  
**Estimated Setup Time:** 60 Minuten  
**Expected Result:** 95%+ Automation Score  
**Target Date:** 2026-07-19  

🚀 **LASS UNS GEHEN!**
