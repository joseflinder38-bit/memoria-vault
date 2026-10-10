# 📦 Memoria - Vault-Struktur & Inhalt

**Letztes Update:** 2026-07-03  
**Status:** ✅ Aktiv  
**Nutzer:** Josef Linder

---

## 📍 VAULT-HIERARCHIE (PARA-Methode)

```
Memoria (Vault-Root)
├── 📁 00 Inbox                    # Neue, unsortierte Notizen
│   └── 📄 Willkommen.md
│
├── 📁 01 Projects                 # Projekte mit Deadline & Ende
│   ├── 📁 Bewerbungen
│   │   ├── 📁 Firmen              # Eine .md pro Bewerbung
│   │   └── 📄 Bewerbungen - Übersicht.md
│   ├── 📁 Freelance Gefahrstoffe Aufbau
│   │   ├── 📁 Kunden              # Eine .md pro Kunde
│   │   └── 📄 Freelance Gefahrstoffe Aufbau.md
│   ├── 📄 (Weitere Projekte hier)
│   └── 📋 Lebenslauf_Josef_Linder.html
│
├── 📁 02 Areas                    # Laufende Verantwortungen (kein Ende)
│   ├── 📁 (Themen-Subordner)
│   ├── 📄 Beruf.md                # Karriere & Job-Planung
│   ├── 📄 Gefahrstoffe Wissen.md  # Domain-Expertise
│   └── 📄 Finanzen.md             # Persönliche & Freelance-Finanzen
│
├── 📁 03 Resources                # Referenzmaterial & Guides
│   ├── 📁 Gesetze & Verordnungen
│   ├── 📁 Vorlagen
│   ├── 📁 Tools & Software
│   └── 📋 (39 Dateien total)
│
├── 📁 04 Archive                  # Abgeschlossene/inaktive Items
│   ├── 📁 Projekte                # Beendete Projekte (Struktur erhalten)
│   └── 📄 (Archivierte Notizen)
│
├── 📁 05 Templates                # Obsidian Templates für Plugin
│   ├── 📄 Projekt-Template.md     # Für neue Projekte
│   ├── 📄 Daily-Note-Template.md  # Für tägliche Notizen
│   ├── 📄 Bewerbung-Template.md   # Für neue Bewerbungen
│   └── 📄 Gefahrstoff-Kunde-Template.md  # Für neue Kunden
│
├── 📁 06 Daily Notes              # Eine Datei pro Tag
│   ├── 📄 2026-06-26.md           # Tagesnotizen
│   ├── 📄 2026-06-27.md
│   ├── 📄 2026-06-28.md
│   ├── 📄 2026-06-29.md
│   ├── 📄 2026-06-30.md
│   ├── 📄 2026-07-01.md
│   ├── 📄 2026-07-02.md
│   ├── 📄 2026-07-03.md           # ← Heute
│   └── 📋 README.md
│
├── 📁 07 Agents                   # Custom Claude Code Agents
│   ├── 📋 (5 Dateien)
│   └── 📝 (Workflows, Skripte)
│
├── 📁 .claude                     # Claude Code Konfiguration
│   ├── 📄 settings.json           # 🆕 Daily Note SessionStart Hook
│   ├── 📄 create-daily-note.ps1   # 🆕 PowerShell Automation Script
│   └── 📄 daily-note-creation.log
│
├── 📁 .claudian                   # Custom Claudian Konfiguration
│   └── 📋 (Vault-spezifische Einstellungen)
│
├── 📁 .obsidian                   # Obsidian App Konfiguration
│   └── 📋 (Hotkeys, Plugins, Themes)
│
├── 📄 README.md                   # Vault-Übersicht & Anleitung
├── 📄 CLAUDE.md                   # Claude Code Anweisungen
├── 🌐 immobilien-dashboard.html   # 🆕 Immobilien-Investitionsplan (Basic)
└── 🌐 immobilien-invest-pro.html  # 🆕 Immobilien-Investment PRO (Full)
```

---

## 📊 STATISTIKEN

| Bereich | Dateien | Ordner | Status |
|---------|---------|--------|--------|
| **00 Inbox** | 1 | 0 | ⏳ Geleert regelmäßig |
| **01 Projects** | 3 | 4 | 🟢 Aktiv |
| **02 Areas** | 15 | 9 | 🟢 Aktiv |
| **03 Resources** | 39 | 11 | 🟢 Umfangreich |
| **04 Archive** | 1 | 0 | 📦 Inaktiv |
| **05 Templates** | 4 | 0 | 🟢 Komplett |
| **06 Daily Notes** | 9 | 0 | 🟢 Aktiv (tägliche Einträge) |
| **07 Agents** | 5 | 0 | 🟢 Custom Code |
| **TOTAL** | 77 | 24 | ✅ Healthy |

---

## 🎯 WICHTIGE DATEIEN

### Root Level
- **[[README.md]]** — Vault-Übersicht & PARA-Erklärung
- **[[CLAUDE.md]]** — Anweisungen für Claude Code (WICHTIG!)
- **[[immobilien-invest-pro.html]]** — 🆕 Professionelle Immobilien-Analyse

### Projekte
- **[[01 Projects/Bewerbungen/Bewerbungen - Übersicht.md]]** — Job-Application Tracking
- **[[01 Projects/Freelance Gefahrstoffe Aufbau/Freelance Gefahrstoffe Aufbau.md]]** — Consulting Business

### Areas (Daueraufgaben)
- **[[02 Areas/Beruf.md]]** — Karriere & Berufliche Entwicklung
- **[[02 Areas/Gefahrstoffe Wissen.md]]** — Domain-Expertise & Schulungen
- **[[02 Areas/Finanzen.md]]** — Persönliche & Geschäftsfinanzen

### Tägliche Notizen
- **[[06 Daily Notes/2026-07-03.md]]** — Heute (aktuelle Session)
- Vorherige Tage: 2026-06-26 bis 2026-07-02

---

## 🔧 AUTOMATION & TOOLS

### Daily Note Creation
- **Hook:** SessionStart (Claude Code)
  - 📄 Datei: `.claude/settings.json`
  - 📝 Skript: `.claude/create-daily-note.ps1`
  - ⏰ Trigger: Jedes Mal Claude startet

- **Windows Task Scheduler**
  - ⏰ Zeit: 06:00 Uhr täglich
  - 📝 Kommando: `pwsh.exe -NoProfile -ExecutionPolicy Bypass -File "...\create-daily-note.ps1"`

### Templates (Obsidian Plugin)
- `05 Templates/Projekt-Template.md` — Neue Projekte
- `05 Templates/Daily-Note-Template.md` — Neue Tagesnotiz
- `05 Templates/Bewerbung-Template.md` — Neue Bewerbung
- `05 Templates/Gefahrstoff-Kunde-Template.md` — Neue Kundenbeziehung

---

## 📝 INHALTS-ÜBERSICHT

### 01 Projects/Bewerbungen/
**Aktive Job-Bewerbungen:**
- Firma (Subordner): Eine `.md` pro Bewerbungsziel
- Tracking: Status, Deadline, Links zu Anschreiben
- Template: `Bewerbung-Template.md`

**Beispiel-Struktur einer Bewerbung:**
```markdown
---
firma: Unternehmen XYZ
position: Kaufmann für Büromanagement
status: In Bearbeitung
deadline: 2026-07-31
---

# Bewerbung: XYZ GmbH

## Details
- Position: ...
- Kontakt: ...
- Anschreiben: [[link]]

## Status
- [ ] Bewerbung gesendet
- [ ] Rückmeldung erhalten
```

### 01 Projects/Freelance Gefahrstoffe Aufbau/
**Aufbau des Consulting-Business:**
- Kunden (Subordner): Eine `.md` pro Kundenbeziehung
- Services: Gefahrstoffkataster, Betriebsanweisungen, Unterweisungen
- Template: `Gefahrstoff-Kunde-Template.md`

**Beispiel-Struktur eines Kunden:**
```markdown
---
kunde: Kundenname
branche: Industrie/Handwerk
leistungen: Gefahrstoffkataster
status: Aktiv
nächster_kontakt: 2026-07-15
---

# Kunde: XYZ KMU

## Firmendetails
- Branche: ...
- Kontakt: ...
- Mitarbeiterzahl: ...

## Services
- [x] Gefahrstoffkataster
- [ ] Betriebsanweisungen
- [ ] Schulung geplant
```

### 02 Areas/
**Daueraufgaben ohne Enddatum:**

**Beruf.md** — Karriereplanung
- Bewerbungsstrategie
- Interview-Vorbereitung
- Weiterbildungen

**Gefahrstoffe Wissen.md** — Domain-Expertise
- Gesetze & Verordnungen (GHS, ChemG, etc.)
- Best Practices
- Fallstudien

**Finanzen.md** — Finanzielle Planung
- Persönliches Budget
- Freelance-Einnahmen/Ausgaben
- Steuern & Versicherungen

### 03 Resources/
**Referenzmaterial (keine direkte Projekt-Bindung):**
- Gesetze & Verordnungen
- Vorlagen & Checklisten
- Tools & Software-Empfehlungen
- Branchenführer & Guides
- Schulungsmaterialien

### 06 Daily Notes/
**Tägliche Notizen mit Struktur:**

**Template-Felder:**
```markdown
## Prioritäten heute
- [ ] Priorität 1
- [ ] Priorität 2
- [ ] Priorität 3

## Notizen
(Gedanken, Erkenntnisse, Beobachtungen)

## Offene Punkte
- [ ] Follow-up notwendig
```

**Automatische Generierung:**
- ✅ SessionStart Hook (Claude Code)
- ✅ Windows Task Scheduler (06:00 Uhr)

---

## 🚀 NEUE TOOLS (Diese Session)

### 1. Daily Note Automation
- **Dateien:**
  - `.claude/settings.json` — Hook-Konfiguration
  - `.claude/create-daily-note.ps1` — PowerShell-Skript
- **Funktion:** Erstellt täglich um 6 AM + bei Claude-Start eine neue Daily Note

### 2. Immobilien-Dashboards
- **`immobilien-dashboard.html`** (Basic)
  - Einfache Eingabe & Vergleich
  - Finanzierung, Rendite, Cashflow
  - Speichern/Laden im Browser

- **`immobilien-invest-pro.html`** (Professional)
  - ✅ Mehrere Darlehen & KfW-Programme
  - ✅ Steuern & AfA (Abschreibung)
  - ✅ Szenario-Analyse (Best/Base/Worst/Crisis)
  - ✅ Professionelle KPIs (Cap Rate, DSCR, LTV, CoC)
  - ✅ Amortisationsplan
  - ✅ PDF-Reports & Excel-Export
  - ✅ Portfolio-Analyse & Rankings

---

## 📋 CONVENTIONS & BEST PRACTICES

### Dateibenennng
- **Projekte:** `Projekt-Name.md` oder `Projekt-Name/Unter-Note.md`
- **Bewerbungen:** `Bewerbungen/Firmen/Firmenname.md`
- **Kunden:** `Freelance.../Kunden/Kundenname.md`
- **Daily Notes:** `YYYY-MM-DD.md` (ISO 8601)
- **Tägliche-Notizen:** `06 Daily Notes/2026-07-03.md`

### Frontmatter
Alle strukturierten Notizen haben YAML Frontmatter:
```yaml
---
status: In Bearbeitung | Abgeschlossen | Archiviert
ziel: Klares Ziel beschreiben
deadline: YYYY-MM-DD
nächster_schritt: Nächste Action
tags: [tag1, tag2]
---
```

### Wikilinks
- **Internal:** `[[Dateiname]]` oder `[[Ordner/Dateiname]]`
- **Externe:** `[Text](https://url.de)`

### Archivierung
Abgeschlossene/inaktive Items:
1. Datei in `04 Archive/` verschieben
2. Ordnerstruktur beibehalten
3. Status in Frontmatter auf "Archiviert" ändern
4. Nichts löschen!

---

## 🎯 AKTUELLE AUFGABEN

### 🟢 Abgeschlossen
- ✅ Daily Note Automation (SessionStart + Task Scheduler)
- ✅ Immobilien-Investment Dashboards (Basic + Pro)
- ✅ Vault-Struktur dokumentiert

### 🟡 In Arbeit
- ⏳ Job-Bewerbungen (laufendes Tracking)
- ⏳ Freelance-Kundenaufbau
- ⏳ Gefahrstoff-Expertise erweitern

### 🔵 Geplant
- 📌 Weitere Immobilien in Dashboard hinzufügen
- 📌 Szenario-Analysen durchführen
- 📌 Finanzielle Planung der Freelance-Expansion

---

## 📞 KONTAKTINFOS

**Email:** joseflinder38@gmail.com  
**Location:** Westerwald, Rheinland-Pfalz, Deutschland  
**Profession:** Kaufmann für Büromanagement + Gefahrstoff-Spezialist

---

## 🔗 WICHTIGE LINKS & RESOURCES

### Interne Dokumentation
- [[README.md]] — Vault-Anleitung
- [[CLAUDE.md]] — Claude Code Instruktionen

### Externe Tools
- **Obsidian:** Daily Notes, Templates, Dataview
- **Windows Task Scheduler:** Tägliche Automatisierung
- **Claude Code:** AI-Automation & Skripte
- **Immobilien-Dashboards:** Investment-Analyse (lokal)

---

**Zuletzt aktualisiert:** 2026-07-03  
**Vault-Version:** 2.0 (mit Automation & Investment Tools)  
**Status:** ✅ Produktiv
