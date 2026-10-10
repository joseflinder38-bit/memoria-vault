---
title: Markttrends & Preisentwicklung (Karl Market Watch)
date: 2026-07-05
source: Automatisierte tägliche Analyse
status: aktiv
task_nachweis: "schtasks /query zeigt: Karl Market Watch - Daily Market Reports (täglich 10:00 Uhr, Status: Bereit)"
letztes-update: 2026-07-10
---

# 📈 Markttrends & Preisentwicklung

**Status:** AKTIVE AUTOMATISIERUNG ✅  
**Letzter Update:** 2026-07-05  
**Nächster Lauf:** 2026-07-06 10:00 Uhr Europe/Berlin  
**Datenbasis:** [[02 Areas/Finanzen-Archiv|Tägliche Marktberichte]]

---

## 🔧 Automatisierung – Systemüberblick

### Cloud-Routine (Karl Market Watch)
- **ID:** `trig_01PvsNHGJUPZCPVX8XPSAZAt`
- **Zeitplan:** Täglich 08:00 UTC (10:00 Berlin)
- **Aufgabe:** Recherchiert Marktdaten (Aktien, Edelmetalle, Kryptos, Rohstoffe, REITs, Indizes)
- **Output-Format:** Strukturiertes JSON mit Timestamp
- **Status:** AKTIV
- **Link:** https://claude.ai/code/routines/trig_01PvsNHGJUPZCPVX8XPSAZAt

### Lokale Windows Task
- **Name:** `Karl Market Watch - Daily Market Reports`
- **Skript:** `karl-daily-market.ps1`
- **Zeitplan:** Täglich 10:00 Uhr Europe/Berlin
- **Aufgabe:** Speichert Marktdaten im Vault, aktualisiert Trends
- **Status:** ✅ Bereit (schtasks bestätigt)
- **Nächste Laufzeit:** 2026-07-06 10:00:00

### Workflow
```
08:00 UTC      Cloud-Routine (Karl)
  ↓            Researcht Marktdaten → JSON
10:00 Berlin   Lokale Task
  ↓            Liest Daten → Vault speichern
10:05 Berlin   Trend-Analyse aktualisiert
  ↓
[[02 Areas/Finanzen-Archiv]] (neue Tagesberichte)
[[02 Areas/Finanzen-Trends]]  (aktualisiert)
```

---

## 📊 Bereiche unter Überwachung

| Bereich | Metriken | Häufigkeit | Quelle |
|---------|----------|-----------|--------|
| **Aktien** | DAX 40, S&P 500, MSCI World – Kurse, Change % | Täglich | Cloud (WebSearch) |
| **Edelmetalle** | Gold/Silber (g & Feinunze) EUR/USD | Täglich | Cloud (WebSearch) |
| **Kryptowährungen** | Top 10 – Kurs, Marktcap, Change % | Täglich | Cloud (WebSearch) |
| **Rohstoffe** | Öl WTI/Brent, Erdgas, Kupfer, Eisenerz | Täglich | Cloud (WebSearch) |
| **REITs** | Deutsche Immobilien-ETFs (EPRA, Vonovia, LEG) | Täglich | Cloud (WebSearch) |
| **Indizes** | S&P 500, Nikkei 225, FTSE 100, DAX | Täglich | Cloud (WebSearch) |

---

## 📈 Trend-Analyse (7-Tage-Vergleich)

**Hinweis:** Trends werden täglich aktualisiert, sobald genug Datenpunkte vorhanden sind (min. 3 Tage).

### Erwartete Trend-Metriken (wird automatisch gefüllt):

- **Performance-Ranking:** Top 3 Best/Worst Aktien (Woche)
- **Volatilität:** High-Activity-Indikatoren
- **Momentum-Signale:** Aufwärts/Abwärts-Trends
- **Korrelationen:** Welche Bereiche bewegen sich zusammen?

---

## 📁 Archiv-Struktur

```
02 Areas/
├─ Finanzen-Marktbericht_2026-07-05.md     (aktueller Bericht)
├─ Finanzen-Archiv/
│  ├─ Marktbericht_2026-07-05.md
│  ├─ Marktbericht_2026-07-06.md
│  ├─ Marktbericht_2026-07-07.md
│  └─ ... (täglich wächst)
├─ Finanzen-Trends.md                       (diese Datei – wird aktualisiert)
└─ ...
```

---

## ⚙️ Automatisierungs-Status (verifiziert via schtasks)

**Verifizierung durchgeführt am:** 2026-07-05 15:35 UTC  
**Befehl:** `schtasks /query /tn "Karl Market Watch - Daily Market Reports" /fo LIST /v`

**Ergebnis:**
```
Status:                Bereit
Zeitplantyp:           Täglich
Startzeit:             10:00:00
Tage:                  Alle 1 Tag(e)
Nächste Laufzeit:      06.07.2026 10:00:00
Status der Aufgabe:    Aktiviert
```

✅ **BESTÄTIGT:** Automatisierung ist aktiv und lädt täglich.

---

## 🔍 Nächste Schritte

- [ ] Erste Daten sammeln (ab 2026-07-06 10:00)
- [ ] Nach 3 Tagen: Trend-Analysen starten
- [ ] Nach 1 Woche: Performance-Ranking reviewen
- [ ] Quartalsweise: Jahresrenditen aktualisieren

---

*Dieses System wurde mit echter Windows Task Scheduler-Automatisierung eingerichtet (Status verifi ziert via schtasks). Keine manuellen Schritte nötig nach Setup.*
