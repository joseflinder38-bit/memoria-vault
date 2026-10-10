---
type: vault-automation
name: Vault Daily Health Check Agent
status: aktiv
datum-setup: 2026-07-05
---

# 🔍 Vault Daily Health Check Agent

**Automatischer täglicher Vault-Überwachungsagent**

---

## 📋 Übersicht

| Eigenschaft | Wert |
|-------------|------|
| **Name** | Vault Daily Health Check |
| **Typ** | Windows Task Scheduler |
| **Zeitplan** | Täglich 06:00 Uhr (Berlin) |
| **Status** | ✅ AKTIV |
| **Skript** | `vault-daily-health-check.ps1` |
| **Berichte** | `00 Inbox/VAULT-DAILY-HEALTH_*.md` |
| **Alerts** | `00 Inbox/⚠️-VAULT-ALERT-*.md` |

---

## 🎯 Aufgaben

Die Routine überprüft täglich:

### 1️⃣ Duplikate suchen
- Findet doppelte Dateien (außer System-Dateien)
- **Status:** 🔴 KRITISCH wenn gefunden

### 2️⃣ Inbox-Kontrolle
- Prüft Anzahl der Dateien in `00 Inbox`
- ⚠️  Warnung: >10 Dateien
- 🔴 Kritisch: >15 Dateien

### 3️⃣ Leere Ordner
- Sucht nach leeren Nutzer-Ordnern (nicht System)
- ⚠️  Warnung: >2 leere Ordner

### 4️⃣ PARA-Struktur
- Überprüft Existenz aller 8 Hauptordner
- 🔴 KRITISCH wenn Ordner fehlen

### 5️⃣ Dateitypen
- Prüft Anteil von Markdown-Dateien
- ⚠️  Warnung: <40% Markdown

---

## 📊 Report-Format

Jeden Tag wird ein Report generiert:

```
Dateiname: VAULT-DAILY-HEALTH_YYYY-MM-DD.md
Speicherort: 00 Inbox/
Format: Markdown
Inhalt:
  - Datum/Uhrzeit
  - Gesamtstatus (GESUND/WARNUNG/KRITISCH)
  - Score: 0-10
  - Detaillierte Analyse
  - Empfehlungen
```

### Beispiel-Report:
```markdown
# 📊 VAULT DAILY HEALTH CHECK

**Datum:** 2026-07-05 06:00:00
**Status:** WARNUNG ⚠️
**Score:** 7/10

## KRITISCHE PROBLEME (0)
Keine kritischen Probleme gefunden ✅

## WARNUNGEN (1)
- ⚠️  Inbox hat 12 Dateien (sollte unter 10 sein)

## POSITIVE BEFUNDE
- ✅ PARA-Struktur intakt
- ✅ Alle Hauptordner vorhanden
```

---

## 🚨 Alert-System

### Normale Reports
- Täglich in `00 Inbox/VAULT-DAILY-HEALTH_*.md`
- **Zu Beginn eurer Session sichtbar**

### Kritische Alerts 🔴
Bei kritischen Problemen:
1. Report wird generiert
2. **Alert-Datei** wird erstellt: `⚠️-VAULT-ALERT-YYYY-MM-DD.md`
3. Exit-Code 1 (Fehler)
4. **Sichtbar in Obsidian** als rote Warnungsdatei

**Kritische Probleme:**
- ❌ Duplikate gefunden
- ❌ PARA-Ordner fehlen
- ❌ Inbox >15 Dateien

---

## ⚙️ Konfiguration

### Windows Task Details:
```
Name:     Vault Daily Health Check
Auslöser: Täglich 06:00 Uhr
Aktion:   powershell.exe -NoProfile -ExecutionPolicy Bypass -File vault-daily-health-check.ps1
Benutzer: Admin
Status:   Bereit
```

### Skript-Parameter:
```powershell
-VaultPath "."  # Vault-Verzeichnis
-ReportPath "00 Inbox"  # Report-Speicherort
```

### Zu Beginn eurer Session:
```
06:00 → Health Check lädt
06:02 → Report/Alert in 00 Inbox sichtbar
→ Ihr seht sofort, ob Probleme vorliegen!
```

---

## 📝 Reports-Übersicht

### Letzte 7 Tage:
```
00 Inbox/VAULT-DAILY-HEALTH_2026-07-05.md  ✅ GESUND
00 Inbox/VAULT-DAILY-HEALTH_2026-07-04.md  ⚠️  WARNUNG
00 Inbox/VAULT-DAILY-HEALTH_2026-07-03.md  ✅ GESUND
...
```

### Archive (älter als 30 Tage):
Reports werden in `04 Archive/Vault-Health-Reports/` verschoben

---

## 🔧 Manuell Starten

Wenn du sofort einen Health Check möchtest:

```powershell
# Terminal öffnen in Vault-Verzeichnis
powershell -NoProfile -ExecutionPolicy Bypass -File vault-daily-health-check.ps1

# Oder im 00 Inbox einen neuen Report
.\vault-daily-health-check.ps1
```

---

## 📚 Integration mit anderen Agenten

| Agent | Verbindung zu Health Check |
|-------|---------------------------|
| **Karl Market Watch** | Unabhängig (06:00 vs. 10:00) |
| **Bewerbungs-Tracking** | Nutzt Inbox für Dokumente |
| **Freelance-Projekte** | Prüft Ordnerstruktur |
| **Tagesroutine** | Sieht Vault-Alerts |

---

## 📅 Wartungsplan

| Zeitraum | Aufgabe |
|----------|---------|
| **Täglich** | Health Check automatisch 06:00 Uhr |
| **Wöchentlich** | Reports überprüfen (Alerts beachten) |
| **Monatlich** | Alte Reports in Archive verschieben |
| **Halbjährlich** | Skript-Optimierung prüfen |

---

## 🚀 Zukünftige Erweiterungen

- [ ] Automatische Cleanup bei kritischen Problemen
- [ ] Email-Benachrichtigung bei Alerts
- [ ] Detaillierte Trend-Analyse (Health-Score über Zeit)
- [ ] Automatische Inbox-Archivierung (>20 Tage alt)
- [ ] Integration mit Obsidian Dashboard

---

**Setup-Datum:** 2026-07-05  
**Version:** 1.0  
**Status:** ✅ PRODUKTIV

---

## 📞 Wichtige Links

- 📁 Reports: `[[00 Inbox]]`
- 📊 Health Checks: `VAULT-DAILY-HEALTH_*.md`
- 🚨 Alerts: `⚠️-VAULT-ALERT-*.md`
- 🔧 Skript: `vault-daily-health-check.ps1`
- 📝 Dieser Guide: `[[Vault-Health-Check-Agent]]`
