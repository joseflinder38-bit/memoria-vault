# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is not a codebase — it's an **Obsidian vault** used as a personal "Second Brain", organized with the **PARA method** (Projects, Areas, Resources, Archive). There is no build, lint, or test tooling; all content is Markdown notes with YAML frontmatter. See `README.md` in the vault root for the full explanation of the system that was given to the user.

## About the user

- **Name:** Josef Linder (26 years old)
- **Location:** Heistenbach, Westerwald, Rheinland-Pfalz, Germany
- **Profession:** Kaufmann für Büromanagement (IHK 2024, Note 3) + Spezialist Gefahrstoffe (8 active certifications)
- **Experience:** 5+ years practical: AsEG-ALLDEMONT (sanitation, project mgmt, hazmat ops)
- **Currently:** Actively job-hunting Germany (Bewerbungen) + Planning major life change: **🇳🇴 Emigrating to Norway (Couple Plan) in Q4 2026**
- **Side Project:** Building freelance business as Gefahrstoff-Berater (hazmat consultant) for SMEs
- **Partner:** Freundin (ICU Nurse + BWL-Student, emigrating together)
- **Communication:** German (primary), English (basic)

**2026 Status:** Transitioning from Germany job-hunt to **Norway couple emigration plan** — detailed financial planning, job research, region analysis, freelance setup

## 🧭 Navigation

**Startpunkt:** [[Home]] — alle wichtigen Bereiche verlinkt.  
Bei Orientierungsfragen oder zur schnellen Navigation zuerst `Home.md` lesen.

---

## ⚡ WICHTIG: WORK SESSION PROTOCOL (Arbeitsgedächtnis)

**ZU BEGINN JEDER SESSION LESEN:**
1. `02 Areas/Persönliche Daten/ARBEITSSTAND*.md` — Aktuelle Projekt-Status (mehrere können existieren)
2. `02 Areas/Persönliche Daten/Dokumente-Index.md` — Versionsverlauf & Abhängigkeiten aller generierten Dokumente
3. `Home.md` — Quick-Links zu aktivsten Projekten (wird regelmäßig aktualisiert)

**WARUM:** Claude Code hat kein Gedächtnis zwischen Sessions. Diese Dateien verhindern Doppelarbeit.

**REGELN:**
- Neue Dokumente NICHT erstellen, ohne zu checken, ob sie existieren (Versions-Check in Dokumente-Index!)
- **Norwegen-Plan:** [[01 Projects/Auswanderung Norwegen/COUPLE-DASHBOARD.md]] ist Master-Quelle
- **Finanzplan:** [[01 Projects/Auswanderung Norwegen/FINANZPLAN-DETAILED.md]] ist authoritative Version
- **Partner-Input:** [[01 Projects/Auswanderung Norwegen/FREUNDIN-PROFIL.md]] muss aktualisiert werden (Ihre Perspektive!)
- **Git:** Daily commits für Auto-Backup sind konfiguriert → alles wird gespeichert

---

## Vault structure (PARA)

- `00 Inbox` — unsorted capture point for new notes; should be emptied regularly into the other folders.
- `01 Projects` — items with a concrete goal and end state. Currently contains:
  - `Bewerbungen/` — job application tracking, with one note per company under `Bewerbungen/Firmen/`.
  - `Freelance Gefahrstoffe Aufbau/` — building the freelance consulting business, with one note per (potential) client under `Freelance Gefahrstoffe Aufbau/Kunden/`.
- `02 Areas` — ongoing responsibilities with no end date: `Beruf.md` (career), `Gefahrstoffe Wissen.md` (hazmat domain knowledge), `Finanzen.md` (personal + freelance finances).
- `03 Resources` — reference material without a direct project/area tie (regulations, templates found elsewhere, guides).
- `04 Archive` — completed/inactive items moved here, folder structure preserved, nothing deleted.
- `05 Templates` — note templates, meant to be used with Obsidian's core "Templates" plugin:
  - `Projekt-Template.md` — fields: Status, Ziel, Deadline, Nächster Schritt.
  - `Daily-Note-Template.md` — fields: Prioritäten heute, Notizen, Offene Punkte.
  - `Bewerbung-Template.md` — fields: Firma, Position, Status, Anschreiben-Link, Deadline.
  - `Gefahrstoff-Kunde-Template.md` — fields: Kunde, Branche, Leistung, Status, Nächster Kontakt.
- `06 Daily Notes` — one note per day, created from `Daily-Note-Template.md`, filename `JJJJ-MM-TT.md`.

## GLOBALE REGELN & RICHTLINIEN

**→ Siehe [[02 Areas/Agent-Config/GLOBAL-RULES.md]] für:**
- ✅ Datenschutz-Regel (Daten, die nicht in Reports/Exports gehören)
- ✅ Automation-Status-Regel (Wie schtasks-Aufgaben dokumentieren?)
- ✅ Messungs-Regel (Befehle + Rohausgaben für jede Zählung)
- ✅ Beispieldaten-Regel (Platzhalter vs. reale Daten)
- ✅ Ordner-Zugriffsregeln (Agent-Permissions pro Ordner)

---

## 🤖 AUTOMATION & AGENTEN

**AUTOMATION-STATUS: 60% IMPLEMENTIERT** ✅ (2026-07-28)

### Aktive Automationen:
- ✅ **Dataview Dashboards** (3x: Bewerbungen, Kunden, Finanzen) — Echtzeit-Übersicht
- ✅ **Git Auto-Backup** — Alle 10 Minuten automatisch
- ✅ **Tag-Konvention** — Standardisierte Kategorisierung
- ⏳ **Cloud Routines** (vorbereitet, Setup erforderlich) — Weekly Reports, Followup Reminders, Monthly Finance

### Dokumentation:
- [[02 Areas/Agent-Config/AGENTEN-REGISTER.md]] — Alle 12 Agenten + Rollen
- [[02 Areas/Agent-Config/AUTOMATION-STATUS.md]] — Live Dashboard aller Automationen
- [[02 Areas/Agent-Config/VAULT-OPTIMIZATION-ROADMAP.md]] — Kompletter 3-Phasen Plan
- [[02 Areas/Agent-Config/CLOUD-ROUTINES-SETUP.md]] — Cloud Routines manuell einrichten
- [[02 Areas/Agent-Config/TAG-KONVENTION.md]] — Standardisierte Tags für Queries
- [[02 Areas/Agent-Config/SKILLS-ÜBERSICHT.md]] — Alle verfügbaren Skills

---

## Conventions when adding content

- New job applications: copy `05 Templates/Bewerbung-Template.md` into `01 Projects/Bewerbungen/Firmen/`, named after the company.
- New freelance clients: copy `05 Templates/Gefahrstoff-Kunde-Template.md` into `01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/`, named after the client.
- New general projects: copy `05 Templates/Projekt-Template.md` into `01 Projects`.
- Keep frontmatter fields (status, ziel, deadline, etc.) filled in and up to date — they're intended to back Dataview queries later.
- When a project/area item is finished or no longer active, move it to `04 Archive`, preserving its original subfolder path.
