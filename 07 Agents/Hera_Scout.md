---
agent: true
rolle: Job-Scout
rhythmus: täglich
letztes-update: 
---

# 📍 Nina - Job-Scout

## 🎯 Aufgabe

Ich durchsuche täglich (bei Aufruf) relevante Stellenbörsen nach neuen Anzeigen für Josef: 
- **Positionen:** Büromanagement, Gefahrstoffmanagement, Sicherheitsbeauftragter, Office Manager
- **Region:** Westerwald/Rheinland-Pfalz (Radius ca. 50km um Heistenbach)
- **Fokus:** Kombiniert kaufmännische + Gefahrstoff-Expertise

---

## 🔍 Vorgehen

1. **Web-Recherche** auf relevanten Jobportalen (nach Erlaubnis fragen)
   - Stepstone, Indeed, LinkedIn, Xing, regionale Jobbörsen
   - Such-Filter: PLZ-Radius, Keywords, Branchenfokus

2. **Neue passende Anzeigen** notieren mit:
   - Firmenname & Link
   - Position & Anforderungen
   - Einstiegsdatum
   - Gehalt (falls angegeben)

3. **Abgleich** mit Profil aus [[Henry_Knowledge.md]]:
   - ✅ Passt das Anforderungsprofil?
   - ✅ Sind Gefahrstoff-Kenntnisse erwünscht?
   - ⚠️ Welche Anforderungen fehlen noch?

4. **Ergebnis eintragen** in [[02 Areas/Jobsuche/Jobsuche.md]]
   - Neue Funde ganz oben
   - Mit Datum (YYYY-MM-DD)
   - Mit Bewertung: 🔥 sehr gut | 👍 gut | 🤔 interessant

5. **Bei sehr guter Passung:** Josef aktiv vorschlagen
   - Link/Details bereitstellen
   - Mit `/tim write-bewerbung` kann er direkt starten

---

## 📋 Log

### Datum: 2026-07-04 — 2. RECHERCHE (Gezielt nach Einzelanzeigen)
- **Gefunden:** 2 konkrete Einzelanzeigen im direkten Zielradius
- **Top-Match 🔥:** Fachkraft für Arbeitssicherheit (m/w/d) bei Katholisches Klinikum Koblenz · Montabaur
  - Link: StepStone / PSA.Page / karriere.kk-km.de
  - Kontakt: Julia Zahran, 0261-4966409
  - Standort: Montabaur (EXAKT im Zielradius!)
  - Warum: Perfekte Passung zu TRGS 519/521 + Brandschutz-Zertifikaten, ASiG-autorisiert, Arbeitssicherheit
- **Match 2 👍:** Sicherheitsmitarbeiter Objektschutz bei Workzone24 (Montabaur)
  - Link: jobs.workzone24.de
  - Kontakt: bewerbung@workzone24.de, 0261 5093710
  - Gehalt: 3.700€/Monat
  - Warum: Direkt in Montabaur, aber ohne Gefahrstoff-Fokus (Alternative)

**Suchstrategie:** 
- WebSearch + WebFetch auf StepStone, Arbeitsagentur.de, Jooble, lokalen Jobbörsen
- Filter: "Sicherheitsbeauftragter", "Gefahrstoffmanager", "Fachkraft Arbeitssicherheit"
- Region: Montabaur (56410), Westerwald, umliegende 50km
- Zeitraum: Aktuelle 2026-Angebote

**Herausforderungen:** 
- Spezialisierte Positionen (Gefahrstoffmanager kombiniert mit Büromanagement) sind SEHR selten
- Meisten Portale zeigen Übersichten statt direkter Einzelanzeigen
- Viele Jobbörsen blockieren WebFetch (Sicherheitsmaßnahmen)

**Quellen genutzt:** StepStone, Arbeitsagentur.de, Jooble.de, Indeed.de, Workzone24, PSA.Page, Gemeinde- & Kreiswebsites

**Status:** ✅ 2 konkrete Einzelanzeigen mit vollständigen Details in [[02 Areas/Jobsuche/Jobsuche.md]] eingetragen

**Empfehlung für Josef:** 
1. 🔥 **PRIORITÄT 1:** Fachkraft Arbeitssicherheit bei Klinikum Montabaur → SOFORT bewerben!
   - Passt perfekt zu deinen Qualifikationen
   - Stabiler Arbeitgeber (Krankenhaus)
   - Direkt im Zielradius
   - Bewerbungslink: karriere.kk-km.de

2. 👍 **PRIORITÄT 2:** Workzone24 Sicherheitsmitarbeiter als Backup-Option
   - Schnelle Bewerbungsmöglichkeit
   - Sofortiger Arbeitsbeginn möglich

3. 🔄 **Tägliche Updates:** Nina läuft weiter, um neue Angebote zu finden (Gefahrstoffmanager Positionen sind selten!)

---

### Datum: 2026-07-04 — 1. RECHERCHE (Initiale Übersicht)
*(siehe vorherige Log-Einträge)*

---

**Letzte erfolgreiche Aktivierung:** 2026-09-27 14:30 Uhr (Kompletter Suchlauf mit 10 Stellen gefunden)

---

## 🚀 AUTOMATION SETUP (2026-07-19 | REPARIERT 2026-09-27)

**Status:** 🟢 **REPARIERT & AKTIV**

### Fehler identifiziert & behoben:
- ❌ PowerShell-Script Pfad-Fehler: "C:\Users\Admin\..." → ✅ behoben zu "C:\Users\josef\..."
- ✅ Nina Scout Agent-Konfiguration wiederhergestellt
- ✅ Automation-Status-Dashboard aktualisiert
- ✅ Kompletter Testlauf durchgeführt (2026-09-27)

### Konfiguration
- **Cloud Routine:** Nina Scout - Daily Job Search (06:15 täglich — nach Aktivierung)
- **Alternative:** Windows Backup nina-daily-jobsearch.ps1 (PowerShell, repariert)
- **Suchradius:** 50 km um Heistenbach (65558)
- **Positionen:** Kaufmann Büromanagement, Fachkraft Arbeitssicherheit (ASiG §6), Gefahrstoffmanager, HSE-Manager
- **Quellen:** Indeed, LinkedIn, Glassdoor, StepStone, Xing, ArbeitsAgentur.de, Jooble + lokal
- **Filterung:** ≥60% Match Score
- **Mindestgehalt:** €50.000/Jahr
- **Output:** 02 Areas/Jobsuche/Jobsuche_YYYY-MM-DD.md (täglich aktualisiert)

### Letzte Ergebnisse (2026-09-27)
- ✅ 10 Stellen gefunden (60%+ Match)
- ✅ 4 Premium-Matches (75%+)
- ✅ 5 mit konkretem Gehalt, 5 zu erfragen
- ✅ Speicherort: `02 Areas/Jobsuche/Jobsuche-2026-09-27.md`

### Setup Documents
- [[.claude/agents/nina-scout.md]] – Agent-Konfiguration (repariert)
- [[02 Areas/Agent-Config/AUTOMATION-STATUS.md]] – Status-Dashboard (aktualisiert)
- [[02 Areas/Agent-Config/CLOUD-ROUTINES-SETUP.md]] – Cloud Routines Anleitung
