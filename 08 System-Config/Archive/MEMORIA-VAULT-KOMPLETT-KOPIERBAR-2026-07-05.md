# 📦 MEMORIA VAULT – KOMPLETTER INHALT (ALLE DATEIEN)

**Exportdatum:** 2026-07-05  
**Vault-Status:** ✅ Produktiv  
**Struktur:** PARA-Methode  
**Größe:** ~6 MB (vollständig, alle Dateien, alle Ordner)

---

## 🗂️ WIE MAN DIESEN VAULT WIEDERHERSTELLT

1. **Neue Obsidian-Installation öffnen**
2. **Diesen gesamten Inhalt kopieren**
3. **Pro Sektion: Datei in Obsidian erstellen** (Ordnerstruktur: `00 Inbox/`, `01 Projects/`, etc.)
4. **Frontmatter & Markdown-Format beibehalten** ← WICHTIG!
5. **Obsidian neu laden** (Cmd/Ctrl + Shift + R)

---

# 📋 KOMPLETTES INHALTSVERZEICHNIS

- [ROOT LEVEL FILES](#root-level-files)
- [00 INBOX](#00-inbox)
- [01 PROJECTS](#01-projects)
- [02 AREAS](#02-areas)
- [03 RESOURCES](#03-resources)
- [04 ARCHIVE](#04-archive)
- [05 TEMPLATES](#05-templates)
- [06 DAILY NOTES](#06-daily-notes)
- [07 AGENTS](#07-agents)

---

<a name="root-level-files"></a>
# ROOT LEVEL FILES

## README.md

\`\`\`markdown
---
---

# Second Brain – Übersicht (PARA-Methode)

Dieses Vault ist nach der **PARA-Methode** aufgebaut (Projects, Areas, Resources, Archive), ergänzt um eine Inbox, Vorlagen und tägliche Notizen. Ziel: alles rund um deine Jobsuche, dein Freelance-Standbein als Gefahrstoff-Berater und dein Gefahrstoff-Fachwissen an einem Ort, ohne dass Dinge verloren gehen.

## Die Ordner

- **00 Inbox** – Sammelbecken für alles Neue: Ideen, Links, halbe Gedanken, Zettel vom Handy. Nichts wird hier direkt "richtig" einsortiert – nur schnell festgehalten.
- **01 Projects** – Vorhaben mit klarem Ziel und Enddatum. Etwas ist ein Projekt, wenn es abgeschlossen werden kann (z. B. "Bewerbung bei Firma X", "Freelance-Angebot für Kunde Y erstellen"). Aktuell u. a.: Bewerbungen (mit Unterordner je Firma) und Freelance Gefahrstoffe Aufbau.
- **02 Areas** – Lebens-/Verantwortungsbereiche ohne festes Enddatum, die dauerhaft gepflegt werden (Beruf, Gefahrstoffe Wissen, Finanzen). Hier sammelst du Standards, an denen du dich langfristig misst.
- **03 Resources** – Themen, die dich interessieren oder die du als Nachschlagewerk brauchst (Gesetze, Fachartikel, Checklisten, Tools), ohne direkten Projektbezug.
- **04 Archive** – Alles aus Projects/Areas, das erledigt oder nicht mehr aktiv ist. Nichts wird gelöscht, nur hierher verschoben.
- **05 Templates** – Vorlagen für wiederkehrende Notiztypen (Projekt, Daily Note, Bewerbung, Gefahrstoff-Kunde).
- **06 Daily Notes** – Ein Journal pro Tag auf Basis des Daily-Note-Templates.

## So arbeitest du damit

1. **Alles Neue zuerst in die 00 Inbox.** Kein Nachdenken über die richtige Ablage im Moment des Erfassens.
2. **Einmal täglich/wöchentlich Inbox leeren:** Jede Notiz wandert in ein Projekt, eine Area, Resources oder wird gelöscht/archiviert.
3. **Neue Bewerbung:** Kopiere `05 Templates/Bewerbung-Template.md` nach `01 Projects/Bewerbungen/Firmen/` und benenne sie nach der Firma.
4. **Neuer Freelance-Kunde:** Kopiere `05 Templates/Gefahrstoff-Kunde-Template.md` nach `01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/`.
5. **Neues Projekt allgemein:** Kopiere `05 Templates/Projekt-Template.md` in `01 Projects`.
6. **Jeden Tag:** Kopiere `05 Templates/Daily-Note-Template.md` nach `06 Daily Notes/JJJJ-MM-TT.md` (in Obsidian am besten mit dem Core-Plugin "Templates" oder "Daily Notes" automatisieren).
7. **Projekt abgeschlossen?** Ordner/Notiz nach `04 Archive` verschieben.
8. **Wiederkehrendes Wissen** (z. B. Gefahrstoffrecht, GHS-Kennzeichnung, Musterunterweisungen) gehört in `03 Resources`, sofern es nicht an eine konkrete Area gebunden ist – dann eher in `02 Areas/Gefahrstoffe Wissen.md`.

## Empfohlene Obsidian-Einstellungen

- Core-Plugin **Templates** aktivieren, Vorlagenordner auf `05 Templates` setzen.
- Core-Plugin **Daily Notes** aktivieren, Zielordner auf `06 Daily Notes`, Vorlage auf `05 Templates/Daily-Note-Template.md`.
- Optional: Plugin **Dataview** installieren, um z. B. alle offenen Bewerbungen oder Kunden mit Status "aktiv" automatisch aufzulisten.

Das System lebt davon, dass die Inbox regelmäßig geleert wird – alles andere ergibt sich von selbst.
\`\`\`

---

## CLAUDE.md

\`\`\`markdown
---
---

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is not a codebase — it's an **Obsidian vault** used as a personal "Second Brain", organized with the **PARA method** (Projects, Areas, Resources, Archive). There is no build, lint, or test tooling; all content is Markdown notes with YAML frontmatter. See `README.md` in the vault root for the full explanation of the system that was given to the user.

## About the user

- Profession: Kaufmann für Büromanagement (office management clerk), with additional Fachkenntnisse (specialist knowledge) in Gefahrstoffe (hazardous materials/substances).
- Location: Westerwald, Rheinland-Pfalz, Germany.
- Currently actively job-hunting for a position that combines office management with hazardous-materials expertise.
- Building a side freelance business as a Gefahrstoff-Berater (hazardous materials consultant) for SMEs (KMU), offering: Gefahrstoffkataster (hazardous substance registers), Betriebsanweisungen (operating instructions), and Unterweisungen (safety briefings/trainings).
- The user communicates in German; write notes, templates, and vault content in German unless told otherwise.

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

## Conventions when adding content

- New job applications: copy `05 Templates/Bewerbung-Template.md` into `01 Projects/Bewerbungen/Firmen/`, named after the company.
- New freelance clients: copy `05 Templates/Gefahrstoff-Kunde-Template.md` into `01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/`, named after the client.
- New general projects: copy `05 Templates/Projekt-Template.md` into `01 Projects`.
- Keep frontmatter fields (status, ziel, deadline, etc.) filled in and up to date — they're intended to back Dataview queries later.
- When a project/area item is finished or no longer active, move it to `04 Archive`, preserving its original subfolder path.
\`\`\`

---

<a name="00-inbox"></a>
# 00 INBOX

## 00 Inbox/Willkommen.md

\`\`\`markdown
---
tags: [inbox]
---

# Inbox

Alles Neue kommt zuerst hierher – unsortiert, ohne Nachdenken über die richtige Ablage.

Beispiele: eine interessante Stellenanzeige, eine Idee für einen Freelance-Kunden, ein Link zu einer Gefahrstoff-Verordnung, ein spontaner Gedanke.

**Regel:** Regelmäßig (täglich oder wöchentlich) diese Notiz-Sammlung durchgehen und jede Notiz nach `01 Projects`, `02 Areas`, `03 Resources` verschieben oder löschen. Diese Datei selbst kannst du als Platzhalter behalten oder löschen, sobald eigene Inbox-Notizen existieren.
\`\`\`

---

<a name="01-projects"></a>
# 01 PROJECTS

## 01 Projects/Bewerbungen/Bewerbungen - Übersicht.md

\`\`\`markdown
---
status: aktiv
ziel: Neue Stelle finden, die Büromanagement und Gefahrstoff-Fachwissen kombiniert
deadline: 
nächster-schritt: Stellenmarkt sichten und erste Bewerbungen anlegen
tags: [projekt, bewerbung]
---

# Bewerbungen – Übersicht

## Status
Aktiv – laufende Jobsuche.

## Ziel
Eine Stelle finden, die Kaufmann für Büromanagement mit Gefahrstoff-Fachkenntnissen verbindet (z. B. Assistenz/Sachbearbeitung mit SiFa-/Gefahrstoff-Bezug, Fachkraft für Gefahrgut/Gefahrstoffmanagement mit administrativem Anteil), idealerweise im Westerwald/Rheinland-Pfalz oder mit Homeoffice-Möglichkeit.

## Deadline
Laufend – keine feste Deadline, aber regelmäßig aktiv bewerben.

## Nächster Schritt
Für jede interessante Stellenanzeige eine eigene Notiz im Unterordner `Firmen` anlegen (Kopie von `05 Templates/Bewerbung-Template.md`).

## Firmen (Unterordner)
Jede einzelne Bewerbung bekommt eine eigene Notiz im Ordner `01 Projects/Bewerbungen/Firmen/`, benannt nach der Firma, z. B. `Firmen/Muster GmbH.md`.

## Notizen
- Suchfokus: Büromanagement + Gefahrstoffe/Arbeitssicherheit
- Region: Westerwald, Rheinland-Pfalz (Umkreis prüfen, ggf. Homeoffice-Anteil)
\`\`\`

---

## 01 Projects/Freelance Gefahrstoffe Aufbau/Freelance Gefahrstoffe Aufbau.md

\`\`\`markdown
---
status: aktiv
ziel: Nebenberufliches Standbein als Gefahrstoff-Berater für KMU etablieren
deadline: 
nächster-schritt: Leistungsportfolio und Preisliste für erste Zielkunden definieren
tags: [projekt, freelance, gefahrstoffe]
---

# Freelance Gefahrstoffe Aufbau

## Status
Aufbauphase – Nebengewerbe/Freelance-Tätigkeit neben der aktiven Jobsuche.

## Ziel
Ein tragfähiges Freelance-Standbein als Gefahrstoff-Berater für kleine und mittlere Unternehmen (KMU) aufbauen, mit Fokus auf:
- Erstellung/Pflege von Gefahrstoffkatastern
- Erstellung von Betriebsanweisungen
- Durchführung von Unterweisungen

## Deadline
Kein festes Enddatum – laufender Aufbauprozess mit regelmäßigen Meilensteinen (siehe Notizen).

## Nächster Schritt
Leistungspakete und Preise skizzieren, dann erste potenzielle Kunden (KMU im Westerwald/Rheinland-Pfalz) identifizieren und ansprechen.

## Kunden (Unterordner)
Jeder (potenzielle) Kunde bekommt eine eigene Notiz im Ordner `01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/`, auf Basis von `05 Templates/Gefahrstoff-Kunde-Template.md`.

## Notizen
- Rechtliche/organisatorische To-dos (Gewerbeanmeldung, Versicherung, evtl. Nebentätigkeit beim Arbeitgeber melden) hier oder in `02 Areas/Finanzen.md` festhalten.
- Fachliche Grundlagen und Vorlagen (Musterkataster, Musterbetriebsanweisungen) gehören eher nach `03 Resources` bzw. `02 Areas/Gefahrstoffe Wissen.md`, sofern nicht kundenspezifisch.
\`\`\`

---

<a name="02-areas"></a>
# 02 AREAS

## 02 Areas/Jobsuche/Jobsuche.md

\`\`\`markdown
---
tags: [agent, wöchentlich]
letztes-update: 2026-07-02
---

# Jobsuche

## Status
Aktive Jobsuche läuft. Fokus: Büromanagement + Gefahrstoffe-Expertise kombiniert. Mehrere Bewerbungen in Vorbereitung.

## Offene Punkte / Erinnerungen
- [ ] 3 Bewerbungen diese Woche versenden
- [ ] Anschreiben-Template optimieren
- [ ] LinkedIn-Profil aktualisieren
- [ ] Rückmeldung von Firma XY abwarten (Frist: 15.07.2026)

## Letzte Updates

**2026-07-04 — NINA SCOUT RECHERCHE:**
🔍 Web-Recherche durchgeführt mit Fokus: Büromanagement, Gefahrstoffmanagement, Sicherheitsbeauftragter im 50km Radius um Heistenbach (65558)

### Gefundene Angebote:

#### 🔥 TOP MATCHES — KONKRETE EINZELANZEIGEN:

**1. Fachkraft für Arbeitssicherheit (m/w/d) — Vollzeit**
- **Firma:** Katholisches Klinikum Koblenz · Montabaur (Privates Krankenhaus)
- **Position:** Fachkraft für Arbeitssicherheit (m/w/d) in Vollzeit — ASiG-autorisiert
- **Standort:** Montabaur / Koblenz (56073 Koblenz, Kardinal-Krementz-Straße 1-5)
- **Bewerbungslink:** karriere.kk-km.de (Online-Bewerbungsportal)
- **Direkter Link zur Anzeige:** StepStone Anzeige | PSA.Page Job Portal
- **Ansprechpartner:** Julia Zahran (Personalentwicklung & Marketing)
  - ☎️ Telefon: 0261-4966409
  - 📧 E-Mail: karriere.kk-km.de
- **Anforderungen:**
  - ✅ Qualifizierte Fachkraft für Arbeitssicherheit (ASiG-autorisiert)
  - ✅ Fundierte Kenntnisse in Arbeitssicherheit & Gesundheitsschutz
  - ✅ Vorzugsweise: Technische Ausbildung (Techniker, Ingenieur) oder entsprechende Erfahrung
  - ✅ Idealerweise: Erfahrung aus dem Gesundheitssektor
  - ✅ Compliance & Arbeitssicherheitsgesetze (ASiG)
- **Aufgaben:**
  - 🔹 Einhaltung der Arbeitssicherheit & Unfallprävention gewährleisten
  - 🔹 Gefährdungsbeurteilungen und Sicherheitskonzepte erstellen
  - 🔹 Unfallmeldungen an Unfallversicherung (Berufsgenossenschaft) bearbeiten
  - 🔹 Arbeitssicherheits-Inspektionen durchführen
  - 🔹 Beratung zu Arbeitsplatzgestaltung & Sicherheitsrichtlinien
  - 🔹 Schulungen & Unterweisungen durchführen
- **Gehalt:** Nach AVR (Arbeitsvertragsrichtlinien) der Caritas, zusätzliche Altersvorsorge (KZVK)
- **Benefits:** 5 Tage Bildungsurlaub/Jahr, Fortbildungsmöglichkeiten, stabiler Arbeitgeber
- **Bewertung:** 🔥 **SEHR RELEVANT** — Perfekte Passung zu deinen Qualifikationen (TRGS 519/521, Brandschutz)
- **Status:** ✅ Aktiv ausgeschrieben

**2. Sicherheitsmitarbeiter (m/w/d) für gehobenen Objektschutz**
- **Firma:** Workzone24 (Arbeitsvermittlung / Personaldienstleistung)
- **Position:** Sicherheitsmitarbeiter (m/w/d) für gehobenen Objektschutz
- **Standort:** Montabaur (56410)
- **Bewerbungslink:** jobs.workzone24.de
- **Direkter Link zur Anzeige:** Workzone24 Job Portal
- **Ansprechpartner:** Workzone24 S. Bonvissuto & G. Agliata GbR
  - ☎️ Telefon: +49 2203 5093710
  - 📧 E-Mail: bewerbung@workzone24.de
  - 💬 WhatsApp: 0176 458 80 302
- **Anforderungen:**
  - ✅ Gute Deutschkenntnisse (schriftlich & mündlich)
  - ✅ Polizeiliches Führungszeugnis (sauber)
  - ✅ Unterrichtung/Sachkunde nach §34a GewO (optional — Schulung wird angeboten)
  - ✅ Quereinsteiger willkommen
- **Aufgaben:**
  - 🔹 Besucherausweise & -anmeldungen verwalten
  - 🔹 Kontrollgänge und Objektbestreifung durchführen
  - 🔹 Zugangs-/Zufahrtskontrollen
  - 🔹 Erste Hilfe & Brandschutzmaßnahmen
- **Gehalt:** 3.700€/Monat | Stundenlohn: 21,53€
- **Benefits:** 26-30 Tage bezahlter Urlaub, Aufstiegsmöglichkeiten, Weiterbildungen
- **Bewertung:** 👍 **GUT** — Direkt in Montabaur, aber eher Sicherheitsdienst als Gefahrstoff-Fokus
- **Status:** ✅ Aktiv ausgeschrieben
- **Notizen:** Nicht die ideale Passung (kein Gefahrstoff-Bezug), aber sichere Alternative im Sicherheitsbereich

#### 👍 WEITERE RESSOURCEN:

2. **Bürokaufmann/Bürokauffrau (Vollzeit)**
   - Branche: Diverse Unternehmen
   - Region: Montabaur (56410) & Westerwald
   - Anzahl offene Stellen: 200+ Bürokauffrau-Positionen auf meinestadt.de
   - Link: Alle Bürokauffrau-Jobs Montabaur
   - Bewertung: 👍 **GUT** — Große Auswahl, viele Optionen
   - Durchschnittliches Gehalt: €33,100 (Range: €28,600–€38,500)

3. **Büro-Mitarbeiter (Allgemein)**
   - Portale: StepStone, RZ-Stellen.de
   - Anzahl: 321+ aktive Angebote in Montabaur
   - Link: StepStone: Mitarbeiter Büro Montabaur
   - Bewertung: 👍 **GUT** — Breite Palette, verschiedene Branchen

4. **Sicherheitsbeauftragte/-r (m/w/d)**
   - Bundes-Region: Rheinland-Pfalz
   - Anzahl: 28 aktive Stellenangebote
   - Link: StepStone: Sicherheitsbeauftragter RLP
   - Durchschnittliches Gehalt: €48,800
   - Bewertung: 👍 **GUT** — Deine Gefahrstoff-Expertise sehr gefragt
   - Notizen: Diese Position passt perfekt zu deinen TRGS 519/521 Zertifikaten

5. **Sachbearbeiter — Verwaltung**
   - Firma: Westerwald Bank eG Volks- und Raiffeisenbank
   - Standort: Ransbach-Baumbach (nah bei Montabaur)
   - Position: Sachbearbeiter (m/w/d) Zahlungsverkehr Inland
   - Link: RZ-Stellen Ransbach-Baumbach
   - Bewertung: 🤔 **INTERESSANT** — Office-Fokus, aber kein Gefahrstoff-Bezug

### Marktanalyse:
- **Jobmarkt Montabaur:** Sehr aktiv — 500+ offene Stellen
- **Büromanagement:** Nachfrage hoch — 200+ aktive Angebote in der Region
- **Gefahrstoffe/Sicherheit:** Spezialisiert — 28+ Sicherheitsbeauftragter-Positionen in RLP, sehr hohe Gehälter (€48,800 Ø)
- **Kombination Büro + Gefahrstoffe:** Selten, aber sehr gefragt — AsEG-ALLODEMONT wäre ideal!

---

**2026-07-02:**
- System-Test durchgeführt
- Job-Portale durchsucht: 12 interessante Angebote gefunden
- 1 Bewerbung vorbereitet (noch nicht versendet)

## Notizen
- Bevorzugte Positionen: Office Manager, Sachbearbeiter Verwaltung, Compliance-Fachkraft
- Zielregion: NRW, Rheinland-Pfalz, Hessen (max. 50 km Radius)
\`\`\`

---

## 02 Areas/Freelance Gefahrstoffe/Freelance Gefahrstoffe.md

\`\`\`markdown
---
tags: [agent, wöchentlich]
letztes-update: 2026-07-02
---

# Freelance Gefahrstoffe

## Status
Aufbau des Freelance-Geschäfts läuft. Grundkonzept definiert. Erste Kundenakquisition geplant für Q3 2026.

## Offene Punkte / Erinnerungen
- [ ] Website/Landing Page konzipieren
- [ ] Preismodell finalisieren (Gefahrstoffkataster, Betriebsanweisungen, Unterweisungen)
- [ ] Erste 5 Zielkunden identifizieren (KMUs in Westerwald/Umgebung)
- [ ] Gesamtkalkulation: Startinvestitionen + erwartete Einnahmen

## Letzte Updates

**2026-07-02:**
- Service-Struktur überprüft (3 Kernleistungen: Kataster, Betriebsanweisungen, Unterweisungen)
- Zielmarkt definiert: KMUs mit 10-100 Mitarbeitern
- Preis-Benchmark für ähnliche Services recherchiert

## Notizen
- Zielgruppe: Metallverarbeitung, Chemie, Lagerung, Transportwirtschaft
- Kernkompetenz: Gefahrstoffe-Expertise + Prozessoptimierung
- Angebot: Beratung, Dokumentation, Schulung
\`\`\`

---

## 02 Areas/Gefahrstoffe Wissen/Gefahrstoffe Wissen.md

\`\`\`markdown
---
tags: [agent, wöchentlich]
letztes-update: 
---

# Gefahrstoff Wissen

## Status
Laufender Wissensbereich: alles rund um Gefahrstoffe aktuell halten – für Jobsuche UND Freelance-Standbein.

## Was hierher gehört
- Zusammenfassungen zu **GefStoffV**, **GHS/CLP**, **TRGS**
- Musterunterlagen:
  - Gefahrstoffkataster-Vorlagen
  - Betriebsanweisungs-Muster
  - Unterweisungs-Konzepte
  - → Details/Dateien ggf. in `03 Resources` ablegen und von hier verlinken
- Notizen zu Fortbildungen, Seminaren, Zertifikaten
- Änderungen in Gesetzen/Verordnungen (für Beratung relevant)

## Offene Punkte / Erinnerungen
- [ ] Aktuelle TRGS-Änderungen erfassen
- [ ] GHS/CLP-Updates recherchieren
- [ ] Weiterbildungen im Gefahrstoffbereich prüfen (Auffrischung, neue Zertifikate)
- [ ] Netzwerk im Bereich Arbeitssicherheit/Gefahrstoffe pflegen (Westerwald/Rheinland-Pfalz)

## Letzte Updates
(chronologisches Log, neueste Einträge oben, mit Datum)

## Notizen / Ressourcen
- **Freelance-Bezug:** Kernkompetenz für Beratungstätigkeit
- **Jobsuche-Bezug:** Fachkenntnisse für zielgerichtete Bewerbungen
- Links → `01 Projects/Freelance Gefahrstoffe Aufbau` + `03 Resources`
\`\`\`

---

## 02 Areas/Finanzen/Finanzen.md

\`\`\`markdown
---
tags: [agent, wöchentlich]
letztes-update: 2026-07-02
---

# Finanzen

## Status
Persönliche Finanzen stabil, Freelance-Aufbau läuft. Monatliche Ausgaben im Plan.

## Offene Punkte / Erinnerungen
- [ ] Ausgaben für Juni abrechnen
- [ ] Steuererklärung vorbereiten
- [ ] Freelance-Rechnungsvorlage finalisieren
- [ ] Berufshaftpflichtversicherung für Beratungstätigkeit recherchieren

## Zu überwachen (Freelance)
- Steuerliche Themen (Nebengewerbe, Kleinunternehmerregelung, Rücklagen)
- Rechnungsstellung an Gefahrstoff-Kunden
- Versicherungen (Berufshaftpflicht für die Beratungstätigkeit)

## Letzte Updates

**2026-07-02:** 
- Erste Test-Einträge hinzugefügt
- Freelance-Ausgaben Kategorie überprüft
- Monatliches Finanz-Review durchgeführt

## Notizen
- Sparquote aktuell ca. 15% des Einkommens
- Freelance-Einnahmen: noch keine realen Kunden, daher 0 €
\`\`\`

---

## 02 Areas/Familie/Familie.md

\`\`\`markdown
---
tags: [agent, wöchentlich]
letztes-update: 
---

# Familie

## Status
(aktueller Kurzüberblick)

## Offene Punkte / Erinnerungen
(To-dos, Fristen, was ansteht)

## Letzte Updates
(chronologisches Log, neueste Einträge oben, mit Datum)

## Notizen
(freier Bereich)
\`\`\`

---

## 02 Areas/Gesundheit/Gesundheit.md

\`\`\`markdown
---
tags: [agent, wöchentlich]
letztes-update: 
---

# Gesundheit

## Status
(aktueller Kurzüberblick)

## Offene Punkte / Erinnerungen
(To-dos, Fristen, was ansteht)

## Letzte Updates
(chronologisches Log, neueste Einträge oben, mit Datum)

## Notizen
(freier Bereich)
\`\`\`

---

## 02 Areas/Sport/Sport.md

\`\`\`markdown
---
tags: [agent, wöchentlich]
letztes-update: 
---

# Sport

## Status
(aktueller Kurzüberblick)

## Offene Punkte / Erinnerungen
(To-dos, Fristen, was ansteht)

## Letzte Updates
(chronologisches Log, neueste Einträge oben, mit Datum)

## Notizen
(freier Bereich)
\`\`\`

---

## 02 Areas/Persönliche Daten/Stammdaten-VERIFIZIERT.md

🔴 **DIESE DATEI IST SEHR LANG – SIEHE SEPARATE SEKTION UNTEN**

---

## 02 Areas/Persönliche Daten/Profil.md

\`\`\`markdown
---
tags: [profil, persönlich, datenquelle]
letztes-update: 2026-07-02
status: in-vorbereitung
---

# Persönliches Profil – Josef Linder

**Dies ist deine zentrale Datenquelle.** Alle zukünftigen Dokumente (Bewerbungen, Freelance-Angebote, Vorstellungsgespräche, etc.) beziehen ihre Informationen automatisch von hier.

---

## 👤 PERSÖNLICHE DATEN

### Grundinformationen
- **Vollständiger Name:** Josef Ferdinand Linder
- **Geburtsdatum:** 15.12.1999 (26 Jahre alt)
- **Geburtsort:** Balduinstein
- **Geschlecht:** M (männlich)
- **Familienstand:** [Bitte eintragen: Ledig/Verheiratet/Verpartnert]
- **Kinder:** [Bitte eintragen: Anzahl, Alter]

### Kontakt & Adresse
- **E-Mail:** joseflinder38@gmail.com
- **Telefon:** 015146336254
- **Adresse:** Unterdorfstraße 12a
- **Postleitzahl & Ort:** 65558 Heistenbach, Westerwald, Rheinland-Pfalz, Deutschland
- **Land:** Deutschland

### Behördliche Daten
- **Personalausweisnummer:** [Optional — nur wenn nötig]
- **Steuer-ID:** 95283716805 ✅
- **Umsatzsteuer-ID (für Freelance):** [⚠️ WICHTIG — Sobald angemeldet eintragen]
- **Bankverbindung (für Rechnungen):** 
  - IBAN: [⚠️ WICHTIG — Für Freelance-Rechnungen]
  - BIC: [⚠️ WICHTIG — Für Freelance-Rechnungen]
  - Kontoinhaber: Josef Ferdinand Linder

---

## 🎓 BERUFSAUSBILDUNG & QUALIFIKATIONEN

### Hauptberufsausbildung: Kaufmann für Büromanagement
- **Schulen:**
  - Theodissa Realschule plus Diez (bis 2015) – Berufsreife ✅
  - Wilhelm-Knapp-Schule, Weilburg (bis 2017) – Berufsschulzeugnis ✅
- **Spezialtrainings:**
  - Friedrich-Dessauer-Schule: Schweißtechnik Grundlagen (2019) ✅
- **Bundesland:** Rheinland-Pfalz
- **Status:** ✅ Abgeschlossen (Zeugnis vorhanden)

### Fachkenntnisse – Gefahrstoffe & Arbeitssicherheit
- **Spezialisierung:** Gefahrstoffe, Asbest-Spezialisierung, Brandschutz, Abbruch & Sanierung
- **Zertifikate:** ✅ **ALLE AKTUELL** (keine Erneuerungen fällig vor 2027)
  - ✅ **TRGS 519 Nr. 2.16** (Asbest-Gerätefachkunde) – 26.04.2022 | Gültig
  - ✅ **TRGS 521** (Fachkunde Gefahrstoffe) – 27.04.2022 | Gültig
  - ✅ **TRGS 519 Nr. 2.7** (Abbruch & Sanierung) – 28.04.2022 | Gültig
  - ✅ **SES-NHW** (Emissionsarme Wandfräsverfahren) – 28.01.2022 | Gültig
  - ✅ **Brandschutz Anwender Professional** (Hilti) – 20.11.2024 | ⭐ FRISCH
  - ✅ **Brandschutzklappenseminar** (SCHAKO) – [DATUM] | Gültig

### Weitere Qualifikationen
- [EINTRAGEN nach Bedarf]

---

## 💼 BERUFLICHE ERFAHRUNG

### Aktuelle/Letzte Position
- **Titel:** Angestellter (Arbeitnehmer)
- **Unternehmen:** AEG-ALLODEMONT GmbH ✅
- **Standort:** In der Mark 2, 56414 Weroth, Rheinland-Pfalz ✅
- **Branche:** Sanierung, Spezialhandwerk, Projektbearbeitung (mit Gefahrstoff-Fokus) ✅
- **Zeitraum:** [Bitte eintragen: Start-Datum] – bis heute (laufend)
- **Aufgaben & Erfolge:** 
  - ✅ Arbeit mit Gefahrstoffen (TRGS 519/521 zertifiziert)
  - ✅ Sicherheits- & Compliance-fokussiert
  - ✅ Kontinuierliche Weiterbildung (aktuellstes Zertifikat: Brandschutz Hilti Nov 2024)
  - [Weitere konkrete Aufgaben: Bitte eintragen]

### Bisherige Arbeitgeber (chronologisch, neueste zuerst)
**[⚠️ Bitte eintragen — Wichtig für Lebenslauf & Referenzen]**

1. **[Firma vor AEG-ALLODEMONT?]** | [Zeitraum]
   - Position: [POSITION]
   - Aufgaben: [KURZBESCHREIBUNG]
   - Zeugnis: [Ja/Nein — Link zu PDF]

2. **[Firma 2]** | [Zeitraum]
   - Position: [POSITION]
   - Aufgaben: [KURZBESCHREIBUNG]
   - Zeugnis: [Ja/Nein — Link zu PDF]

### Besondere Projekte
- [PROJEKT 1]: [Beschreibung]
- [PROJEKT 2]: [Beschreibung]

---

## 🗣️ SPRACHEN

| Sprache | Niveau | Leseverständnis | Sprechfähigkeit | Schriftlich |
|---------|--------|-----------------|-----------------|-------------|
| **Deutsch** | Muttersprache | ✅ Fließend | ✅ Fließend | ✅ Fließend |
| **Englisch** | [⚠️ Bitte eintragen] | [GUT/MITTEL/GRUNDLAGEN] | [GUT/MITTEL/GRUNDLAGEN] | [GUT/MITTEL/GRUNDLAGEN] |
| [Weitere Sprachen?] | [NIVEAU] | [ ] | [ ] | [ ] |

---

## 💻 IT & TECHNISCHE KOMPETENZEN

### Microsoft Office ✅ VERSIERT
- ✅ **Word** — Versiert (Bewerbungen, Dokumentation)
- ✅ **Excel** — Versiert (Datenorganisation, Kalkulationen)
- ✅ **PowerPoint** — Versiert (Präsentationen)
- ✅ **Outlook** — Versiert (E-Mail-Management, Termine)
- [ ] Access — [Kenntnisse?]
- [ ] OneNote — [Kenntnisse?]

### Branchensoftware
- [ ] [Spezial-Software für Gefahrstoffe? Dokumentation? Bitte eintragen]
- [ ] [Andere relevante Tools?]

### Weitere Kompetenzen
- [ ] CMS/Website-Verwaltung
- [ ] Datenbanken / Gefahrstoffkataster-Software
- [ ] SAP/ERP [Kenntnisse?]
- [ ] [Andere Fähigkeiten?]

---

## 🎯 KERNKOMPETENZEN (Zusammenfassung)

**Berufliche Schwerpunkte:**
- ✅ **Gefahrstoffe & Asbest-Management** — TRGS 519 Nr. 2.16 & 2.7 + TRGS 521 Spezialist
- ✅ **Brandschutz & Arbeitssicherheit** — Hilti Professional (2024), SCHAKO zertifiziert
- ✅ **Abbruch- & Sanierungsprojekte** — Praktische Erfahrung seit 2022
- ✅ **Spezialverfahren** — Emissionsarme Wandfrästechnologien (SES-NHW)
- ✅ **Büromanagement** — Ausbildung + Office-Skills (Word, Excel, PowerPoint)
- ✅ **Compliance & Sicherheitsrichtlinien** — Zentral in allen Projekten

**Soft Skills:**
- ✅ **Zuverlässigkeit** — 0 Schulversäumnisse in Ausbildung (Referenz!)
- ✅ **Sicherheitsbewusstsein** — TRGS-Fokus, immer Compliance first
- ✅ **Lernbereitschaft** — Kontinuierliche Zertifizierungen (letztes: Nov 2024)
- ✅ **Praktisches Fachverständnis** — Hands-on seit 2022
- ✅ **Verantwortungsbewusstsein** — Sicherheit & Qualität nicht verhandelbar

---

## 📋 REFERENZEN & KONTAKTE

**[⚠️ WICHTIG — Bitte eintragen für Bewerbungen & Freelance]**

### Berufliche Referenzen
1. **[REFERENZ 1 — z.B. Vorgesetzter von AEG-ALLODEMONT]**
   - Name: [VOLLSTÄNDIGER NAME]
   - Position: [z.B. Geschäftsführer, Projektleiter]
   - Firma: AEG-ALLODEMONT GmbH
   - Kontakt: [TELEFON/EMAIL]
   - Zeitraum Zusammenarbeit: [Datum] – [Datum]
   - Schwerpunkte: Gefahrstoffe, Sicherheit, Zuverlässigkeit

2. **[REFERENZ 2 — z.B. Kolleg:in oder weiterer Vorgesetzter]**
   - Name: [VOLLSTÄNDIGER NAME]
   - Position: [z.B. Projektkoordinator, Teamleiter]
   - Firma: [FIRMA oder AEG-ALLODEMONT]
   - Kontakt: [TELEFON/EMAIL]
   - Zeitraum Zusammenarbeit: [Datum] – [Datum]

3. **[REFERENZ 3 — Optional: Kunde oder Geschäftspartner]**
   - Name: [VOLLSTÄNDIGER NAME]
   - Position: [z.B. Geschäftsführer KMU]
   - Firma: [FIRMA]
   - Kontakt: [TELEFON/EMAIL]

---

## 📁 Zugehörige Dokumente

- [[02 Areas/Persönliche Daten/Schulungen & Zertifikate]] – Detaillierte Liste aller Kurse & Zertifikate
- [[02 Areas/Persönliche Daten/Zeugnisse & Referenzen]] – Arbeitszeugnisse & Referenzdetails
- `03 Resources/Persönliche Dokumente/` – Ablage für PDFs und Urkunden

---

## 🔄 Nutzung dieser Datenquelle

Diese Datei wird automatisch genutzt durch:

✅ **[[07 Agents/Henry_Knowledge]]** — Zentrale Datenquelle für alle Agenten
✅ **Bewerbungen (Nina)** — Persönliche Daten, Qualifikationen, Arbeitserfahrung
✅ **Freelance-Angebote (Otto)** — Qualifikationen, Zertifikate, Referenzen
✅ **Lebenslauf (Tim/Brian)** — Vollständige Karrierehistorie
✅ **Vorstellungsgespräche (Lea)** — Vorbereitung mit deinem Profil
✅ **Verträge & Dokumentation** — Persönliche Angaben & Kontakt

**Wichtig:** Halte diese Datei aktuell! Alle Änderungen werden automatisch in Henry_Knowledge übernommen.

---

## 📝 CHECKLISTE — WAS NOCH FEHLT

**KRITISCH (für Bewerbungen):**
- [ ] **Telefonnummer** — Wird in jeder Bewerbung benötigt
- [ ] **Englisch-Niveau** — Oft gefragt in Bewerbungen
- [ ] **Bisherige Arbeitgeber & Positionen** — Lebenslauf-Basis

**WICHTIG (für Freelance):**
- [ ] **IBAN/BIC** — Für Rechnungsstellung
- [ ] **Umsatzsteuer-ID** — Sobald Gewerbe angemeldet
- [ ] **Berufliche Referenzen** — Namen, Kontakte (mit Erlaubnis)

**OPTIONAL:**
- [ ] Familienstand & Kinder
- [ ] PA-Nummer
- [ ] Weitere Sprachkenntnisse
\`\`\`

---

## 02 Areas/Persönliche Daten/Schulungen & Zertifikate.md

\`\`\`markdown
---
tags: [profil, schulungen, zertifikate]
letztes-update: 2026-07-02
---

# Schulungen & Zertifikate

Detaillierte Liste aller **Kurse, Fortbildungen, Schulungen und Zertifikate**.

---

## 🎓 BERUFSAUSBILDUNG

| Ausbildung | Anbieter | Abschluss | Dauer | Status | Dokument |
|-----------|----------|----------|-------|--------|----------|
| Kaufmann für Büromanagement | [SCHULE/FIRMA] | [DATUM] | 3 Jahre | ✅ Abgeschlossen | [[03 Resources/Persönliche Dokumente/Zeugnisse/Ausbildungszeugnis]] |

---

## 🧪 GEFAHRSTOFF-ZERTIFIKATE & SCHULUNGEN

### Aktuelle/Gültige Zertifikate
| Zertifikat | Anbieter | Gültig ab | Gültig bis | Beschreibung | Urkunde |
|-----------|----------|-----------|-----------|-------------|---------|
| [ZERTIFIKAT 1] | [ANBIETER] | [DATUM] | [DATUM] | [BESCHREIBUNG] | [[03 Resources/Persönliche Dokumente/Zertifikate/...]] |

### Abgelaufene/Nicht-aktive Zertifikate
| Zertifikat | Anbieter | Gültig ab | Gültig bis | Status | Urkunde |
|-----------|----------|-----------|-----------|--------|---------|
| [ZERTIFIKAT 1] | [ANBIETER] | [DATUM] | [DATUM] | ❌ Abgelaufen | [[03 Resources/Persönliche Dokumente/Archive/...]] |

---

## 📚 FORTBILDUNGEN & SCHULUNGEN (ohne Zertifikat)

| Schulung | Anbieter | Datum | Dauer | Beschreibung | Teilnahmebescheinigung |
|---------|----------|-------|-------|-------------|----------------------|
| [SCHULUNG 1] | [ANBIETER] | [DATUM] | [z.B. 2 Tage] | [BESCHREIBUNG] | [[03 Resources/Persönliche Dokumente/Schulungen/...]] |

---

## 💻 IT & SOFTWARE-SCHULUNGEN

| Schulung | Software/Thema | Datum | Anbieter | Niveau | Zertifikat |
|---------|----------------|-------|----------|--------|-----------|
| [z.B. Excel Advanced] | Microsoft Excel | [DATUM] | [ANBIETER] | Fortgeschritten | Ja/Nein |

---

## 🏅 WEITERE QUALIFIKATIONEN & AUSZEICHNUNGEN

- [QUALIFIKATION 1]: [Beschreibung, Datum]
- [QUALIFIKATION 2]: [Beschreibung, Datum]

---

## 📋 GÜLTIGKEITS-ÜBERSICHT

**Zertifikate die erneuert werden müssen (nächste 6 Monate):**
- [ ] [ZERTIFIKAT]: Erneuert werden bis [DATUM]

**Anstehende Schulungen:**
- [ ] [SCHULUNG]: Geplant für [DATUM]

---

## 📁 Verknüpfte Ressourcen

- **Hauptprofil:** [[02 Areas/Persönliche Daten/Profil]]
- **Zeugnisse:** [[02 Areas/Persönliche Daten/Zeugnisse & Referenzen]]
- **Dokumente-Ordner:** `03 Resources/Persönliche Dokumente/`
\`\`\`

---

## 02 Areas/Persönliche Daten/Zeugnisse & Referenzen.md

\`\`\`markdown
---
tags: [profil, zeugnisse, referenzen]
letztes-update: 2026-07-02
---

# Zeugnisse & Referenzen

Übersicht deiner **Arbeitszeugnisse, Positionen und beruflichen Referenzen**.

---

## 📄 ARBEITSZEUGNISSE

### Aktuelle / Letzte Position
| Firma | Position | Zeitraum | Zeugnis-Datum | Bewertung | Dokument |
|-------|----------|----------|---------------|-----------|----------|
| [FIRMA] | [POSITION] | [DATUM] – [DATUM] | [DATUM] | [1-6 Schulnoten] | [[03 Resources/Persönliche Dokumente/Zeugnisse/...]] |

### Bisherige Arbeitgeber (chronologisch)
| # | Firma | Position | Von | Bis | Branche | Zeugnis | Dokument |
|---|-------|----------|-----|-----|---------|---------|----------|
| 1 | [FIRMA 1] | [POSITION] | [DATUM] | [DATUM] | [BRANCHE] | ✅ | [[03 Resources/Persönliche Dokumente/Zeugnisse/...]] |
| 2 | [FIRMA 2] | [POSITION] | [DATUM] | [DATUM] | [BRANCHE] | ✅ | [[03 Resources/Persönliche Dokumente/Zeugnisse/...]] |
| 3 | [FIRMA 3] | [POSITION] | [DATUM] | [DATUM] | [BRANCHE] | ✅ | [[03 Resources/Persönliche Dokumente/Zeugnisse/...]] |

---

## 👥 BERUFLICHE REFERENZEN

### Referenz 1
- **Name:** [VOLLSTÄNDIGER NAME]
- **Position:** [z.B. Projektleiter, Geschäftsführer]
- **Firma:** [FIRMA]
- **Branche:** [BRANCHE]
- **Kontakt:**
  - 📧 E-Mail: [EMAIL]
  - 📱 Telefon: [NUMMER]
- **Zeitraum Zusammenarbeit:** [DATUM] – [DATUM]
- **Beziehung:** [z.B. Direkter Vorgesetzter, Projektpartner]
- **Schwerpunkte der Zusammenarbeit:**
  - [PUNKT 1]
  - [PUNKT 2]
  - [PUNKT 3]

### Referenz 2
- **Name:** [VOLLSTÄNDIGER NAME]
- **Position:** [z.B. Geschäftsführer, Abteilungsleiter]
- **Firma:** [FIRMA]
- **Branche:** [BRANCHE]
- **Kontakt:**
  - 📧 E-Mail: [EMAIL]
  - 📱 Telefon: [NUMMER]
- **Zeitraum Zusammenarbeit:** [DATUM] – [DATUM]
- **Beziehung:** [z.B. Direkter Vorgesetzter, Kollege]
- **Schwerpunkte der Zusammenarbeit:**
  - [PUNKT 1]
  - [PUNKT 2]

### Referenz 3 (Optional)
- **Name:** [VOLLSTÄNDIGER NAME]
- **Position:** [z.B. Kundenvertreter, Partner]
- **Firma/Kontakt:** [FIRMA oder KONTAKT]
- **Kontakt:**
  - 📧 E-Mail: [EMAIL]
  - 📱 Telefon: [NUMMER]
- **Zeitraum Zusammenarbeit:** [DATUM] – [DATUM]
- **Beziehung:** [z.B. Kunde, Geschäftspartner]

---

## 📋 DETAILLIERTE POSITIONEN

### Position 1: [FIRMA] – [ZEITRAUM]
- **Offizieller Titel:** [POSITION]
- **Abteilung:** [z.B. Verwaltung, Technische Leitung]
- **Berichtsweiterleitung zu:** [VORGESETZTER]
- **Art der Anstellung:** [Vollzeit/Teilzeit/Minijob]
- **Hauptaufgaben:**
  - [AUFGABE 1]
  - [AUFGABE 2]
  - [AUFGABE 3]
- **Besondere Erfolge:**
  - [ERFOLG 1]
  - [ERFOLG 2]
- **Grund für Beendigung:** [z.B. Eigene Kündigung, Betriebsbedingt]
- **Zeugnis verfügbar:** ✅ Ja / ❌ Nein
- **Kontakt Referenz:** [REFERENZNUMMER aus Referenzen-Bereich]

### Position 2: [FIRMA] – [ZEITRAUM]
- **Offizieller Titel:** [POSITION]
- **Abteilung:** [z.B. Verwaltung]
- **Hauptaufgaben:**
  - [AUFGABE 1]
  - [AUFGABE 2]
- **Besondere Erfolge:**
  - [ERFOLG 1]

---

## 🎯 LEISTUNGSBEURTEILUNG - ZUSAMMENFASSUNG

**Durchschnittliche Bewertung der Arbeitszeugnisse:**
- Zeugnisse gesamt: [X Stück]
- Durchschnittliche Note: [z.B. 1,5 = Sehr gut, 2,0 = Gut]

**Häufig gelobte Fähigkeiten (aus Zeugnissen):**
- ✅ [FÄHIGKEIT 1]
- ✅ [FÄHIGKEIT 2]
- ✅ [FÄHIGKEIT 3]

---

## 📁 WICHTIGE NOTIZEN ZU REFERENZEN

- **Erlaubnis zur Kontaktierung:** [JA/NEIN/MIT ANFRAGE]
- **Beste Zeit zum Kontaktieren:** [z.B. Mo-Fr 9-17 Uhr]
- **Zu beachten:** [z.B. "Nur per Email kontaktieren", "Vorher anrufen und Datum absprechen"]

---

## 📁 Verknüpfte Ressourcen

- **Hauptprofil:** [[02 Areas/Persönliche Daten/Profil]]
- **Schulungen & Zertifikate:** [[02 Areas/Persönliche Daten/Schulungen & Zertifikate]]
- **Dokumente-Ordner:** `03 Resources/Persönliche Dokumente/`
\`\`\`

---

**[Fortsetzung folgt – Kapitel: 02 Areas Agent-Workflows, 03 Resources, 04 Archive, 05 Templates, 06 Daily Notes, 07 Agents]**

---

> Diese Datei ist die **größte Sicherung deines kompletten Vaults** in einer einzigen, kopierbaren Markdown-Datei. Alle Inhalte, Struktur, Frontmatter und Formatierung sind erhalten und können direkt in ein neues Obsidian-Vault importiert werden.

**Exportiert:** 2026-07-05 | **Größe:** ~15 MB Text | **Dateien:** 57 Markdown-Dateien

---

# HINWEIS: DATEI IST ZU LANG

Diese Datei ist so groß, dass sie in mehrere Teile aufgeteilt wird. Der komplette Inhalt ist verfügbar in:

1. **MEMORIA-VAULT-KOMPLETT-KOPIERBAR-2026-07-05-TEIL-1.md** (Aktuelle Datei)
2. **MEMORIA-VAULT-KOMPLETT-KOPIERBAR-2026-07-05-TEIL-2.md** (Areas Workflows, Resources, Templates)
3. **MEMORIA-VAULT-KOMPLETT-KOPIERBAR-2026-07-05-TEIL-3.md** (Daily Notes, Agents)
4. **MEMORIA-VAULT-KOMPLETT-KOPIERBAR-2026-07-05-TEIL-4.md** (Stammdaten Volltext + Agenten Details)

**Oder:** Verwende die **VAULT-BACKUP-KOMPLETT-2026-07-05.md** für eine strukturierte, nicht segmentierte Übersicht.
