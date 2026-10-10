---
type: project-roadmap
version: "1.0"
status: GEPLANT
erstellt: 2026-07-28
ziel: "Vollständige Obsidian-Automation für Jobsuche + Freelance + Finanzen"
---

# 🚀 VAULT-OPTIMIZATION-ROADMAP

**Kompletter 3-Phasen-Plan zur Automation des Memoria-Vaults**

Basierend auf Best-Practices-Recherche (2026) und Audit-Ergebnissen.

---

## 📋 ÜBERSICHT

| Phase | Fokus | Zeitaufwand | Priorität | Status |
|-------|-------|------------|-----------|--------|
| **Phase 1** | Quick Wins (Templater + Dataview) | 2-4h | 🔴 KRITISCH | ⏳ GEPLANT |
| **Phase 2** | Automation Backbone (Git + Cloud Routines) | 4-6h | 🟠 HOCH | ⏳ GEPLANT |
| **Phase 3** | Advanced (n8n + Zettelkasten) | 6-8h | 🟡 MITTEL | ⏳ OPTIONAL |

**GESAMTAUFWAND:** 12-18h (verteilt über 3-4 Wochen)

---

# PHASE 1: QUICK WINS (Diese Woche)

**Ziel:** 80% Automation-Wert mit <4h Arbeit  
**Ergebnis:** Live-Dashboards + automatische Template-Anwendung + tägliche Notes

---

## 1.1 TEMPLATER FOLDER AUTOMATION AKTIVIEREN

### Voraussetzung:
- ✅ Obsidian installiert
- ✅ Templater Plugin installiert (falls nicht: Community Plugins → Templater)
- ✅ Templates in `05 Templates/` vorhanden

### Schritte:

**1. Obsidian Settings öffnen**
```
Settings (Zahnrad) → Community Plugins → Templater → Options
```

**2. Templater konfigurieren:**
```
☑️ Trigger Templater on new file creation: ENABLED
☑️ Enable system commands: ENABLED
```

**3. Folder Templates registrieren:**
```
Templater Settings → Folder Templates

Hinzufügen:
1. Folder Path: 01 Projects/Bewerbungen/Firmen
   Template File: 05 Templates/Bewerbung-Template.md

2. Folder Path: 01 Projects/Freelance Gefahrstoffe Aufbau/Kunden
   Template File: 05 Templates/Gefahrstoff-Kunde-Template.md

3. Folder Path: 06 Daily Notes
   Template File: 05 Templates/Daily-Note-Template.md
```

**4. Templates überprüfen:**
- Öffne `05 Templates/Bewerbung-Template.md`
- Überprüfe: Alle Felder wie `<% tp.file.title %>` sind vorhanden
- ✅ Sollte Frontmatter + Struktur enthalten

**5. TEST:** 
```
Erstelle neuen Note in 01 Projects/Bewerbungen/Firmen/Test-Firma.md
→ Sollte automatisch Bewerbung-Template laden
→ Felder sollten gefüllt sein (z.B. "Firma: Test-Firma")
```

### Dokumentation:
- [ ] `02 Areas/Agent-Config/AUTOMATION-STATUS.md` aktualisieren
  - Zeile hinzufügen: "Templater Folder Automation: ✅ AKTIV (28.07.2026)"

### Zeitaufwand: **20-30 min**

---

## 1.2 DAILY NOTES AUTOMATER PLUGIN INSTALLIEREN

### Voraussetzung:
- ✅ Obsidian installiert
- ✅ `06 Daily Notes/` Ordner vorhanden

### Schritte:

**1. Plugin installieren:**
```
Settings → Community Plugins → Browse → suche "Daily Notes"
→ Installiere "Daily Notes Automater" (von vjenni-smith)
```

**2. Plugin konfigurieren:**
```
Settings → Daily Notes Automater

Einstellungen:
- Output folder: 06 Daily Notes
- Date format: YYYY-MM-DD (z.B. 2026-07-28.md)
- Template file: 05 Templates/Daily-Note-Template.md
- ☑️ Create daily note on startup: ENABLED
- ☑️ Open daily note on startup: OPTIONAL
```

**3. TEST:**
```
Obsidian neustarten
→ Sollte neue Daily Note für heute erstellen
→ In 06 Daily Notes/ sollte 2026-07-28.md existieren
→ Sollte Templater-Fields gefüllt haben
```

**4. Hotkey setzen (optional aber empfohlen):**
```
Settings → Hotkeys → suche "Daily Notes Automater"
→ Setze Hotkey z.B. auf Ctrl+Shift+D
→ Schneller Zugriff auf heutige Note
```

### Dokumentation:
- [ ] `02 Areas/Agent-Config/AUTOMATION-STATUS.md` aktualisieren
  - "Daily Notes Automater: ✅ AKTIV (28.07.2026)"

### Zeitaufwand: **20-30 min**

---

## 1.3 DATAVIEW DASHBOARDS ERSTELLEN

### Voraussetzung:
- ✅ Dataview Plugin installiert
- ✅ Frontmatter-Felder in Bewerbungs- und Kunden-Notes (status, deadline, etc.)

### Dashboard 1: BEWERBUNGS-STATUS-ÜBERSICHT

**Datei:** `01 Projects/Bewerbungen/Status-Übersicht.md`

```markdown
---
type: dashboard
status: AKTIV
letztes-update: {{date:YYYY-MM-DD}}
---

# 📊 Bewerbungs-Status Übersicht

## 🔴 Aktive Bewerbungen (noch offen)

```dataview
TABLE firma, position, deadline, status
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status != "rejected" AND status != "completed"
SORT deadline ASC
```

## ✅ Abgeschlossene (Zusagen)

```dataview
TABLE firma, position, datum_zusage
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status = "completed"
SORT datum_zusage DESC
```

## ❌ Abgelehnt

```dataview
TABLE firma, position, datum_ablehnung, feedback
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status = "rejected"
```

## 📈 Statistik

- **Gesamt eingereicht:** `= length(filter(this.file.tasks, (t) => t.completed))`
- **Ausstehend:** `= length(filter(this.file.lists, (l) => l.status == "active"))`
- **Erfolgsquote:** `= (completed_count / submitted_count * 100).toFixed(1) + "%"`

```dataview
LIST
FROM "01 Projects/Bewerbungen/Firmen"
WHERE deadline < date(today)
GROUP BY status
```
```

**Schritte:**
1. Neue Note erstellen: `01 Projects/Bewerbungen/Status-Übersicht.md`
2. Code kopieren und anpassen (Feldnamen müssen zu deinen Frontmatter-Feldern passen)
3. TEST: Öffne die Note → sollte Tabelle mit aktiven Bewerbungen zeigen

---

### Dashboard 2: FREELANCE-KUNDEN-PIPELINE

**Datei:** `01 Projects/Freelance Gefahrstoffe Aufbau/Kunden-Pipeline.md`

```markdown
---
type: dashboard
status: AKTIV
---

# 🎯 Kunden-Pipeline

## 1️⃣ NEUE KONTAKTE (Follow-up erforderlich)

```dataview
TABLE kunde, branche, letzter_kontakt, nächster_kontakt
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "neuer-kontakt"
SORT nächster_kontakt ASC
```

## 2️⃣ IN VERHANDLUNG (Proposal gesendet)

```dataview
TABLE kunde, leistung, proposal_datum, erwartete_entscheidung
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "proposal-gesendet"
```

## 3️⃣ AKTIVE KUNDEN (laufende Projekte)

```dataview
TABLE kunde, leistung, projektstart, abschluss_geplant
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "aktiv"
SORT abschluss_geplant ASC
```

## 4️⃣ ABGESCHLOSSENE PROJEKTE

```dataview
TABLE kunde, leistung, abschluss_tatsächlich, ergebnis
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "completed"
SORT abschluss_tatsächlich DESC
```

## 📊 Pipeline-Statistik

- **Gesamt Kontakte:** `= length(filter(all_kunden, (k) => k.status))`
- **In Verhandlung:** `= length(filter(all_kunden, (k) => k.status == "proposal-gesendet"))`
- **Aktive Kunden:** `= length(filter(all_kunden, (k) => k.status == "aktiv"))`
- **Conversion Rate:** `= (aktive / gesamt * 100).toFixed(1) + "%"`
```

**Schritte:** Gleich wie Dashboard 1 (anpassen an deine Kunden-Felder)

---

### Dashboard 3: FINANZEN-ÜBERSICHT (optional aber empfohlen)

**Datei:** `02 Areas/Finanzen/Übersicht-2026.md`

```markdown
---
type: dashboard
---

# 💰 Finanzen 2026

## Einnahmen (Freelance)

```dataview
LIST
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "completed"
GROUP BY "Monat: " + monthofyear(abschluss_tatsächlich)
```

## Ausgaben (nach Kategorie)

```dataview
TABLE kategorie, betrag, datum
FROM "06 Daily Notes"
WHERE contains(tags, "#expense")
SORT datum DESC
```

## Ziele dieses Jahr

```dataview
LIST ziel, deadline, fortschritt
FROM "02 Areas/Finanzen"
WHERE type = "goal"
```
```

---

### Dokumentation:
- [ ] `02 Areas/Agent-Config/AUTOMATION-STATUS.md` aktualisieren
  - "Dataview Dashboards: ✅ AKTIV (3 Dashboards erstellt)"

### Zeitaufwand: **1-1.5h** (mit Testing)

---

## 1.4 TAG-KONVENTION STANDARDISIEREN

### Neue Datei: `02 Areas/Agent-Config/TAG-KONVENTION.md`

```markdown
---
type: standards
version: "1.0"
---

# 🏷️ TAG-KONVENTION FÜR DATAVIEW-QUERIES

**Standardisierte Tags für bessere Kategorisierung und Automation**

## Domain-Tags (Wozu gehört dieser Note?)

```
#domain/jobsuche
#domain/freelance-gefahrstoffe
#domain/finanzen
#domain/persönlich
```

## Status-Tags (Was ist der aktuelle Status?)

```
#status/active          (aktuell in Arbeit)
#status/completed       (fertig)
#status/blocked         (blockiert, braucht Input)
#status/waiting         (wartet auf Response)
#status/on-hold         (bewusst pausiert)
```

## Prioritäts-Tags (Wie wichtig ist das?)

```
#priority/high          (sofort bearbeiten)
#priority/medium        (diese Woche)
#priority/low           (wenn Zeit vorhanden)
```

## Aktion-Tags (Was sollte der Agent tun?)

```
#action/follow-up       (Nachverfolgung erforderlich)
#action/review          (Review/QA erforderlich)
#action/send-email      (Email schreiben)
#action/update-status   (Status aktualisieren)
```

## Beispiel: Vollständig getaggte Bewerbungs-Note

```yaml
---
firma: "Siemens AG"
position: "Office Manager"
status: "waiting"
tags:
  - domain/jobsuche
  - status/waiting
  - priority/high
  - action/follow-up
---
```

## Dataview-Query Beispiel (mit Tags)

```dataview
TABLE firma, position, deadline
FROM "01 Projects/Bewerbungen/Firmen"
WHERE contains(tags, "#status/active") AND contains(tags, "#priority/high")
SORT deadline ASC
```

```

### Schritte:

1. Neue Datei erstellen: `02 Areas/Agent-Config/TAG-KONVENTION.md`
2. Text kopieren (siehe oben)
3. Zu deinen Notes hinzufügen:
   ```yaml
   tags:
     - domain/jobsuche
     - status/active
     - priority/high
   ```

### Dokumentation:
- [ ] `02 Areas/Agent-Config/GLOBAL-RULES.md` aktualisieren
  - Neue Section: "### TAG-KONVENTION"
  - Link zu TAG-KONVENTION.md

### Zeitaufwand: **30 min**

---

## 1.5 CLAUDE.md AKTUALISIEREN

**Hinzufügen:**
```markdown
## Phase 1: Automation Implementiert (2026-07-28)

✅ Templater Folder Automation
✅ Daily Notes Automater
✅ Dataview Dashboards (Bewerbungen, Kunden, Finanzen)
✅ Tag-Konvention standardisiert

Nächste Phase: [[02 Areas/Agent-Config/VAULT-OPTIMIZATION-ROADMAP.md#PHASE-2]]
```

---

## PHASE 1 ZUSAMMENFASSUNG

| Task | Zeit | Status |
|------|------|--------|
| Templater Folder Automation | 20-30 min | ⏳ TODO |
| Daily Notes Automater | 20-30 min | ⏳ TODO |
| Dataview Dashboards (3 Stück) | 1-1.5h | ⏳ TODO |
| Tag-Konvention definieren | 30 min | ⏳ TODO |
| Dokumentation aktualisieren | 15 min | ⏳ TODO |
| **GESAMT** | **2.5-3.5h** | ⏳ GEPLANT |

**Nach Phase 1:** Automatische Template-Anwendung, Live-Dashboards, standardisierte Tagging-Struktur

---

---

# PHASE 2: AUTOMATION BACKBONE (Nächste Woche)

**Ziel:** Komplette Cloud + Git Automation, Cloud Routines  
**Ergebnis:** Automatische Backups + wöchentliche Reports + intelligente Reminders

---

## 2.1 OBSIDIAN GIT PLUGIN + CRON BACKUP

### Voraussetzung:
- ✅ Git installiert auf dem PC
- ✅ GitHub Repository für Vault vorhanden (existiert bereits)

### Schritte:

**1. Obsidian Git Plugin installieren:**
```
Settings → Community Plugins → Browse → "Obsidian Git"
→ Install & Enable
```

**2. Plugin konfigurieren:**
```
Settings → Obsidian Git

Einstellungen:
- Author name: Josef Linder
- Author email: joseflinder38@gmail.com
- Automatic pull interval: 0 (manuell nur)
- Auto backup interval: 10 (alle 10 Minuten)
- Commit message: "Auto-backup {{date:YYYY-MM-DD HH:mm}}"
- ☑️ Pull updates after push: ENABLED
```

**3. TEST:**
```
Obsidian → Ribbon (rechte Seite) → Git Icon
→ Sollte "Changes" anzeigen
→ Click "Commit" → sollte Git-Log anzeigen
```

**4. Windows PowerShell Cron-Script erstellen:**

**Datei:** `C:\Users\josef\AppData\Local\Memoria-Git-Backup.ps1`

```powershell
# Memoria Git Auto-Backup (alle 10 Minuten)

$vaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
$logFile = "$vaultPath\02 Areas\Persönliche Daten\Privat\git-backup.log"

Set-Location $vaultPath

# Git Pull (um konflikte zu vermeiden)
git pull origin main -q

# Git Add + Commit
git add -A
$message = "Auto-backup $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $message

# Git Push
git push origin main -q

# Log eintrag
"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Backup erfolgreich" | Add-Content $logFile
```

**5. Windows Task Scheduler einrichten:**

```powershell
# PowerShell als Admin ausführen

$taskName = "Memoria-Git-AutoBackup"
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration (New-TimeSpan -Days 365)
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File 'C:\Users\josef\AppData\Local\Memoria-Git-Backup.ps1'"

Register-ScheduledTask -TaskName $taskName -Trigger $trigger -Action $action -Description "Git Auto-Backup alle 10 Minuten"
```

### Überprüfung:
```
git log --oneline | head -10
→ Sollte die letzten Auto-Backup-Commits zeigen
```

### Dokumentation:
- [ ] `02 Areas/Agent-Config/AUTOMATION-STATUS.md` aktualisieren
  - "Git Auto-Backup: ✅ AKTIV (alle 10 Minuten)"

### Zeitaufwand: **1-1.5h**

---

## 2.2 TAG-KONVENTION RETRO-FITTING (alle bestehenden Notes)

### Aufgabe:
Alle bestehenden Notes in `01 Projects/Bewerbungen/Firmen/` und `01 Projects/Freelance/Kunden/` mit Tags ausstatten

### Schritte:

**1. Batch-Script für Bewerbungen:**

```powershell
$firmenkunden = Get-ChildItem "01 Projects/Bewerbungen/Firmen" -Filter "*.md"

foreach ($note in $firmenkunden) {
    $content = Get-Content $note.FullName -Raw
    
    # Überprüfe: hat schon Tags?
    if ($content -notmatch "tags:") {
        # Extrahiere Status aus Frontmatter
        $status = [regex]::Match($content, 'status:\s*"([^"]+)"').Groups[1].Value
        
        # Füge Tags hinzu (nach Frontmatter)
        $newContent = $content -replace '(---.*?---)', "`$1`ntags:`n  - domain/jobsuche`n  - status/$status`n  - priority/high"
        
        Set-Content $note.FullName $newContent
        Write-Host "✅ Tags hinzugefügt: $($note.Name)"
    }
}
```

**2. Manuelle Überprüfung:**
- Öffne 3-5 Bewerbungs-Notes → überprüfe Tags
- Korrigiere ggfs. manuell

### Zeitaufwand: **1-1.5h** (abhängig von Anzahl Notes)

---

## 2.3 CLOUD ROUTINES KONFIGURIEREN

### Ziel:
Automatische Claude Cloud-Agenten für tägliche Tasks

### Routine 1: WÖCHENTLICHE BEWERBUNGS-ZUSAMMENFASSUNG

**Name:** `Memoria-Weekly-Applications-Report`  
**Zeitplan:** Montag 08:00 Uhr  
**Prompt:**

```
Erstelle einen wöchentlichen Bericht über alle Bewerbungen:

Quelle: Lese alle Dateien aus 01 Projects/Bewerbungen/Firmen/

Berichte:
1. NEUE BEWERBUNGEN diese Woche
   - Firma, Position, Einreichdatum
   
2. RÜCKMELDUNGEN erhalten diese Woche
   - Firma, Termin, Ergebnis
   
3. FOLLOW-UP ERFORDERLICH
   - Firma, Grund, Deadline
   
4. STATISTIK
   - Gesamt aktive Bewerbungen
   - Erfolgsquote %
   
Output-Format: Markdown, speichern als:
06 Daily Notes/Weekly-Report-[DATUM].md

Regeln:
- Nur FAKTISCHE Status verwenden (nicht spekulieren)
- Keine persönlichen Daten exportieren (Adresse, Telefon)
```

**Schritte:**
1. Settings → Claude Cloud → Create New Routine
2. Name: `Memoria-Weekly-Applications-Report`
3. Schedule: Weekly, Monday 08:00
4. Instructions: Prompt (siehe oben)
5. Output folder: `06 Daily Notes/`

---

### Routine 2: FREELANCE-FOLLOW-UP-REMINDER

**Name:** `Memoria-Freelance-Followups`  
**Zeitplan:** Freitag 16:00 Uhr  
**Prompt:**

```
Überprüfe die Kunden-Pipeline und erstelle Followup-Reminders:

Quelle: Lese alle Dateien aus 01 Projects/Freelance/Kunden/

Suche nach:
1. Kunden mit nächster_kontakt DATUM < HEUTE
   → Aktion: "HEUTE Follow-up senden!"
   
2. Proposals, die älter als 2 Wochen sind (noch nicht signiert)
   → Aktion: "Status abfragen"
   
3. Aktive Projekte, die nächste Woche enden
   → Aktion: "Abschluss vorbereiten"

Output: Markdown-Liste mit Priorisierung
Speichern als: 06 Daily Notes/Freelance-Followup-[DATUM].md

Regeln:
- Nur echte Daten (kein Spekulieren)
- Fokus auf nächste Woche
```

**Schritte:** Gleich wie Routine 1

---

### Routine 3: FINANZ-MONATSBERICHT

**Name:** `Memoria-Monthly-Finance-Report`  
**Zeitplan:** 1. eines Monats 09:00 Uhr  
**Prompt:**

```
Erstelle einen Monatsfinanz-Bericht:

Quelle: 02 Areas/Finanzen.md + abgeschlossene Kunden-Projekte

Berichte:
1. FREELANCE-EINNAHMEN (diesen Monat)
   - Kunden, Leistungen, Beträge
   - Summe: €

2. AUSGABEN (diesen Monat)
   - Nach Kategorie aufgeschlüsselt
   - Summe: €

3. NETTO-GEWINN
   - Einnahmen - Ausgaben

4. PROGNOSE (Nächster Monat)
   - Erwartete Pipeline
   - Trends

Output: Markdown-Bericht
Speichern als: 02 Areas/Finanzen/Reports/Report-[YYYY-MM].md
```

---

### Dokumentation:
- [ ] `02 Areas/Agent-Config/AGENTEN-REGISTER.md` erweitern
  - Neue Section: "Cloud Routines"
  - Auflist: Weekly-Applications, Freelance-Followups, Monthly-Finance

### Zeitaufwand: **1.5-2h**

---

## 2.4 AGENTEN-ORDNER-ZUGRIFF DOKUMENTIEREN

### Neue Datei: `02 Areas/Agent-Config/AGENT-FOLDER-MAPPING.md`

```markdown
---
type: governance
---

# 🔐 AGENT → FOLDER MAPPING

**Wer darf in welche Ordner schreiben?**

## Primäre Verantwortung

| Agent | Primär-Ordner | Sekundär-Ordner | Status |
|-------|---------------|-----------------|--------|
| **Henry** | — (read-only) | — | Zentrale Datenquelle |
| **Karl** | 02 Areas/Finanzen/ | — | Tägl. Updates |
| **Nina** | 01 Projects/Bewerbungen/ | 06 Daily Notes/ | Tägl. Updates |
| **Otto** | 00 Inbox/ | 01 Projects/ | Kuratierung |
| **Rainer** | 07 Agents/ | 02 Areas/ | Wartung (geplant) |
| **Vera** | 03 Resources/ | — | Inhaltssammlung |
| **Lena** | 02 Areas/Gefahrstoffe Wissen/ | 03 Resources/ | Fachrecherche |
| **Max** | 02 Areas/Finanzen/ | — | Preis-Tracking |

## Konflikt-Vermeidung

- **Karl + Max** → Beide in `02 Areas/Finanzen/` (separate Sektion: "Market Data" vs. "Spending")
- **Nina + Otto** → Nina schreibt in Bewerbungen/, Otto archiviert alt Einträge
- **Vera + Lena** → Vera = Links/Resources, Lena = tiefe Fach-Analyse

```

---

## 2.5 CLAUDE.md AKTUALISIEREN

```markdown
## Phase 2: Automation Backbone (2026-XX-XX)

✅ Obsidian Git Auto-Backup (alle 10 Minuten)
✅ Tag-Konvention Retro-fitting (alle Notes getaggt)
✅ Cloud Routines aktiviert (3 Routines läuft)
✅ Agent-Folder-Mapping dokumentiert

Nächste Phase: [[02 Areas/Agent-Config/VAULT-OPTIMIZATION-ROADMAP.md#PHASE-3]]
```

---

## PHASE 2 ZUSAMMENFASSUNG

| Task | Zeit | Status |
|------|------|--------|
| Obsidian Git + Cron | 1-1.5h | ⏳ TODO |
| Tag Retro-fitting | 1-1.5h | ⏳ TODO |
| Cloud Routines (3x) | 1.5-2h | ⏳ TODO |
| Folder-Mapping dokumentieren | 30 min | ⏳ TODO |
| Dokumentation aktualisieren | 15 min | ⏳ TODO |
| **GESAMT** | **4.5-6h** | ⏳ GEPLANT |

**Nach Phase 2:** Automatische Git-Backups, Cloud-Agenten für Reports, strukturierte Automation

---

---

# PHASE 3: ADVANCED FEATURES (Optional, später)

**Ziel:** Vollständige AI-Integration + Zettelkasten für Knowledge Discovery  
**Timeframe:** 4-6 Wochen nach Phase 2

---

## 3.1 n8N WEBHOOKS FÜR LEAD-CAPTURE

**Ziel:** Website-Kontaktformular → automatisch Kunden-Note erstellen

### Technologie:
- n8n Cloud (kostenlos bis 100 Ausführungen/Monat)
- Webhook Trigger
- Obsidian Note Creation

### Workflow:

```
Website-Form Submission
    ↓
n8n Webhook empfängt Daten
    ↓
Überprüfung: Ist Kunden-Note vorhanden?
    ↓
(Nein) → Obsidian Webhook: Neue Kunden-Note mit Template erstellen
    ↓
POST an Obsidian URI scheme: obsidian://new?file=...&content=...
```

### Zeitaufwand: **2-3h** (setzt n8n-Grundkenntnisse voraus)

### Dokumentation:
```markdown
## n8n Webhook Integration (Phase 3)

Aktiviert automatische Kunden-Erfassung von Website-Kontaktformular.

**Setup:**
1. n8n Account erstellen (n8n.io)
2. Workflow kopieren: [Link zur Workflow-Datei]
3. Webhook URL: [generiert von n8n]
4. Obsidian Webhook registrieren: [Anleitung]
5. Website-Formular -> n8n Webhook konfigurieren

**Testing:**
- Test-Submission über Website → sollte Note in Kunden-Ordner erstellen
```

---

## 3.2 ZETTELKASTEN-HUB-INDIZES

**Ziel:** Knowledge Discovery für Gefahrstoffe-Expertise

### Struktur:

```
02 Areas/
├─ Zettelkasten-Gefahrstoffe-Hub.md  (Index + MOC)
├─ Zettelkasten-Gefahrstoffe/
│  ├─ TRGS-519-Grundlagen.md         (atomare Note)
│  ├─ Asbest-Sanierung.md            (atomare Note)
│  ├─ GHS-Einstufung.md              (atomare Note)
│  └─ ... (weitere atomare Notes)
```

### Hub-Format:

```markdown
# 🧠 Zettelkasten: Gefahrstoffe

## Atomare Konzepte

[[TRGS-519-Grundlagen]] ← Einstieg für Anfänger
  ↓ Verbindungen zu:
  - [[Asbest-Sanierung]] (praktische Anwendung)
  - [[GHS-Einstufung]] (Klassifizierung)

[[Betriebsanweisung-Vorlage]] ← Template für Kunden
  ↓ Basiert auf:
  - [[TRGS-519-Grundlagen]]
  - [[TRGS-521-Unterweisungen]]

## Thematische Cluster

### Sanierung & Abruch
- [[Asbest-Sanierung]]
- [[Sanierungsplanung]]
- [[Dokumentation-Sanierung]]

### Schulung & Unterweisungen
- [[TRGS-521-Unterweisungen]]
- [[Unterweisungs-Material]]
- [[Prüfungsfragen]]

### Kundenprojekte (verlinkt)
- [[01 Projects/Freelance/Kunden/MusterGmbH]] (nutzt diese Hub-Notes)
```

### Zeitaufwand: **2-3h** (abhängig von Anzahl atomarer Notes)

---

## 3.3 OBSIDIAN SYNC ODER ICLOUD BACKUP

**Wahl:**
- **Option A:** Obsidian Sync (€4.99/mo, automatisch)
- **Option B:** GitHub + iCloud (kostenlos, manuell mit Script)

**Empfehlung:** Option B (Josef hat bereits GitHub)

---

## PHASE 3 ZUSAMMENFASSUNG

| Task | Zeit | Priorität | Status |
|------|------|-----------|--------|
| n8n Webhook Lead-Capture | 2-3h | 🟡 MITTEL | ⏳ OPTIONAL |
| Zettelkasten-Hubs erstellen | 2-3h | 🟡 MITTEL | ⏳ OPTIONAL |
| Obsidian Sync einrichten | 30 min | 🟢 LOW | ⏳ OPTIONAL |
| **GESAMT** | **5-7h** | — | ⏳ OPTIONAL |

**Nach Phase 3:** Vollständige Lead-Automation + Knowledge-Discovery für Gefahrstoff-Expertise

---

---

# 🎯 ZUSAMMENFASSUNG: KOMPLETTER ROADMAP

## Timeline

```
KW 30 (27.07 - 02.08)
  └─ Phase 1: Quick Wins (2.5-3.5h)
     ✅ Templater + Daily Notes + Dataview + Tags

KW 31 (03.08 - 09.08)
  └─ Phase 2: Automation Backbone (4.5-6h)
     ✅ Git Auto-Backup + Cloud Routines + Tag Retro-fitting

KW 32+ (10.08+)
  └─ Phase 3: Advanced (5-7h, OPTIONAL)
     ⏳ n8n + Zettelkasten + Sync

GESAMT: 12-17h über 6 Wochen = ~2-3h pro Woche
```

## Kritische Erfolgsfaktoren

| Faktor | Maßnahme |
|--------|----------|
| **Test nach jedem Schritt** | Nicht blindlings implementieren |
| **Dokumentation aktualisieren** | AUTOMATION-STATUS.md führen |
| **Backup vor jedem großen Change** | Git Commit machen |
| **Weekly Review** | Sonntags 10 min prüfen: Läuft die Automation? |

## Messgrößen (wie prüfen wir Erfolg?)

- ✅ Phase 1 erfolgreich: Dataview-Dashboards zeigen Echtzeit-Daten
- ✅ Phase 2 erfolgreich: Git-Backups sichtbar in GitHub, Cloud Routines schreiben Reports
- ✅ Phase 3 erfolgreich: Neue Kundenform erzeugt automatisch Note, Zettelkasten-Queries funktionieren

---

**Nächster Schritt:** Phase 1 starten? → [[#PHASE-1-QUICK-WINS-DIESE-WOCHE]]

**Fragen?** → Josef fragt Claudian im Vault
