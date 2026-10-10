---
type: automation-guide
version: "1.0"
status: BEREIT-ZUR-AKTIVIERUNG
erstellt: 2026-07-28
---

# ☁️ CLOUD ROUTINES - MANUELLE SETUP-ANLEITUNG

**3 Cloud-Agenten für automatisierte Reports + Reminders**

Diese Routines müssen MANUELL in Claude Cloud eingerichtet werden.

---

## ANLEITUNG ZUM EINRICHTEN

### Schritt 1: Claude Cloud Routines öffnen
```
Gehe zu: https://claude.ai/
→ Einstellungen → Cloud Routines
→ "Create New Routine"
```

### Schritt 2: Kopiere die Routine-Konfiguration (siehe unten)
Für jede Routine:
1. Name kopieren
2. Schedule kopieren
3. Prompt kopieren
4. Instructions eingeben
5. "Save & Enable" klicken

---

## ✅ ROUTINE 1: WÖCHENTLICHE BEWERBUNGS-ZUSAMMENFASSUNG

**Name:** `Memoria-Weekly-Applications-Report`

**Schedule:** Montag 08:00 Uhr (Berlin Time)

**Instructions (prompt):**

```
Erstelle einen wöchentlichen Bericht über Josef's Bewerbungen.

QUELLE: Lese alle Dateien aus "01 Projects/Bewerbungen/Firmen/"

BERICHT-STRUKTUR:

## 1. NEUE BEWERBUNGEN diese Woche
- Firma (falls vorhanden)
- Position (falls vorhanden)
- Einreichdatum

## 2. RÜCKMELDUNGEN erhalten diese Woche
- Firma
- Termin Rückmeldung
- Ergebnis (Zusage/Absage/Interview)

## 3. FOLLOW-UP ERFORDERLICH (bis Ende dieser Woche)
- Firma
- Grund für Follow-up
- Aktion

## 4. STATISTIK
- Gesamte aktive Bewerbungen
- Diese Woche neue: [Zahl]
- Diese Woche erfolgreiche Interviews: [Zahl]
- Erfolgsquote (Bewerbungen → Gespräche): [%]

OUTPUT-FORMAT:
- Markdown
- Kopiere in: "06 Daily Notes/Weekly-Report-Applications-[DATUM].md"
- Automatische Dokumentation

WICHTIGE REGELN:
- Verwende NUR Daten die tatsächlich in den Dateien stehen
- KEINE Spekulationen oder Vorhersagen
- KEINE persönlichen Daten exportieren (Adresse, Telefon, Email)
- Zertifikatstitel OK, aber keine Nummern/Daten

ZIEL: Josef soll auf einen Blick wissen, welche Bewerbungen neu sind, welche Rückmeldungen kamen, und was diese Woche ansteht.
```

**Output:** Automatisch speichern in `06 Daily Notes/`

---

## ✅ ROUTINE 2: FREELANCE FOLLOW-UP REMINDERS

**Name:** `Memoria-Freelance-Followups`

**Schedule:** Freitag 16:00 Uhr

**Instructions (prompt):**

```
Überprüfe Josef's Freelance-Kunden-Pipeline und erstelle Followup-Reminders.

QUELLE: Lese alle Dateien aus "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/"

SUCHE NACH:

1. **Überfällige Kontakte**
   - Kunden, bei denen "nächster_kontakt" DATUM < HEUTE
   - Aktion: "HEUTE oder MORGEN Follow-up senden!"
   
2. **Alte Proposals** (älter als 2 Wochen, noch nicht signiert)
   - Kunde, Proposal-Datum, Status
   - Aktion: "Status abfragen + nachbohren"
   
3. **Abschließende Projekte** (nächste Woche Ende)
   - Projekt, Kunde, Abschluss-Datum
   - Aktion: "Abschluss-Dokumentation vorbereiten"
   
4. **Neue Kundeninteressen**
   - Falls neue Kunden im letzten Monat Interesse gezeigt haben
   - Aktion: "First proposal vorbereiten"

OUTPUT:
- Priorisierte Liste (Überfällig > Urgent > Diese Woche)
- Markdown-Format
- Speichern in: "06 Daily Notes/Freelance-Followup-[DATUM].md"

WICHTIGE REGELN:
- Fokus auf NÄCHSTE WOCHE
- Keine alten Projekte (älter als 3 Monate) = nicht relevant
- Nur echte Daten, keine Vorhersagen
- Keine Kundenkontaktdaten exportieren

ZIEL: Josef weiß FREITAG, was nächste Woche zu tun ist.
```

---

## ✅ ROUTINE 3: MONATLICHER FINANZ-BERICHT

**Name:** `Memoria-Monthly-Finance-Report`

**Schedule:** 1. eines Monats, 09:00 Uhr

**Instructions (prompt):**

```
Erstelle einen monatlichen Finanz-Bericht für Josef's Gefahrstoff-Beratungs-Business.

QUELLEN:
- "02 Areas/Finanzen.md"
- "02 Areas/Finanzen/Dashboard-2026.md"
- Abgeschlossene Kunden-Projekte aus "01 Projects/Freelance/Kunden/"

BERICHT-STRUKTUR:

## FREELANCE-EINNAHMEN (diesen Monat)
- Kunde 1: [Leistung], €[Betrag]
- Kunde 2: [Leistung], €[Betrag]
- ...
SUMME EINNAHMEN: €[Gesamt]

## AUSGABEN (diesen Monat, falls vorhanden)
- Kategorie: Betrag
- Kategorie: Betrag
SUMME AUSGABEN: €[Gesamt]

## NETTO-GEWINN
- Einnahmen - Ausgaben = €[Netto]

## PIPELINE PROGNOSE (nächster Monat)
- Kunden in Verhandlung: [Anzahl]
- Erwartete Einnahmen: €[Prognose]

## TRENDS
- Vergleich Vormonat (falls möglich)
- Wachstumstrend?

OUTPUT:
- Markdown-Format
- Speichern in: "02 Areas/Finanzen/Reports/Report-[YYYY-MM].md"
- Ordner erstellen falls nicht vorhanden

WICHTIGE REGELN:
- Nur VOLLSTÄNDIG abgeschlossene Projekte = Einnahme
- Proposals = Pipeline (noch nicht Einnahme!)
- KEINE persönlichen privaten Ausgaben
- KEINE Kundendaten (nur "Kunde A", "Kunde B", etc.)

ZIEL: Josef hat jeden Monats einen Überblick über Business-Performance.
```

---

## 🚀 SETUP-REIHENFOLGE

1. **Routine 1 einrichten** (Weekly Applications) — Montag 08:00
2. **Routine 2 einrichten** (Freelance Followups) — Freitag 16:00
3. **Routine 3 einrichten** (Monthly Finance) — 1. des Monats 09:00

**Zeit pro Routine:** 5-10 Minuten

**Gesamtzeit:** ~20-30 Minuten

---

## ✅ TESTING

Nach Setup:
1. Routine manuell triggern (nicht warten auf Schedule)
2. Output-Datei prüfen (sollte in `06 Daily Notes/` oder `02 Areas/Finanzen/Reports/` erstellt sein)
3. Inhalt überprüfen (Vollständigkeit, Korrektheit)
4. Bei Problemen: Prompt anpassen + erneut triggern

---

## 📍 STATUS

- ✅ Prompts vorbereitet
- ✅ Output-Ordner existieren
- ⏳ Routines müssen noch manuell in Claude Cloud eingegeben werden
- ⏳ Nach Setup: Testing

**Nächster Schritt:** Gehe zu claude.ai und richte die 3 Routines ein! ☁️
