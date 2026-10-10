---
rechnungs-nr: 
datum: 
faellig-am: 
kunde: 
leistung: 
betrag-netto: 
bezahlt: ja/nein
bezahlt-am: 
tags: [rechnung]
letztes-update: 2026-07-10
---

# Rechnung {{rechnungs-nr}}

**Rechnungsdatum:** {{datum}}  
**Fällig bis:** {{faellig-am}}

---

## Rechnungssteller

**Josef Ferdinand Linder**  
Kaufmann für Büromanagement | Gefahrstoff-Berater  
Westerwald, Rheinland-Pfalz  

**E-Mail:** joseflinder38@gmail.com  
**IBAN:** [SEPARAT EINTRAGEN – nicht in Exports]

---

## Rechnungsempfänger

{{kunde}}

---

## Leistungen

| Pos. | Beschreibung | Betrag |
|------|-------------|--------|
| 1 | {{leistung}} | {{betrag-netto}} € |
| | **Gesamt netto** | **{{betrag-netto}} €** |

**Umsatzsteuer:** keine (§ 19 UStG – Kleinunternehmer)

---

## Zahlungsaufforderung

Bitte überweisen Sie den Betrag bis **{{faellig-am}}** auf folgende Bankverbindung:

**Verwendungszweck:** Rechnung {{rechnungs-nr}} / {{kunde}}

---

## Zahlungsstatus

- ☐ Offen
- ☐ Teilweise bezahlt
- ☒ Bezahlt am {{bezahlt-am}}

---

**Ausgestellt:** {{datum}}  
**Rechnungsnummer:** {{rechnungs-nr}}
