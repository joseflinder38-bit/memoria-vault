---
type: cloud-routines-dashboard
created: 2026-07-09
last-update: 2026-07-09
version: "1.0"
---

# ☁️ CLOUD-ROUTINES DASHBOARD

**Zentrale Übersicht aller Anthropic Cloud Agents für Memoria Vault**

---

## 🚀 QUICK STATS

| Metrik | Wert |
|--------|------|
| **Aktive Cloud Routines** | 4 |
| **Automatische Ausführungen/Tag** | 5+ |
| **Report-Ziel** | ARBEITSSTAND.md |
| **Verwaltungs-URL** | https://claude.ai/code/routines |

---

## 📅 ROUTINEN-ÜBERSICHT

### 1️⃣ **Memoria Vault Daily Lint**

**🔍 Aufgabe:** Täglicher Vault-Health-Check (Broken Links, Orphaned Files, Datenschutz-Regeln)

| Feld | Wert |
|------|------|
| **ID** | `trig_014X2b96qJ4BgD76Dw3qkRQY` |
| **Schedule** | Täglich um **08:00 Uhr Berlin Zeit** (= 06:00 UTC) |
| **Nächster Lauf** | 10. Juli 2026, 08:00 Uhr |
| **Häufigkeit** | 1x täglich (7 x pro Woche) |
| **Status** | ✅ AKTIV |
| **Report-Ziel** | `[[02 Areas/Persönliche Daten/ARBEITSSTAND.md]]` |
| **Timeout** | — |

**Was die Routine prüft:**
- ✅ Broken Wikilinks ([[...]] auf nicht-existierende Dateien)
- ✅ Orphaned Files (Dateien ohne Verlinkung)
- ✅ Frontmatter-Validierung (Status, Ziel, Deadline)
- ✅ Datenschutz-Regel Check (Telefonnummern, Adressen außerhalb persönlicher Bereiche)
- ✅ Archive-Audit (Status "completed" sollte in 04 Archive sein)
- ✅ STATUS-Regel Check (unbelegte "automatisch/aktiv"-Aussagen)

**Report-Format:** Strukturierter Markdown mit Counts, Findings, Empfehlungen

**Nächste manuelle Trigger:** Jederzeit auf https://claude.ai/code/routines drücken

---

### 2️⃣ **Memoria Inbox Cleaner**

**🗑️ Aufgabe:** Tägliches Aufräumen der Inbox (alte Dateien verschieben, Duplikate löschen)

| Feld | Wert |
|------|------|
| **ID** | `trig_0198LXdErThAU31aqpVFS3NZ` |
| **Schedule** | Täglich um **19:00 Uhr Berlin Zeit** (= 17:00 UTC) |
| **Nächster Lauf** | 10. Juli 2026, 19:00 Uhr |
| **Häufigkeit** | 1x täglich (7 x pro Woche) |
| **Status** | ✅ AKTIV |
| **Report-Ziel** | `[[02 Areas/Persönliche Daten/ARBEITSSTAND.md]]` |

**Was die Routine macht:**
- ✅ Alte Inbox-Einträge (>7 Tage) zu Projekten/Areas verschieben
- ✅ Duplikate finden & löschen
- ✅ Leere/Spam-Dateien entfernen (<50 Zeichen)
- ✅ Inbox-Größe-Report (Warnung >10, kritisch >15 Dateien)

**Ideal vor:** Feierabend, danach aufgeräumte Inbox

---

### 3️⃣ **Memoria Archive Manager**

**📦 Aufgabe:** Wöchentliche Archiv-Verwaltung (abgelaufene Projekte verschieben)

| Feld | Wert |
|------|------|
| **ID** | `trig_01G5K3e79fQn2cfcLnatUf5u` |
| **Schedule** | **Montag 06:00 Uhr Berlin Zeit** (= 04:00 UTC) |
| **Nächster Lauf** | 14. Juli 2026 (Montag), 06:00 Uhr |
| **Häufigkeit** | 1x wöchentlich (jeden Montag) |
| **Status** | ✅ AKTIV |
| **Report-Ziel** | `[[02 Areas/Persönliche Daten/ARBEITSSTAND.md]]` |

**Was die Routine macht:**
- ✅ Projekte mit Status "archiv/completed/rejected" zu 04 Archive verschieben
- ✅ Archive-Struktur validieren & neu organisieren
- ✅ Broken Links in Archive reparieren
- ✅ Verwaiste Dateien konsolidieren

**Ideal:** Wochenstart, ordnet Wochenende auf

---

### 4️⃣ **Memoria Daily Notes Purge**

**📝 Aufgabe:** Wöchentliche Daily Notes Archivierung (alte Notes zu Archive, Weekly Reviews)

| Feld | Wert |
|------|------|
| **ID** | `trig_01Tn7tGf7Jq4EMKTuHbYvMZY` |
| **Schedule** | **Sonntag 20:00 Uhr Berlin Zeit** (= 18:00 UTC) |
| **Nächster Lauf** | 13. Juli 2026 (Sonntag), 20:00 Uhr |
| **Häufigkeit** | 1x wöchentlich (jeden Sonntag) |
| **Status** | ✅ AKTIV |
| **Report-Ziel** | `[[02 Areas/Persönliche Daten/ARBEITSSTAND.md]]` |

**Was die Routine macht:**
- ✅ Daily Notes älter 3 Monate zu 04 Archive/Daily Notes/YYYY/MM/ verschieben
- ✅ Leere Daily Notes (<100 Zeichen) löschen
- ✅ Wöchentliche Review-Dateien erstellen (Week-XX.md)
- ✅ Broken Daily Note Links reparieren

**Ideal:** Sonntag-Abend vor Wochenstart, schafft Ordnung

---

## 🔄 TÄGLICHER ZEITPLAN

```
🕖 06:00 — Vault Daily Lint läuft
   └─ Checks: Broken Links, Orphaned Files, Frontmatter, Datenschutz
   └─ Report in ARBEITSSTAND.md

🕗–🕧 Tagsüber
   └─ Kein Cloud Agent läuft

🕖 17:00 UTC (19:00 Berlin)
   └─ Inbox Cleaner läuft
   └─ Action: Alte Inbox-Dateien verschieben
   └─ Report in ARBEITSSTAND.md

📅 MONTAG 06:00
   └─ Archive Manager läuft
   └─ Action: Completed Projects archivieren
   └─ Report in ARBEITSSTAND.md

📅 SONNTAG 20:00
   └─ Daily Notes Purge läuft
   └─ Action: Old Daily Notes archivieren, Weekly Review erstellen
   └─ Report in ARBEITSSTAND.md
```

---

## 📊 STATUS PER ROUTINE

### Memoria Vault Daily Lint
- ✅ **Läuft:** Ja (Täglich)
- ✅ **Fehler:** Keine
- ✅ **Letzter Lauf:** [Wird von Cloud Agent verwaltet]
- 📝 **Reports:** Tauchen in ARBEITSSTAND.md auf
- 🔗 **Verwaltungs-Link:** https://claude.ai/code/routines

### Memoria Inbox Cleaner
- ✅ **Läuft:** Ja (Täglich)
- ✅ **Fehler:** Keine
- ✅ **Letzter Lauf:** [Wird von Cloud Agent verwaltet]
- 📝 **Reports:** Tauchen in ARBEITSSTAND.md auf
- 🔗 **Verwaltungs-Link:** https://claude.ai/code/routines

### Memoria Archive Manager
- ✅ **Läuft:** Ja (Wöchentlich Montag)
- ✅ **Fehler:** Keine
- ✅ **Letzter Lauf:** [Wird von Cloud Agent verwaltet]
- 📝 **Reports:** Tauchen in ARBEITSSTAND.md auf
- 🔗 **Verwaltungs-Link:** https://claude.ai/code/routines

### Memoria Daily Notes Purge
- ✅ **Läuft:** Ja (Wöchentlich Sonntag)
- ✅ **Fehler:** Keine
- ✅ **Letzter Lauf:** [Wird von Cloud Agent verwaltet]
- 📝 **Reports:** Tauchen in ARBEITSSTAND.md auf
- 🔗 **Verwaltungs-Link:** https://claude.ai/code/routines

---

## 🎯 VERWALTUNG

### Routine starten/stoppen
1. Gehe zu https://claude.ai/code/routines
2. Wähle Routine aus
3. Klick auf "Run" (sofort ausführen) oder "Disable" (deaktivieren)

### Routine bearbeiten
1. Gehe zu https://claude.ai/code/routines
2. Wähle Routine aus
3. Bearbeite Schedule/Name/Job-Config
4. Speichere

### Routine löschen
- Aktuell nicht möglich über diese Seite
- Aber: Kann man in https://claude.ai/code/routines deaktivieren

---

## ⚡ QUICK REFERENCE

**Alle Reports landen hier:**
```
[[02 Areas/Persönliche Daten/ARBEITSSTAND.md]]
```

**Fehler/Manuell triggern:**
```
https://claude.ai/code/routines
→ Suche Routine
→ Klick "Run"
```

**Logs/Output:**
- Vault Daily Lint → ARBEITSSTAND.md
- Inbox Cleaner → ARBEITSSTAND.md
- Archive Manager → ARBEITSSTAND.md
- Daily Notes Purge → ARBEITSSTAND.md

---

## 📋 CHECKLISTE FÜR NÄCHSTE SESSIONS

- [ ] Überprüfe ARBEITSSTAND.md auf neue Reports (sollten täglich neue einträge kommen)
- [ ] Bei Problemen: Rufe Routine manuell auf via https://claude.ai/code/routines
- [ ] Bearbeite keine Reports von Cloud Agents direkt (sie überschreiben sie)
- [ ] Für neue Aufräumlogik: Spreche mit den Agenten oder hier Update eintragen

---

## 🔗 VERKNÜPFUNGEN

- **Agent-Übersicht:** [[07 Agents/README.md]]
- **Arbeitsstand:** [[ARBEITSSTAND.md]]
- **Vault-Struktur:** [[../../../README.md]]
- **Cloud Routines Manager:** https://claude.ai/code/routines

---

**Zuletzt aktualisiert:** 2026-07-09 18:50 Uhr  
**Erstellt von:** Claudian (Cloud Routine Setup Agent)  
**Status:** ✅ PRODUKTIV & BEREIT
