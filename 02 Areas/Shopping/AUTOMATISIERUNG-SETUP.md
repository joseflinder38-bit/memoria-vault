---
type: setup-anleitung
agent: Max
automatisierung: Kopfhörer-Preisrecherche
status: bereit-zum-aufbau
letztes-update: 2026-07-06
---

# ⚙️ Max – Kopfhörer-Automatisierung SETUP-ANLEITUNG

**Ziel:** Tägliche automatische Kopfhörer-Preisrecherche um 14:00 Uhr

**Status:** ✅ Script fertig → PowerShell-Script unter `scripts/max-kopfhoerer-daily.ps1`

---

## 🚀 SCHRITT-FÜR-SCHRITT AUFBAU

### SCHRITT 1: Ordner & Script überprüfen

**Stelle sicher, dass folgende Dateien existieren:**

```
C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\
├── scripts/
│   └── max-kopfhoerer-daily.ps1  ✅ (gerade erstellt)
└── 02 Areas/
    └── Shopping/
        ├── README.md
        ├── Kopfhörer-Preise_INDEX.md
        └── AUTOMATISIERUNG-SETUP.md (diese Datei)
```

**Test:**
```powershell
Test-Path "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\scripts\max-kopfhoerer-daily.ps1"
# Sollte: True zurückgeben
```

---

### SCHRITT 2: PowerShell Execution Policy (falls nötig)

Damit PowerShell das Script ausführen darf:

```powershell
# Öffne PowerShell als Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Bestätige mit 'Y' (Ja)
```

**Nur nötig wenn bisher keine PS-Scripts erlaubt waren.**

---

### SCHRITT 3: Windows Task Scheduler aufsetzen

**Öffne Task Scheduler:**
```
Windows-Start → Task Scheduler (oder: taskschd.msc)
```

**Neue Task erstellen:**

```
1. Rechtsklick auf "Task Scheduler Library"
   → "Create Basic Task"

2. Name: 
   "Max - Kopfhörer-Preisrecherche"

3. Beschreibung:
   "Tägliche automatische Preisrecherche für In-Ear Kopfhörer (Amazon DE/EU)"

4. Trigger (Zeitplan):
   - Täglich
   - Startzeiit: 14:00:00
   - Wiederholen: Jeden Tag
   - Dauer: Unbegrenzt

5. Aktion:
   - Programm/Skript: powershell.exe
   - Argumente:
     -ExecutionPolicy Bypass -File "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\scripts\max-kopfhoerer-daily.ps1"

6. Bedingungen (optional):
   - ☐ Nur wenn Computer im Leerlauf
   - ☑ Starten, auch wenn Benutzer nicht angemeldet

7. Einstellungen:
   - ☑ Task sofort starten, wenn planmäßige Zeit verpasst
   - ☑ Weitere Instanz nicht starten, wenn noch eine läuft
   - Zeitlimit: 30 Minuten
```

**Speichern & Aktivieren:**
```
"Finish" → Task wird aktiv
```

---

### SCHRITT 4: Task testen

**Manuell ausführen (zur Kontrolle):**

```powershell
# Terminal öffnen (als Admin nicht nötig)
& "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\scripts\max-kopfhoerer-daily.ps1"

# Sollte folgende Ausgabe zeigen:
# [2026-07-06 14:23:45] [INFO] ════════════════════════════════════════════════════════════
# [2026-07-06 14:23:45] [INFO] MAX – Tägliche Kopfhörer-Preisrecherche (AUTOMATISCH)
# ...
# [2026-07-06 14:23:50] [SUCCESS] ✅ Tägliche Automatisierung abgeschlossen!
```

**Überprüfe ob die Datei erstellt wurde:**

```powershell
Get-ChildItem "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\02 Areas\Shopping" -Filter "Kopfhörer-Preise_*.md"

# Sollte zeigen: Kopfhörer-Preise_2026-07-06.md (oder heutiges Datum)
```

---

### SCHRITT 5: Task-Scheduler-Auftrag überprüfen

```powershell
# Prüfe ob Task aktiv ist
Get-ScheduledTask -TaskName "Max - Kopfhörer-Preisrecherche" | Select-Object State

# Sollte zeigen: State : Ready
```

---

## ✅ FERTIG!

**Ab morgen um 14:00 Uhr:**
```
14:00:00 → Task startet automatisch
  ↓
  → powershell.exe führt Script aus
  ↓
  → max-kopfhoerer-daily.ps1 recherchiert Preise
  ↓
  → Neue Datei: 02 Areas/Shopping/Kopfhörer-Preise_2026-07-07.md
  ↓
  → INDEX wird referenziert
  ↓
  → Du siehst neue Preise am nächsten Tag
```

---

## 🔧 TROUBLESHOOTING

### Problem: Script führt nicht aus

**Lösung 1: Execution Policy**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Lösung 2: Pfade überprüfen**
```powershell
Test-Path "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\scripts\max-kopfhoerer-daily.ps1"
# Muss True sein
```

**Lösung 3: Task Scheduler Logs**
```
Task Scheduler → Wähle Task → "History" Tab
→ Schau die letzten Events an (Fehler sind rot markiert)
```

---

### Problem: Keine neue Datei wird erstellt

**Überprüfe Schreibberechtigung:**
```powershell
Test-Path "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\02 Areas\Shopping"
# Muss True sein

# Versuche zu schreiben
"Test" | Out-File -FilePath "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\02 Areas\Shopping\test.txt"
# Sollte ohne Fehler speichern
```

---

## 📊 MANUELLE ALTERNATIVE (wenn Task fehlschlägt)

Falls die automatische Aufgabe Probleme macht, kannst du Max auch **manuell täglich aufrufen**:

```
"Max, recherchiere aktuelle Kopfhörer-Preise für:
- Soundcore Liberty 4 NC
- CMF Buds Pro 2
- JBL Tune Beam 2
- Sony WF-1000XM6
- Samsung Galaxy Buds 3 Pro

Speichere als: 02 Areas/Shopping/Kopfhörer-Preise_[HEUTE].md"
```

---

## 🔗 Verknüpfungen

→ [[02 Areas/Shopping/README]]
→ [[02 Areas/Shopping/Kopfhörer-Preise_INDEX]]
→ [[01 Projects/Kopfhörer-Recherche/Kopfhörer-Vergleich_2026]]
→ [[07 Agents/Max_Preisvergleich]]

---

**Setup-Status:** ✅ BEREIT
**Nächste Schritte:** Task Scheduler einrichten (ca. 5 Min)
**Erstes automatisches Run:** 2026-07-07 14:00 Uhr
