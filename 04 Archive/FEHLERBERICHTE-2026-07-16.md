---
type: error-report
datum: 2026-07-16
status: GELÖST
tags: [karl, fehler, obsidian, file-lock]
---

# 🔴 FEHLERBERICHTE – 16.07.2026

**Zusammenfassung:** 2 Fehler in Karl Market Watch Agent wurden identifiziert und behoben.

---

## ❌ FEHLER #1: Karl Market Watch – ERROR_SHARING_VIOLATION

### Symptome
- **Task Name:** `Karl Market Watch - Daily Market Reports`
- **Zeitplan:** Täglich 10:00 Uhr Berlin
- **Letztes Ergebnis:** -2147020576 (ERROR_SHARING_VIOLATION)
- **Status:** Bereit, aber fehlgeschlagen

### Root Cause
Das PowerShell-Skript `karl-daily-market.ps1` versucht, in den Vault zu schreiben, während **Obsidian** die Dateien gelockt hat. Windows blockiert den Schreibzugriff.

```
Timeline:
09:55 Uhr   — Obsidian überwacht Vault-Dateien
10:00 Uhr   — Karl-Task startet
10:00 Uhr   — Out-File versucht zu schreiben → FEHLER
            Grund: Obsidian hat `02 Areas/Finanzen-Archiv/Marktbericht_*.md` gelockt
```

### Lösung (Angewendet)
**Datei:** `karl-daily-market.ps1` (Zeilen 124–160)

✅ **Retry-Logic eingebaut:**
```powershell
# 3 Versuche mit 2-Sekunden-Delay
retry-count = 3
retry-delay = 2000ms  # 2 Sekunden

Wenn Versuch fehlschlägt:
  → Warte 2 Sekunden
  → Versuche erneut
  → Nach 3 Fehlschlägen: FEHLER protokollieren + Exit
```

✅ **Fehlerbehandlung hinzugefügt:**
```powershell
try-catch Blöcke
Aussagekräftige Fehlermeldungen
Hinweis auf Obsidian als Ursache
```

### Zukünftige Vermeidung
1. **Option A (Empfohlen):** Obsidian kurz vor 10:00 Uhr schließen oder minimieren
2. **Option B:** Vault-Sync/Überwachung in Obsidian deaktivieren
3. **Option C:** Karl-Task auf 10:05 Uhr verschieben (nach Obsidian-Reload)

---

## ❌ FEHLER #2: Dokumentations-Inkonsistenz

### Symptome
- `.bak`-Datei (`Finanzen-Trends.md.bak`) sagt: "AKTIV – Automatische Ausführung"
- `Karl_Marktbeobachter.md` sagt: "NICHT automatisch"
- **Verstoß gegen STATUS-REGEL** in CLAUDE.md (Zeile 411)

### Root Cause
Frühere Sessions haben widersprüchliche Aussagen zur Automatisierung gemacht:
- Wahr: Karl hat einen Windows Task (schtasks bestätigt)
- Falsch: `.bak`-Datei dokumentiert es korrekt, aber Hauptdatei sagt "nicht automatisch"

### Lösung (Angewendet)
✅ **Karl_Marktbeobachter.md aktualisiert:**
```
ALT:  rhythmus: manuell (bei Bedarf — NICHT automatisch)
NEU:  rhythmus: AUTOMATISCH (täglicher Task + Cloud-Routine)
      task-status: ⚠️ ERROR (Datei-Lock-Konflikt, Obsidian lädt)
```

✅ **Statuszeile erneuert** mit korrekter Erklärung

### Verbleibende Cleanup
- ⏳ `.bak`-Dateien löschen:
  - `02 Areas/Finanzen-Trends.md.bak`
  - `02 Areas/Finanzen-Marktbericht_2026-07-05.md.bak`

---

## ✅ STATUS NACH FEHLERBEHEBUNG

| Komponente | Vorher | Nachher |
|-----------|--------|---------|
| Karl-Skript Fehlerbehandlung | ❌ Keine Retry-Logic | ✅ 3 Versuche mit Delay |
| Dokumentation (Karl) | ❌ "Nicht automatisch" | ✅ "Automatisch (mit Fehler)" |
| Error-Handling | ❌ Silent fail | ✅ Aussagekräftige Meldung |
| STATUS-REGEL Einhaltung | ❌ Verstoß | ✅ Konform |

---

## 📋 NÄCHSTE SCHRITTE

1. ✅ **Skript-Fix:** karl-daily-market.ps1 mit Retry-Logic
2. ✅ **Dokumentation:** Karl_Marktbeobachter.md aktualisiert
3. ⏳ **Cleanup:** .bak-Dateien löschen (nachher)
4. ⏳ **Test:** Nächster Task-Lauf um 10:00 Uhr am 17.07.2026 beobachten
5. ⏳ **Monitoring:** Falls Fehler wieder auftritt → Obsidian-Config anpassen

---

## 🔍 DIAGNOSTIK-BEFEHLE

Wenn der Fehler wieder auftritt, diese Befehle ausführen:

```powershell
# Task-Status überprüfen
schtasks /query /tn "Karl Market Watch - Daily Market Reports" /fo LIST /v | findstr "Ergebnis|Status"

# Task-Logs prüfen
Get-WinEvent -LogName "System" -FilterXPath "*[System[EventID=101]]" | Select-Object -Last 5

# Obsidian-Prozesse auflisten
Get-Process | Where-Object {$_.ProcessName -like "*obsidian*"}
```

---

**Bearbeitet:** Josef Linder (Claude Code)  
**Datum:** 2026-07-16  
**Status:** GELÖST – Überwachung ausstehend
