---
type: strategy
erstellt: 2026-10-11
status: aktiv
---

# 📐 Kauf-/Verkauf-Algorithmus — Aktien & ETFs

**Ziel:** Regelbasierte, emotionsfreie Entscheidungen. Kein Markttiming nach Bauchgefühl. Basiert auf etablierten, konservativen Methoden (DCA, Schwellenwert-Rebalancing, Trendfolge) — keine spekulativen/riskanten Strategien, da das Depot auf dein Norwegen-Sparziel (€160k/3 Jahre) einzahlt.

---

## 1. Portfolio-Aufteilung (Grundregel)

| Baustein | Anteil | Zweck |
|---|---|---|
| **ETF-Kern** (z.B. MSCI World/ACWI) | 80–90% | Breite Diversifikation, Basis fürs Sparziel |
| **Einzelaktien-Satellit** | 10–20% max | Höheres Risiko, nur mit überschüssigem Kapital |

**Regel #0:** Einzelaktien-Anteil darf **nie über 20%** des Gesamtdepots steigen. Bei Überschreitung → Regel 4 (Rebalancing).

---

## 2. ETF-KAUF-ALGORITHMUS (Kernstrategie)

```
WENN monatlicher Sparplan-Termin erreicht:
    KAUFE feste Summe X € (unabhängig vom Kurs)
    KEINE Ausnahme bei fallenden Kursen (im Gegenteil: mehr Anteile fürs Geld)
    KEINE Ausnahme bei steigenden Kursen (kein "Warten auf Korrektur")
```

**Warum:** Dollar-Cost-Averaging (DCA) ist die einzige Methode, die nachweislich Markttiming-Fehler eliminiert — Kaufzeitpunkt wird automatisch gemittelt. Laut Recherche: Standardempfehlung für Privatanleger ohne Vollzeit-Marktbeobachtung.

**Zusatzregel — Nachkauf bei Crash (optional, nur mit Cash-Reserve außerhalb des Sparplans):**
```
WENN Kurs > 20% unter 200-Tage-Durchschnitt (SMA200):
    Einmaliger Zusatzkauf aus Cash-Reserve (max. 10% der Reserve pro Signal)
    Nicht den normalen Sparplan erhöhen — nur Zusatzkapital nutzen
```

---

## 3. EINZELAKTIEN-ALGORITHMUS (Satellit, max. 20%)

### Kaufsignal
```
KAUFE WENN ALLE Bedingungen erfüllt:
    1. Kurs > SMA50 (50-Tage-Durchschnitt)  → Aufwärtstrend bestätigt
    2. SMA50 > SMA200                         → "Golden Cross", langfristiger Trend positiv
    3. Positionsgröße ≤ 5% des Gesamtdepots  → Klumpenrisiko vermeiden
    4. Einzelaktien-Anteil gesamt < 20%       → Regel #0 eingehalten
```

### Verkaufssignal (jede Bedingung einzeln reicht)
```
VERKAUFE WENN EINE Bedingung erfüllt:
    1. Kurs < SMA50 UND SMA50 < SMA200       → "Death Cross", Trend gebrochen
    2. Verlust ≥ 15% vom Kaufkurs             → Stop-Loss (hart, keine Ausnahme)
    3. Gewinn ≥ 50% vom Kaufkurs              → Teilverkauf 50% der Position (Gewinn sichern,
                                                  Rest laufen lassen)
    4. Position > 8% des Gesamtdepots         → Teilverkauf auf 5% zurück (Klumpenrisiko)
```

**Kein Nachkaufen in Verlustpositionen ("averaging down")** — das ist eine der häufigsten Anfängerfehler und hier bewusst ausgeschlossen.

---

## 4. REBALANCING-ALGORITHMUS (gesamtes Depot)

Schwellenwert-basiert (laut Recherche robuster als reines Zeitintervall):

```
PRÜFE vierteljährlich (1x pro Quartal, fester Termin):
    WENN Abweichung einer Anlageklasse > 5 Prozentpunkte vom Zielwert:
        Verkaufe Übergewicht / Kaufe Untergewicht bis Zielverteilung erreicht
    SONST:
        Nichts tun (kein Handeln ohne Signal)
```

Beispiel: ETF-Ziel 85%, aktuell 92% (weil Einzelaktien stark gefallen sind) → 7 Prozentpunkte Abweichung > 5% Schwelle → rebalancieren.

---

## 5. ZEITHORIZONT-ANPASSUNG (Glide Path Richtung Norwegen Q4 2026+)

Je näher der Auswanderungs-/Kapitalbedarfs-Zeitpunkt rückt, desto weniger Risiko:

| Zeit bis Kapitalbedarf | Max. Einzelaktien-Anteil | Cash-Puffer |
|---|---|---|
| > 24 Monate | 20% | 5% |
| 12–24 Monate | 10% | 10% |
| < 12 Monate | 0–5% | 20%+ |

**Begründung:** Geld, das für den Norwegen-Umzug fest eingeplant ist, darf nicht kurz vor Bedarf in einem Kurseinbruch feststecken. Das ist keine Anlagestrategie-Frage, sondern Liquiditätsplanung.

---

## 6. HARTE AUSSCHLUSSREGELN (nie brechen)

- ❌ Kein Kauf auf Kredit/Margin
- ❌ Keine Hebelprodukte (Optionsscheine, CFDs, gehebelte ETFs) im Kernportfolio
- ❌ Kein "All-in" in eine einzelne Position
- ❌ Keine Entscheidung basierend auf Social-Media-Hype/Momentum ohne obige Signale
- ❌ Stop-Loss (Regel 3.2) wird **nie** manuell übersteuert, auch wenn es sich "falsch anfühlt"

---

## 7. Rolle für Kratos (Marktbeobachter-Agent)

Kratos kann die Datenbeschaffung für diesen Algorithmus übernehmen (SMA50/SMA200-Werte, Kursabweichungen, Quartals-Reminder), **trifft aber keine automatischen Kauf-/Verkaufsentscheidungen** — die Ausführung bleibt bewusst manuell (kein Broker-API-Zugriff, keine automatisierten Order). Kratos liefert die Zahlen, du triffst nach obigen Regeln die Entscheidung.

**Mögliche Erweiterung:** Wöchentlicher Kratos-Report mit SMA-Status aller gehaltenen Positionen + Ampel (🟢 halten / 🟡 beobachten / 🔴 Verkaufssignal nach Regel 3.2).

---

## Quellen

- [DCA S&P 500 Investment Strategy 2026](https://freenance.io/etf/dca-sp500-investment-strategy/)
- [Eiserne ETF-Strategie – 10 Regeln für den Sparplan (Finanztip)](https://www.finanztip.de/community/forum/thema/44863-eiserne-etf-strategie-10-regeln-f%C3%BCr-den-sparplan)
- [ETF Rebalancing Erklärung (Finanzfluss)](https://www.finanzfluss.de/etf-handbuch/etf-rebalancing/)
- [Wann ETF verkaufen (justETF Academy)](https://www.justetf.com/de/academy/wann-etf-verkaufen.html)
