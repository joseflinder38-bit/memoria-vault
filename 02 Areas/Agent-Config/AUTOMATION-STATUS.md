---
type: automation-dashboard
version: "2.0"
letztes-update: 2026-10-10
---

# 🤖 AUTOMATION STATUS DASHBOARD

**Verifiziert live am 2026-10-10 — jeder Status hier basiert auf einem echten `Get-ScheduledTaskInfo`-Aufruf und Log-Dateiprüfung, nicht auf Vermutung (siehe [[02 Areas/Agent-Config/GLOBAL-RULES.md]] Automation-Status-Regel).**

---

## ✅ Alle Windows Task Scheduler Tasks (Stand 2026-10-10, 16:18 Uhr)

| Task | Zeitplan | Status | Nachweis |
|---|---|---|---|
| `Memoria-Daily-Note-Creation` | täglich 06:00 | ✅ AKTIV | LastTaskResult 0, Daily Notes werden erstellt |
| `Memoria-Rainer-Maintenance` | täglich 08:00 | ✅ AKTIV | LastTaskResult 0, Vault-Export wird erstellt |
| `Memoria-Vault-Maintenance` | täglich 06:00 | ✅ AKTIV (repariert 2026-10-10) | LastTaskResult 0, `vault-health-log.txt` wird befüllt |
| `Memoria-Git-AutoBackup` | alle 10 Min | ✅ AKTIV (repariert 2026-10-10) | LastTaskResult 0, echte Commits + Pushes verifiziert |
| `Memoria-Nina-Scout-Daily` | täglich 06:15 | ✅ AKTIV (repariert 2026-10-10) | LastTaskResult 0, `Jobsuche-*.md` wird erstellt |

**Karl Market Watch:** Läuft laut Nutzerangabe täglich über eine Claude Cloud Routine (nicht über lokalen Task Scheduler, daher hier nicht per `schtasks` verifizierbar).

**Dataview Dashboards** (Bewerbungen, Kunden-Pipeline, Finanzen): On-Demand, kein Scheduler nötig — Status unverändert ✅ vorhanden, Aktualität der Inhalte nicht separat geprüft.

---

## 🔧 Was am 2026-10-10 repariert wurde (vorher: 2+ Monate durchgehend kaputt)

### 1. Git-Authentifizierung (Kernproblem seit mind. August)
- **Ursache:** Git Credential Manager (`credential.helper=manager`) verlangt interaktiven Login-Popup → hängt in jeder Hintergrund-Automation für immer. Remote war zwischenzeitlich auf SSH umgestellt, aber nie ein SSH-Key eingerichtet.
- **Fix:** GitHub Personal Access Token + `credential.helper=store` (kein Popup, nie wieder Login nötig). Remote zurück auf HTTPS.
- **Zusatzfund:** Kaputte globale `credential.helper=manager-core` Config (Phantom-Binary) hat zusätzlich blockiert → entfernt.

### 2. Sicherheitsproblem: Ausweisdokumente in Git-Historie
- **Ursache:** Frühere Session hat per `git add -A` versehentlich Personalausweis- und Führerschein-Scans eingecheckt. Da nie erfolgreich gepusht wurde, war nichts öffentlich sichtbar.
- **Fix:** Komplett neue, saubere Git-Historie (`clean-start` → `master`) ohne diese Dateien. `.gitignore` schützt jetzt dauerhaft `Ausweise/` und `Sensible Dokumente*/`.

### 3. Kaputte `.git/HEAD` durch iCloud-Sync-Konflikt
- **Ursache:** Schnell aufeinanderfolgende Git-Befehle haben einen iCloud-Sync-Konflikt ausgelöst → `.git/HEAD` wurde zu `HEAD 2` umbenannt, Original fehlte. Git erkannte das Repo danach gar nicht mehr.
- **Fix:** `HEAD 2` zurück auf `HEAD` umbenannt. **Strukturelles Risiko bleibt bestehen** (siehe unten).

### 4. Vault-Maintenance Task: Relativer Pfad
- **Ursache:** Task-Aktion nutzte `-File "02 Areas\...\vault-maintenance.ps1"` ohne Arbeitsverzeichnis → Skript nie gefunden.
- **Fix:** Absoluter Pfad + `WorkingDirectory` gesetzt.

### 5. Nina-Scout-Daily Task: Umlaut-Verstümmelung im Task-Pfad selbst
- **Ursache:** Task-Registrierung enthielt `Persoenliche` statt `Persönliche` (ASCII-Fallback-Problem bei Task-Scheduler-Erstellung mit Umlauten — das Script selbst hatte dafür schon einen Workaround, der Task-Pfad selbst aber nicht).
- **Fix:** Task-Aktion mit korrektem Umlaut (über Zeichencode `[char]0x00F6` konstruiert) neu gesetzt.

### 6. Git-AutoBackup Task: Falsche Anführungszeichen
- **Ursache:** Task-Argumente nutzten einfache Anführungszeichen (`'...'`) um den Pfad — Windows' Kommandozeilen-Parser erkennt nur doppelte (`"..."`) für Pfade mit Leerzeichen.
- **Fix:** Auf doppelte Anführungszeichen korrigiert.

### 7. Fehlplatzierte Spieledateien
- `FRONTEND/`, `GLOBAL/`, `server.dll` (Reste von NFS Most Wanted aus einer Gaming-Session) lagen im Vault-Root und wurden mitversioniert. Jetzt entfernt + gitignored.

---

## ✅ Behoben (2026-10-10, direkt im Anschluss): Git-Repo aus iCloud-Sync-Ordner verlegt

Der `.git`-Ordner (1097 Dateien, 79 MB) lag innerhalb von iCloud Drive und hat genau deshalb den `HEAD`-Sync-Konflikt verursacht (Fund #3 oben). Fix:
- Echte Git-Daten per robocopy nach `C:\Users\josef\.git-data\Memoria.git\` verschoben (außerhalb jeder Cloud-Sync)
- Im Vault liegt jetzt nur noch eine winzige `.git`-Verweisdatei (60 Bytes: `gitdir: C:/Users/josef/.git-data/Memoria.git`) — die kann iCloud gefahrlos synchronisieren, da sie keine interne Struktur hat, die kollidieren könnte
- Live getestet: `Memoria-Git-AutoBackup` lief danach automatisch durch und committete/pushte korrekt (`58b7cd2 Auto-backup 2026-10-10 16:22:13`)

**Hinweis für die Zukunft:** Falls der Vault jemals auf einen anderen Rechner umzieht, muss `C:\Users\josef\.git-data\Memoria.git\` mit umgezogen werden (liegt bewusst außerhalb des iCloud-Vaults, wird also NICHT automatisch mitsynchronisiert). Bei Bedarf einfach erneut `git clone` vom GitHub-Remote statt manuellem Kopieren.

---

## 📍 Nächste Verifikation

Prüfe in 24h, ob die reparierten Tasks auch bei automatischem (nicht manuell angestoßenem) Lauf durchlaufen:
```powershell
Get-ScheduledTask | Where-Object { $_.TaskName -match "Memoria" } | Get-ScheduledTaskInfo | Select-Object TaskName, LastRunTime, LastTaskResult
```
`LastTaskResult` muss `0` sein. Jeder andere Wert = erneut kaputt — dann bitte nicht einfach wieder als "läuft" dokumentieren, sondern den echten Fehler diagnostizieren (Log-Datei prüfen, Skript manuell ausführen).
