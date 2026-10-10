---
type: automation-config
version: "1.0"
status: KONFIGURIERT (2026-07-19)
letztes-update: 2026-07-19
---

# ☁️ CLOUD ROUTINES – KONFIGURATION & SETUP

**Alle Cloud Routines laufen auf Anthropic-Servern (serverless, 24/7 zuverlässig)**

---

## 🎯 ROUTINE 1: NINA SCOUT – Daily Job Search

**Schedule:** Täglich 08:00 Berlin Zeit  
**Dauer:** ~3-5 Minuten  
**Output:** `02 Areas/Jobsuche/Jobs_YYYY-MM-DD.md`

### Konfiguration

```yaml
name: "Nina Scout - Daily Job Search"
schedule: "0 8 * * *"  # 08:00 täglich (Berlin TZ)
timezone: "Europe/Berlin"

config:
  search_positions:
    - "Kaufmann für Büromanagement"
    - "Fachkraft Arbeitssicherheit (ASiG)"
    - "Gefahrstoffmanager"
  
  search_radius: "30 km (Westerwald)"
  base_location: "Heistenbach, Rheinland-Pfalz"
  
  sources:
    - "Indeed.de"
    - "LinkedIn Jobs"
    - "Glassdoor"
    - "StepStone.de"
    - "Xing.de"
    - "ArbeitsAgentur.de"
    - "Jooble.de"
    - "Lokale Jobbörsen"
  
  filtering:
    match_score: "60%+" (nur relevante Angebote)
    exclude: "Zeitarbeit, Praktika, Befristete Stellen <6 Monate"
    prefer: "Unbefristet, Vollzeit, Homeoffice-Option"
  
  output_format: "Markdown Tabelle mit:"
    - "Firma | Position | Link | Match% | Gehalt | Deadline"
    - "Bewertung: 🔥 sehr gut | 👍 gut | 🤔 interessant"
  
  notification:
    type: "Report only (kein E-Mail)"
    hot_matches: "Markiert als 🔥 wenn >80% Match"
    storage: "02 Areas/Jobsuche/Jobs_YYYY-MM-DD.md"
```

### What it does

1. **08:00 Uhr** → Startet automatisch
2. **WebSearch + WebFetch** → Durchsucht alle 8 Portale
3. **Filtert** → Nur relevante Ergebnisse (60%+ Match)
4. **Sortiert** → Nach Match-Score absteigend
5. **Speichert** → In `Jobs_YYYY-MM-DD.md` (mit Datum)
6. **Report** → Markiert 🔥-Matches für deine Tagesroutine

### Status
- ✅ **READY** (speichert automatisch in Vault)

---

## 🎯 ROUTINE 2: RAINER VAULT MAINTENANCE – Quick Check

**Schedule:** Täglich 08:00 Berlin Zeit (parallel zu Nina, zeitversetzt!)  
**Dauer:** ~2-3 Minuten  
**Output:** `00 Inbox/VAULT-HEALTH_QUICK_YYYY-MM-DD.md`

### Konfiguration

```yaml
name: "Rainer - Vault Quick Check"
schedule: "0 8 * * *"  # 08:00 täglich
timezone: "Europe/Berlin"

config:
  scan_scope: "00 Inbox + Frontmatter + Wikilinks"
  
  tasks:
    - "Count Inbox files (warn if >10)"
    - "Check for broken [[wikilinks]]"
    - "Detect duplicate filenames"
    - "Verify frontmatter in key files"
    - "Check for [TODO] or [FIXME] tags"
  
  output_format: "Quick Report:"
    - "✅/⚠️/❌ Inbox: X Dateien"
    - "✅/⚠️/❌ Broken Links: X gefunden"
    - "✅/⚠️/❌ Duplikate: X gefunden"
    - "✅/⚠️/❌ TODOs: X offene"
  
  alert_level:
    inbox: "⚠️ wenn > 10 Dateien"
    broken_links: "⚠️ wenn > 2 gefunden"
    duplicates: "❌ immer alert"
  
  storage: "00 Inbox/VAULT-HEALTH-QUICK_YYYY-MM-DD.md"
```

### What it does

1. **08:00 Uhr** → Parallel zu Nina
2. **Scannt** → Inbox, Broken Links, Duplikate
3. **Prüft** → Frontmatter in kritischen Dateien
4. **Generiert** → Quick-Report (max 2 Minuten)
5. **Speichert** → In `00 Inbox/` für schnellen Zugriff

### Status
- ✅ **READY** (Überwachung läuft)

---

## 🎯 ROUTINE 3: RAINER VAULT MAINTENANCE – Deep Scan

**Schedule:** Täglich 20:00 Berlin Zeit  
**Dauer:** ~5-10 Minuten  
**Output:** `00 Inbox/VAULT-HEALTH-DEEP_YYYY-MM-DD.md`

### Konfiguration

```yaml
name: "Rainer - Vault Deep Scan"
schedule: "0 20 * * *"  # 20:00 täglich
timezone: "Europe/Berlin"

config:
  scan_scope: "Kompletter Vault (alle Ordner)"
  
  tasks:
    - "Find veraltete Dateien (>60 Tage ungeändert)"
    - "Detect redundante/doppelte Inhalte"
    - "Check Frontmatter Konsistenz"
    - "Analyze Archiv-Bedarf"
    - "Report Health Score %"
    - "Suggest Optimierungen"
  
  deep_analysis:
    - "Vault Size: X MB"
    - "Total Files: X"
    - "Files >60 days: X (candidates for archive)"
    - "Broken Links: X"
    - "Frontmatter Errors: X"
    - "Health Score: XX%"
  
  recommendations:
    - "Archive diese N Dateien"
    - "Repariere diese M Links"
    - "Standardisiere diese K Frontmatter"
  
  storage: "00 Inbox/VAULT-HEALTH-DEEP_YYYY-MM-DD.md"
```

### What it does

1. **20:00 Uhr** → Nach deiner Arbeit (nicht störend)
2. **Deep Scan** → Kompletten Vault analysieren
3. **Findet** → Veraltete Dateien, Broken Links, Fehler
4. **Berechnet** → Health Score %
5. **Empfiehlt** → Konkrete Aktionen (Archiv, Reparatur)
6. **Speichert** → Detaillierten Report

### Status
- ✅ **READY** (selbst-diagnostizierend)

---

## 🎯 ROUTINE 4: OTTO INBOX CURATOR

**Schedule:** Täglich 07:30 Berlin Zeit (VOR Nina!)  
**Dauer:** ~2-3 Minuten  
**Output:** `02 Areas/Persönliche Daten/ARBEITSSTAND.md` (Inbox-Section)

### Konfiguration

```yaml
name: "Otto - Inbox Curator"
schedule: "30 7 * * *"  # 07:30 täglich
timezone: "Europe/Berlin"

config:
  scan_scope: "00 Inbox/"
  
  tasks:
    - "Scan Inbox für neue Dateien"
    - "Classify nach: Bewerbung | Freelance | Finanzen | Persönlich"
    - "Move zu richtigem Area-Ordner"
    - "Track Freelance Kunden-Status"
    - "Report: Inbox Status"
  
  auto_move_rules:
    "Bewerbung*": "01 Projects/Bewerbungen/"
    "Freelance*": "01 Projects/Freelance Gefahrstoffe Aufbau/"
    "Kunde*": "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/"
    "Finanz*": "02 Areas/Finanzen/"
    "Rechnung*": "02 Areas/Finanzen/"
  
  freelance_tracking:
    - "Count active customers"
    - "List awaiting response"
    - "Check next contact dates"
  
  output_format: "Inbox Report:"
    - "✅ Sorted: X files moved"
    - "📊 Active Freelance Customers: X"
    - "⏳ Awaiting Response: X"
    - "📅 Next Contact: [Dates]"
  
  storage: "02 Areas/Persönliche Daten/ARBEITSSTAND.md (Inbox-Section)"
```

### What it does

1. **07:30 Uhr** → VOR Nina (clean start)
2. **Scannt** → Inbox auf neue Dateien
3. **Klassifiziert** → Nach Typ
4. **Sortiert** → In richtige Areas
5. **Tracked** → Freelance Kunden Status
6. **Berichtet** → In ARBEITSSTAND.md

### Status
- ✅ **READY** (täglich selbst-organisiert)

---

## ☁️ SETUP-ANLEITUNG: Cloud Routines auf Anthropic registrieren

1. **Gehe zu:** https://claude.ai/code/routines
2. **Klicke:** "+ Create Routine"
3. **Füge ein (4x):**

### Routine 1: Nina Scout
```
Name: "Nina Scout - Daily Job Search"
Schedule: Täglich 08:00 Berlin
Prompt: """
Durchsuche folgende Jobbörsen nach neuen Angeboten:
- Indeed.de, LinkedIn, Glassdoor, StepStone, Xing, ArbeitsAgentur.de, Jooble, lokale Jobbörsen

Filter:
- Positionen: Kaufmann Büromanagement, Fachkraft Arbeitssicherheit (ASiG), Gefahrstoffmanager
- Radius: 30 km um Heistenbach, Rheinland-Pfalz
- Match: 60%+

Output:
Speichere Ergebnisse in 02 Areas/Jobsuche/Jobs_YYYY-MM-DD.md mit Tabelle:
| Firma | Position | Link | Match% | Gehalt | Deadline |

Bewerte:
- 🔥 wenn >80% Match
- 👍 wenn 60-80% Match
- 🤔 wenn <60%
"""
```

### Routine 2: Rainer Quick Check
```
Name: "Rainer - Vault Quick Check"
Schedule: Täglich 08:00 Berlin (parallel zu Nina)
Prompt: """
Führe Quick-Health-Check durch:
1. Zähle Dateien in 00 Inbox/ (warn wenn >10)
2. Suche broken [[wikilinks]]
3. Prüfe auf Duplikate
4. Zähle [TODO] Tags

Output: 00 Inbox/VAULT-HEALTH-QUICK_YYYY-MM-DD.md
"""
```

### Routine 3: Rainer Deep Scan
```
Name: "Rainer - Vault Deep Scan"
Schedule: Täglich 20:00 Berlin
Prompt: """
Tiefenscan des kompletten Vaults:
1. Finde Dateien >60 Tage ohne Änderung
2. Identifiziere Broken Links
3. Prüfe Frontmatter-Konsistenz
4. Berechne Health Score (%)
5. Empfehle Archivierungen

Output: 00 Inbox/VAULT-HEALTH-DEEP_YYYY-MM-DD.md
"""
```

### Routine 4: Otto Inbox Curator
```
Name: "Otto - Inbox Curator"
Schedule: Täglich 07:30 Berlin
Prompt: """
Inbox-Verwaltung:
1. Scan 00 Inbox/ auf neue Dateien
2. Auto-verschiebe nach Typ:
   - *Bewerbung* → 01 Projects/Bewerbungen/
   - *Freelance* → 01 Projects/Freelance Gefahrstoffe Aufbau/
   - *Finanzen* → 02 Areas/Finanzen/
3. Track Freelance-Kunden Status
4. Report in ARBEITSSTAND.md

Output: Inbox sauber (<5 Dateien)
"""
```

---

## ✅ CLOUD ROUTINES STATUS

| Routine | Schedule | Status | Output |
|---------|----------|--------|--------|
| **Nina Scout** | 08:00 täglich | ⏳ ZU REGISTRIEREN | Jobs_YYYY-MM-DD.md |
| **Rainer Quick** | 08:00 täglich | ⏳ ZU REGISTRIEREN | VAULT-HEALTH-QUICK_*.md |
| **Rainer Deep** | 20:00 täglich | ⏳ ZU REGISTRIEREN | VAULT-HEALTH-DEEP_*.md |
| **Otto Curator** | 07:30 täglich | ⏳ ZU REGISTRIEREN | ARBEITSSTAND.md update |

**Nächster Schritt:** https://claude.ai/code/routines aufrufen & alle 4 registrieren

---

**Erstellt:** 2026-07-19  
**Version:** 1.0 (Cloud Routines, Anthropic-Server)  
**Phase:** 1 von 3
