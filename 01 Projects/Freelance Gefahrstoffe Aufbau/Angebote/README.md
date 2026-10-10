---
type: readme
category: freelance-angebote
status: aktiv
updated: 2026-07-10
tags: [projekt, freelance, angebote, anleitung]
letztes-update: 2026-07-10
---

# 💼 Angebote-Ordner – Anleitung

Jedes Angebot für (potenzielle) Gefahrstoff-Kunden bekommt hier eine eigene Datei für Tracking & Dokumentation.

## 📝 Neues Angebot erstellen

1. **Kopiere die Vorlage:**
   - `05 Templates/Angebot-Template.md`

2. **Benenne die Datei:**
   - Format: `Kundenname_JJJJ-MM-TT.md`
   - Beispiele: `Müller Metallbau_2026-07-05.md`, `ChemTech GmbH_2026-07-10.md`

3. **Speichere sie hier:**
   - `01 Projects/Freelance Gefahrstoffe Aufbau/Angebote/[Kundenname_Datum].md`

4. **Fülle die Felder aus:**
   - Kunde (Wiki-link zur Kundennotiz)
   - Leistung (Gefahrstoffkataster / Betriebsanweisungen / Unterweisungen / Paket)
   - Angebotssumme (EUR)
   - Gültig bis (Ablaufdatum)
   - Status (Entwurf / Versendet / Akzeptiert / Abgelehnt / Rechnungsgestellt / Bezahlt)
   - Besonderheiten / Notizen

## 🔄 Status-Workflow

```
Entwurf (noch nicht versendet)
  ↓
Versendet (an Kunde übermittelt, Antwort ausstehend)
  ↓
Akzeptiert (Kunde stimmt zu, Projekt startet)
  ↓
Rechnungsgestellt (Leistung erbracht, Rechnung versendet)
  ↓
Bezahlt (Zahlung eingegangen)

Oder: Abgelehnt (Kunde lehnt ab)
```

## 💰 Leistungstypen

- **Gefahrstoffkataster:** €[TBD]
- **Betriebsanweisungen:** €[TBD] (pro Stück)
- **Unterweisungen:** €[TBD] (pro Tag/Gruppe)
- **Beratung (allgemein):** €[TBD] (pro Stunde/Tag)
- **Paket-Angebot:** Kataster + Betriebsanweisungen + Unterweisung = €[TBD]

## 📋 Beispiel-Eintrag

```markdown
---
kunde: Müller Metallbau
leistung: Gefahrstoffkataster + Betriebsanweisungen (5 Stück)
betrag: 1.850
gültig-bis: 2026-08-05
status: Versendet
tags: [gefahrstoff-angebot]
---

# Angebot – Müller Metallbau_2026-07-05

## Kunde
[[01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/Müller Metallbau]]

## Leistung
- Gefahrstoffkataster (Erfassung & Analyse)
- Betriebsanweisungen (5 Stück für Schweißen, Schleifen, Lackieren, etc.)

## Angebotssumme
1.850 EUR

## Gültig bis
2026-08-05

## Status
Versendet – warten auf Kundenrückmeldung

## Besonderheiten / Notizen
- Ansprechpartner: Herr Müller
- Anfrage eingegangen: 2026-06-28
- Angebot versendet: 2026-07-05 (E-Mail)
- Folge-up geplant: 2026-07-19
- Besonderheit: Kunde möchte Schulung im August (separate Rechnung)
```

## 📊 Tracking & Reporting

### Offene Angebote
- Zeige alle Angebote mit Status "Versendet" oder "Entwurf"
- Prüfe täglich "Gültig bis" – folge auf bald ablaufende auf

### Erfolgsquote
- Berechnung: (Akzeptiert + Bezahlt) / Gesamt versendet
- Ziel: > 30% im ersten Jahr

### Umsatztracking
- Summe aller akzeptierten Angebote = erwarteter Umsatz
- Summe aller bezahlten Angebote = realisierter Umsatz

## 📌 Tipps

- **Gültig bis:** Immer setzen (z.B. 4 Wochen nach Versand)
- **Kundenlink:** Wiki-link zur entsprechenden Kundennotiz
- **Status aktualisieren:** Sofort wenn Rückmeldung kommt
- **Notizen:** Ansprechpartner, Besonderheiten, Rabatte, Zahlungsbedingungen
- **Archivieren:** Abgeschlossene Angebote (Akzeptiert + Rechnungsgestellt + Bezahlt) → `04 Archive/Freelance/Angebote/`

## 🎯 Ziel

Systematisches Angebots-Management:
- Übersicht über alle ausstehenden Angebote
- Nachverfolgung von Fristen (Gültig bis)
- Umsatz-Tracking (erwartet vs. realisiert)
- Erfolgsquote messen & optimieren

---

**Stand:** 2026-07-05  
**Businessnutzen:** Vertrieb & Finanztransparenz
