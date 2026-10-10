---
type: agent-optimization
version: "2.0"
letztes-update: 2026-07-06
status: IMPLEMENTIERUNG AUSSTEHEND
---

# 🤖 AGENT-SYSTEM OPTIMIERUNG – Tägliche Funktionen & Web-Verbesserungen

**Ziel:** Automatisierte tägliche Updates für Finanz-Tracker, Jobsuche und Marktbeobachtung  
**Basis:** Deep Research + bestehende Windows Task Scheduler Automation  
**Timeline:** Phase 1 (Juli 2026) bis Phase 3 (August 2026)

---

## 📊 AKTUELLER STATUS (2026-07-06)

### ✅ BEREITS AUTOMATISIERT (mit Task Scheduler)

| Agent | Zeitplan | Funktion | Status |
|-------|----------|----------|--------|
| **Karl Market Watch** | tägl. 10:00 | Aktien, Edelmetalle, Kryptos | ✅ AKTIV |
| **Vault Health Check** | tägl. 06:00 | Struktur-Integrität | ✅ AKTIV |
| **Git Daily Push** | tägl. 20:00 | GitHub-Backup | ✅ AKTIV |
| **Memoria Vault Backup** | tägl. auto | Robocopy-Sicherung | ✅ AKTIV |

### 🔄 GEPLANT – Phase 1 (Juli 2026)

| Agent | Zeitplan | Funktion | Priorität |
|-------|----------|----------|-----------|
| **Nina Scout** | tägl. 08:00 | Jobsuche + Gehaltstrends | 🔴 HOCH |
| **Vera Research** | wöchentl. Do 09:00 | Gefahrstoff-Updates & Verordnungen | 🔴 HOCH |
| **Freelance Markt-Monitor** | tägl. 14:00 | Beratungs-Tarife & Wettbewerber | 🟡 MITTEL |

---

## 🎯 PHASE 1: NINA SCOUT ERWEITERN (Jobsuche-Optimierung)

### 📌 ZIEL
Tägliche automatisierte Jobsuche mit **Relevanz-Bewertung** und **Gehaltstrends**.

### 🔧 IMPLEMENTIERUNG

**Neue Datenquellen (Web-Integration):**

```
├─ JobSpy API (Python-Wrapper)
│  ├─ LinkedIn Jobs Scraper
│  ├─ Indeed API
│  ├─ Glassdoor Job Data
│  ├─ Google Jobs Feed
│  └─ ZipRecruiter API
│
├─ Gehaltstrends-APIs
│  ├─ Glassdoor Salary Data
│  ├─ Indeed Salary Reports
│  ├─ Bundesagentur für Arbeit (BA) API
│  └─ DESTATIS (Statistisches Bundesamt)
│
└─ Wettbewerbs-Tracking
   ├─ LinkedIn Konkurrenz-Profile
   └─ Xing-Profil-Vergleiche
```

### 📋 NEUE FUNKTIONEN FÜR NINA

**1. Tägl. 08:00 Uhr — Job-Aggregation**
```powershell
# Script: nina-daily-jobsearch.ps1
# Sucht Positionen im 50km Radius um Heistenbach (65558)
# Kategorien:
#   - Büro-Manager (Vollzeit)
#   - Fachkraft für Arbeitssicherheit
#   - Sicherheitsbeauftragter
#   - Gefahrstoff-Spezialist
#   - Verwaltungs-Fachkraft

# Ausgabe: 02 Areas/Jobsuche-Archiv/Jobs_YYYY-MM-DD.md
# Rating: Match % basierend auf deinen Qualifikationen
```

**2. Gehaltstrends-Analyse**
```
Erfasste Daten (täglich aktualisiert):
├─ Durchschnitt Büro-Manager in RP: €28,600 – €38,500
├─ Durchschnitt Fachkraft Arbeitssicherheit: €35,000 – €55,000
├─ Durchschnitt Sicherheitsbeauftragter: €40,000 – €65,000
└─ Freelance-Beratungs-Tarife: €40–€100/h (Benchmark)

Speicherort: 02 Areas/Jobsuche/Gehaltstrends_2026.md
Update-Freq: Täglich, mit 7-Tage-Trend-Analyse
```

**3. Persönliche Match-Bewertung**
```
Bewertungs-Kriterien:
✅ Deine TRGS-Zertifikate (519/521) vorhanden?
✅ Brandschutz-Zertifikat relevant?
✅ Gefahrstoff-Kategorie der Stelle?
✅ Ort im 50km Radius? (+ Pendelzeit-Analyse)
✅ Gehalt im angestrebten Bereich?

Match-Score: 0–100%
🔥 SEHR RELEVANT: 85%+
👍 GUT: 70–84%
🤔 INTERESSANT: 50–69%
❌ NICHT RELEVANT: <50%
```

### 📁 NEUE DATEIEN

```
02 Areas/Jobsuche/
├─ Jobsuche.md (bestehend – wird erweitert)
├─ Gehaltstrends_2026.md (NEU – tägl. Update)
├─ Match-Bewertungen_2026.md (NEU – tägl. Update)
├─ Jobsuche-Archiv/
│  ├─ Jobs_2026-07-06.md
│  ├─ Jobs_2026-07-07.md
│  └─ ... (täglich neu)
└─ Scripts/ (NEU)
   └─ nina-daily-jobsearch.ps1
```

---

## 🎯 PHASE 2: VERA RESEARCH ERWEITERN (Gefahrstoff-Wissen)

### 📌 ZIEL
Wöchentliche automatisierte Überwachung von Gefahrstoff-Verordnungen, Schulungs-Angeboten und Branchennews.

### 🔧 IMPLEMENTIERUNG

**Neue Datenquellen (Web-Integration):**

```
├─ Regulatorische Überwachung
│  ├─ Bundesanstalt für Arbeitsschutz (BAuA)
│  │  └─ TRGS-Änderungen & Veröffentlichungen
│  ├─ EU-Chemikalien-Verordnungen
│  │  └─ ECHA (Europäische Chemikalienagentur)
│  ├─ Berufsgenossenschaft für Feinmechanik & Elektrotechnik (BGFE)
│  └─ Unfallversicherungs-Träger (BG Bau, BG Handel)
│
├─ Schulungs- & Zertifizierungs-Updates
│  ├─ TÜV-Angebote (Gefahrstoffe-Kurse)
│  ├─ DEKRA Seminare (TRGS 519/521 Auffrischung)
│  ├─ Branchenverbände (Fachverband Gefahrstoffe)
│  └─ Online-Kurse (z.B. Udemy, LinkedIn Learning)
│
└─ Branchennews & Best Practices
   ├─ Fachzeitschriften (Sicherheitsingenieur, ASU)
   ├─ LinkedIn Thought Leaders in Gefahrstoffen
   ├─ Behördliche Pressemitteilungen
   └─ Unfallmeldungs-Analysen (Lerneffekte)
```

### 📋 NEUE FUNKTIONEN FÜR VERA

**1. Wöchentl. Donnerstag 09:00 Uhr — Regulatory Scan**
```
TRGS-Updates prüfen:
├─ Neue Verordnungen seit letzter Woche?
├─ Änderungen zu bestehenden TRGS?
├─ Harmonisierung mit EU-Vorgaben?
└─ Auswirkungen auf deine Zertifikate?

Speicherort: 02 Areas/Gefahrstoffe Wissen/Regulatory-Updates_2026.md
```

**2. Schulungs-Angebot-Aggregation**
```
Monitored Platforms:
├─ TÜV-Akademie (TRGS-Refresher-Kurse)
├─ DEKRA Academy
├─ BAuA Seminare
├─ Online-Kurs-Portale (Skill-Building)
└─ Branchenverbands-Events

Erfasst:
✓ Kursname, Datum, Ort
✓ Zertifikat/Gültigkeit nach Abschluss
✓ Kosten & Finanzierungsmöglichkeiten
✓ Relevanz für deine Expertise

Speicherort: 02 Areas/Gefahrstoffe Wissen/Schulungs-Angebote_2026.md
```

**3. Branchennews-Digest**
```
Automatisch gesammeltes Wissen:
├─ Neue Sicherheits-Best-Practices
├─ Häufige Unfallszenarien & Lerneffekte
├─ Normalisierungen & Standards-Änderungen
├─ Innovationen in Arbeitssicherheit
└─ Gerichtliche Urteile zu Gefahrstoffen

Format: Wöchentliche Zusammenfassung + Links
Speicherort: 02 Areas/Gefahrstoffe Wissen/Branchennews_2026.md
```

### 📁 NEUE DATEIEN

```
02 Areas/Gefahrstoffe Wissen/
├─ Gefahrstoffe Wissen.md (bestehend – wird erweitert)
├─ Regulatory-Updates_2026.md (NEU – wöchentl. Update)
├─ Schulungs-Angebote_2026.md (NEU – wöchentl. Update)
├─ Branchennews_2026.md (NEU – wöchentl. Update)
├─ Zertifikats-Gültigkeits-Monitor.md (NEU – monatl. Update)
└─ Scripts/ (NEU)
   └─ vera-weekly-research.ps1
```

---

## 🎯 PHASE 3: FREELANCE MARKT-MONITOR (Geschäftsentwicklung)

### 📌 ZIEL
Tägliche Überwachung von Beratungs-Tarife, Wettbewerber-Angeboten und Zielkunden-Branchen.

### 🔧 IMPLEMENTIERUNG

**Neue Datenquellen (Web-Integration):**

```
├─ Konkurrenz-Tarif-Tracking
│  ├─ Xing-Profil-Analyse (Gefahrstoff-Berater)
│  ├─ LinkedIn-Konkurrenz-Profile
│  ├─ Freelance-Plattformen (Upwork, Fiverr, Freelancer.de)
│  └─ Direkte Webseiten-Scraping von Beratungsfirmen
│
├─ Zielkunden-Branche-Monitoring
│  ├─ Chemie & Pharma (Westerwald/RLP)
│  ├─ Metall- & Maschinenbau
│  ├─ Logistik & Lagerung
│  └─ Handwerk & Bauwirtschaft
│
├─ Auftrag-Markt-Überwachung
│  ├─ Vergabeplattformen (eBid, Mercado Público)
│  ├─ KMU-Netzwerk-Events
│  └─ Branchenmessen & Networking
│
└─ Preismodell-Benchmarking
   ├─ Stundensätze: €40–€100/h Spektrum
   ├─ Pauschalpreise: Gefahrstoffkataster €500–€2000
   ├─ Betriebsanweisung: €100–€300/Stück
   └─ Unterweisung: €30–€80/h
```

### 📋 NEUE FUNKTIONEN

**1. Tägl. 14:00 Uhr — Wettbewerbs-Analyse**
```
Tracking-Kategorien:
├─ Top 10 Konkurrenz-Profile (Xing/LinkedIn)
├─ Angebotene Leistungen
├─ Veröffentlichte Tarife (sofern sichtbar)
├─ Bewertungen & Testimonials
└─ Kundenreviews auf Plattformen

Speicherort: 02 Areas/Freelance Gefahrstoffe/Wettbewerbs-Analyse_2026.md
Trend-Analyse: Wöchentliche Zusammenfassung
```

**2. Zielkunden-Radar**
```
Automatische Identifikation von KMU mit Gefahrstoff-Relevanz:
├─ Neue Firmengründungen in RLP (Gewerbeanmeldungen)
├─ Branchenmesse-Teilnehmer
├─ LinkedIn-Job-Posts mit "Gefahrstoffe", "Sicherheit"
├─ BauMA- & IHK-Events in der Region
└─ Behördliche Stellungnahmen (Umweltauflagen, Sicherheitsmängel)

Scoring:
✅ SEHR RELEVANT: Chemie/Pharma/Metall + Westerwald
✅ RELEVANT: Andere Industrien mit Gefahrstoffen
👍 INTERESSANT: Größer >50 MA, Budget vorhanden

Speicherort: 02 Areas/Freelance Gefahrstoffe/Zielkunden-Radar_2026.md
```

**3. Preismodell-Optimierung**
```
Laufende Daten-Erfassung:
├─ Was verdienen ähnliche Berater?
├─ Welche Pauschalpreise sind realistisch?
├─ Welche Zusatzleistungen sind wertvoll?
├─ Saisonale Schwankungen?
└─ Regionale Unterschiede (Westerwald vs. Rhein-Main)?

Outputformat: Monatliche Preismodell-Empfehlungen
Speicherort: 02 Areas/Freelance Gefahrstoffe/Preismodell_2026.md
```

### 📁 NEUE DATEIEN

```
02 Areas/Freelance Gefahrstoffe/
├─ Freelance Gefahrstoffe.md (bestehend – wird erweitert)
├─ Wettbewerbs-Analyse_2026.md (NEU – tägl. Update)
├─ Zielkunden-Radar_2026.md (NEU – tägl. Update)
├─ Preismodell_2026.md (NEU – monatl. Update)
└─ Scripts/ (NEU)
   └─ freelance-daily-monitor.ps1
```

---

## 🛠️ TECHNISCHE IMPLEMENTIERUNG

### WINDOWS TASK SCHEDULER SETUP

Alle neuen Automationen verwenden **bewährte Methode**:

```powershell
# Vorlage für neuen Task
schtasks /create /tn "Name" `
  /tr "powershell -ExecutionPolicy Bypass -File C:\path\script.ps1" `
  /sc DAILY /st HH:MM /z
```

### NEUE SCRIPTS (PowerShell)

| Script | Trigger | Funktion |
|--------|---------|----------|
| `nina-daily-jobsearch.ps1` | tägl. 08:00 | Job-Aggregation + Match-Scoring |
| `vera-weekly-research.ps1` | Do 09:00 | TRGS + Schulungs-Scan |
| `freelance-daily-monitor.ps1` | tägl. 14:00 | Konkurrenz + Zielkunden-Radar |

### API-INTEGRATION (Optional aber empfohlen)

**Kosten-freie APIs:**
- JobSpy (kostenlos, Python-Wrapper)
- Alpha Vantage (5 Requests/min kostenlos, für Markt-Daten)
- EODHD (kostenlose Demo, historische Daten)
- BAuA Open Data (TRGS-Updates – komplett kostenlos)

**Kosten gering:**
- LinkedIn Jobs Scraper (über n8n: ~$0.10/Job)
- Glassdoor Salary Data (via Scraper: ~$20/Monat)

---

## 📅 IMPLEMENTIERUNGS-ROADMAP

### WOCHE 1 (06–12 Juli 2026) – NINA SCOUT
- [ ] JobSpy-Integration aufsetzen
- [ ] Gehaltstrends-Script schreiben
- [ ] Windows Task für 08:00 Uhr erstellen
- [ ] Test-Lauf durchführen

### WOCHE 2 (13–19 Juli 2026) – VERA RESEARCH
- [ ] BAuA-API Docs studieren
- [ ] TRGS-Monitoring-Script entwickeln
- [ ] Schulungs-Plattform-Scraper aufsetzen
- [ ] Windows Task für Do 09:00 erstellen
- [ ] Test-Lauf durchführen

### WOCHE 3–4 (20–31 Juli 2026) – FREELANCE MONITOR
- [ ] LinkedIn/Xing Scraper aufsetzen
- [ ] Zielkunden-Radar-Logik entwickeln
- [ ] Preismodell-Tracker schreiben
- [ ] Windows Task für 14:00 erstellen
- [ ] Test-Lauf durchführen

### AUGUST 2026 – OPTIMIERUNG & FEINTUNING
- [ ] Alle 3 Agenten parallel laufen lassen
- [ ] False Positives reduzieren
- [ ] Alerts & Notifications konfigurieren
- [ ] Monatliche Reports erstellen

---

## 📊 ERWARTETE OUTPUTS

Nach vollständiger Implementierung erhalten Sie:

**TÄGLICH:**
- ✅ Nina Scout: 5–15 neue Job-Angebote (mit Match %)
- ✅ Karl Market Watch: Aktien, Edelmetalle, Kryptos (wie jetzt)
- ✅ Freelance Monitor: Konkurrenz-Update + 2–3 Zielkunden-Leads

**WÖCHENTLICH:**
- ✅ Vera Research: TRGS-Updates + Schulungs-Angebote
- ✅ Gehaltstrends-Summary
- ✅ Wettbewerbs-Analyse

**MONATLICH:**
- ✅ Preismodell-Empfehlung
- ✅ Career-Entwicklungs-Report
- ✅ Freelance-Geschäfts-Report

---

## ⚡ QUICK WINS (Sofort umsetzbar)

1. **Heute noch:** Nina Scout Task für morgen 08:00 aufsetzen (JobSpy Basic)
2. **Diese Woche:** Gehaltstrends-Datei manuell befüllen
3. **Nächste Woche:** Vera Research-Scan durchführen
4. **Übermorgen:** Freelance-Monitor Task erstellen

---

## 🔗 ABHÄNGIGKEITEN

Alle Outputs werden automatisch in bereits existente Dateien integriert:

```
Nina Scout → 02 Areas/Jobsuche.md (aktualisiert tägl.)
Vera Research → 02 Areas/Gefahrstoffe Wissen.md (aktualisiert wöchentl.)
Freelance Monitor → 01 Projects/Freelance Gefahrstoffe Aufbau/ (aktualisiert tägl.)
Karl Market Watch → 02 Areas/Finanzen-Trends.md (wie bisher)
```

---

---

## ✅ PRE-LAUNCH CHECKLISTE – NINA SCOUT (Phase 1)

**Vor dem Start Montag 08:00 muss folgendes erledigt sein:**

- [ ] Python 3.9+ installiert & im PATH
- [ ] JobSpy Modul installiert: `pip install jobspy`
- [ ] Script erstellt: `nina-daily-jobsearch.ps1` im Vault-Root
- [ ] Ordner erstellt: `02 Areas/Jobsuche-Archiv/`
- [ ] Windows Task erstellt & verifiziert
- [ ] **Test-Lauf durchgeführt** (mindestens 1x vor Montag)
- [ ] Erste Job-Datei kontrolliert (Format, Fehler)
- [ ] ARBEITSSTAND.md aktualisiert (Status: LIVE)

**🔴 STOPP-PUNKTE (Blocker):**
- Script produziert keine Jobs → Suchkriterien überprüfen
- Python/JobSpy Fehler → Installation verifizieren
- Windows Task läuft nicht → Pfade überprüfen, Rechte prüfen
- Output-Ordner nicht erreichbar → Permissions prüfen

---

## 🔄 ROLL-BACK PLAN (Falls Fehler)

**Problem:** Script läuft, aber Jobs sind falsch/leer/unbrauchbar

**Sofort-Maßnahmen:**
1. Windows Task deaktivieren:
   ```powershell
   schtasks /delete /tn "Nina Scout - Daily Jobsearch" /f
   ```

2. Script-Logs prüfen:
   ```powershell
   Get-EventLog -LogName System -Source "Nina*" -Newest 10
   ```

3. Manuell testen:
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\Admin\...\nina-daily-jobsearch.ps1"
   ```

4. JobSpy-API testen (Python):
   ```python
   import jobspy
   jobs = jobspy.scrape_jobs(
       site_name=["indeed"],
       search_term="Büro",
       location="Montabaur",
       results_wanted=5
   )
   print(jobs)
   ```

**Fallback-Plan:**
- Manuelle Jobsuche weiterhin möglich (wenn Task kaputt)
- Alte Job-Dateien bleiben erhalten (Archive nicht löschen)
- Vera Research & Freelance Monitor nicht beeinträchtigt

**Recovery-Zeit:** ~30 Minuten

---

## 📊 MONITORING DASHBOARD

**Was zu beobachten ist (täglich):**

| Indikator | Ziel | Alarm |
|-----------|------|-------|
| **Jobs pro Tag** | 5–20 Jobs | <3 oder >100 Jobs |
| **Match Quality** | 2–5 TOP Matches | 0 TOP Matches |
| **Script Runtime** | 2–5 Min | >10 Min (Timeout) |
| **Fehlerquote** | 0% | >10% Fehler |
| **File Creation** | Täglich neue .md | Keine Datei erstellt |
| **JobSpy API** | Funktionsfähig | Scraper-Fehler |

**Monitoring-Dateien:**
- ✅ `02 Areas/Jobsuche-Archiv/Jobs_*.md` (tägl. neue Datei)
- ✅ `02 Areas/Jobsuche/Gehaltstrends_2026.md` (tägl. aktualisiert)
- ✅ Windows Event Log: Suchstring "Nina"

**Wann intervenieren:**
1. 🔴 Keine Datei seit >24h → Script-Fehler
2. 🔴 Datei existiert, aber 0 Jobs → Suchkriterien-Problem
3. 🟡 >10% Fehler-Rate → API-Instabilität oder Netzwerk

**Tägliche Kontrolle (5 min):**
```powershell
# Dateibestand prüfen
ls "C:\Users\Admin\...\02 Areas\Jobsuche-Archiv\" -File | Sort -Last 3

# Windows Event Log
Get-EventLog -LogName System -Source "Nina*" -Newest 1
```

---

## 🚀 NEXT STEPS (SOFORT NACH DIESER SESSION)

1. ✅ Script in Vault erstellen (`nina-daily-jobsearch.ps1`)
2. ✅ Windows Task aufsetzen
3. ✅ Test-Lauf durchführen (heute noch!)
4. ✅ Ergebnisse überprüfen
5. ✅ Falls alles OK → Genehmigung für Montag 08:00 Uhr

---

**Status dieser Planung:** ✅ GENEHMIGT & BEREIT ZUR IMPLEMENTIERUNG  
**Implementierungs-Zeitraum:** Heute 2026-07-06 (vor 18:00 Uhr)  
**Launch:** Montag 2026-07-07 08:00 Uhr Berlin

*Dieses Dokument basiert auf Deep Research Findings & Best Practices 2026*
*Letzte Änderung: 2026-07-06 (Checkliste + Roll-Back + Monitoring hinzugefügt)*
