---
type: git-configuration
status: KONFIGURIERT (2026-07-25)
letztes-update: 2026-07-25
---

# 🔧 GIT SETUP – MEMORIA VAULT BACKUP

**Ziel:** Automatischer täglicher Backup des Memoria Vaults zu GitHub.

---

## ✅ BEREITS KONFIGURIERT

### Git Global Config
```bash
git config --global user.name "Josef Linder"
git config --global user.email "joseflinder38@gmail.com"
git config --global core.autocrlf true
git config --global core.safecrlf false
```
✓ Status: **AKTIV**

### GitHub Remote
```bash
origin  https://github.com/joseflinder38-bit/memoria-vault.git (fetch)
origin  https://github.com/joseflinder38-bit/memoria-vault.git (push)
```
✓ Status: **KONFIGURIERT**

### .gitignore
✓ Datei: `.gitignore` (Projekt-Root)
✓ Ignores:
- `.claudian/sessions/*.json` (Chat-Sessions)
- Backup-Dateien (*.bak, *.log)
- Node-modules, IDE-Config
- Large binaries (*.exe, *.iso, *.zip)

✓ Status: **COMMITTED**

---

## 📋 ZU TUN: WINDOWS TASK ERSTELLEN

Die PowerShell-Automatisierung ist vorbereitet, aber braucht **Admin-Rechte** zur Task-Registrierung.

### OPTION A: Automatisch (mit Admin)

**Wenn du Admin-Zugriff hast:**

```powershell
# PowerShell als Administrator öffnen und ausführen:
$scriptPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria\.claude\git-daily-commit.ps1"

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""
$trigger = New-ScheduledTaskTrigger -Daily -At 21:00
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest -LogonType ServiceAccount

Register-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -Principal $principal -TaskName "Memoria Git Daily Backup" -Description "Tägliches Git Backup zu GitHub"
```

### OPTION B: Manuell (Windows Task Scheduler GUI)

**Wenn keine PowerShell-Admin-Rechte:**

1. Öffne **Task Scheduler** (Windows-Taste + R → `taskschd.msc`)
2. Rechts: **"Create Basic Task..."**
3. **Name:** `Memoria Git Daily Backup`
4. **Trigger:** Täglich um 21:00 Uhr
5. **Action:** Start program
   - Program: `powershell.exe`
   - Arguments: `-NoProfile -ExecutionPolicy Bypass -File "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria\.claude\git-daily-commit.ps1"`
6. **Conditions:** Allow on batteries
7. **Settings:** 
   - Allow task to run on demand
   - Run with highest privileges
8. **Finish & Test:** Klick "Run" → Script sollte in `00 Inbox/GIT-BACKUP-LOG.txt` loggen

---

## 🧪 TEST: Script Manuell Ausführen

**Vor der Task-Registrierung:** Script testen

```powershell
# Als Administrator:
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
& "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria\.claude\git-daily-commit.ps1"
```

**Erwartetes Ergebnis:**
- ✓ Neue Zeilen in `00 Inbox/GIT-BACKUP-LOG.txt`
- ✓ `git log` zeigt neuen Commit
- ✓ GitHub Repo aktualisiert

---

## 📊 WORKFLOW: Täglicher Backup

```
21:00 Uhr (Windows Task startet)
  ↓
.claude/git-daily-commit.ps1 läuft
  ├─ git add . (alle Änderungen)
  ├─ git commit -m "Daily vault backup: 2026-07-25 21:00"
  ├─ git push origin master (zu GitHub)
  └─ Log: 00 Inbox/GIT-BACKUP-LOG.txt
  ↓
GitHub Repo aktualisiert ✓
```

---

## 🔐 AUTHENTIFIZIERUNG

### HTTPS (aktuell nutzbar)
Repo nutzt **HTTPS URL**: `https://github.com/joseflinder38-bit/memoria-vault.git`

**Problem:** HTTPS erfordert Personal Access Token oder Git Credentials bei jedem Push

**Lösung 1 (Windows Credential Manager):**
```powershell
# Windows Credential Manager öffnen
& "C:\Windows\System32\rundll32.exe" keyvault.dll,KBRunIEConfig

# Füge hinzu:
# - Generic credential für: git:https://github.com
# - Username: joseflinder38-bit
# - Password: [GitHub Personal Access Token]
```

**Lösung 2 (SSH - empfohlen):**
```bash
# SSH-Key generieren
ssh-keygen -t ed25519 -C "joseflinder38@gmail.com"

# Public-Key zu GitHub hinzufügen
# - GitHub → Settings → SSH Keys → New SSH key
# - Paste: ~/.ssh/id_ed25519.pub

# Remote URL ändern
git remote set-url origin git@github.com:joseflinder38-bit/memoria-vault.git

# Test
ssh -T git@github.com
```

---

## 🔍 DEBUGGING: Falls Backup Nicht Läuft

### 1. Prüfe Task Scheduler Status
```powershell
Get-ScheduledTask -TaskName "Memoria Git Daily Backup" | Select-Object State, LastRunTime, LastTaskResult
```

### 2. Prüfe Log-Datei
```powershell
Get-Content "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria\00 Inbox\GIT-BACKUP-LOG.txt" -Tail 20
```

### 3. Teste Script Manuell
```powershell
& "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria\.claude\git-daily-commit.ps1"
```

### 4. Häufige Fehler
| Fehler | Lösung |
|--------|--------|
| `fatal: not a git repository` | Script läuft in falscher Directory. Prüfe Pfad in `.ps1` |
| `fatal: could not read Username` | Authentifizierung fehlt. SSH-Key oder Token konfigurieren |
| `error: pathspec 'origin' did not match` | Git Remote nicht konfiguriert. Laufe `git remote add origin [URL]` |
| `fatal: the remote end hung up unexpectedly` | Netzwerk-Fehler. Internet-Verbindung prüfen |

---

## 📅 WARTUNG

### Logs Überprüfen
```bash
# Letzte 10 Backup-Logs
tail -10 "00 Inbox/GIT-BACKUP-LOG.txt"

# Letzte Commits überprüfen
git log --oneline -10
```

### GitHub Sync Überprüfen
```bash
# Remote aktuell?
git fetch origin
git status

# Lokale Commits nicht gepusht?
git log origin/master..master
```

### Alte Commits Aufräumen (optional)
```bash
# Alle Commits: 
git log --oneline | wc -l

# Nur wichtige behalten (für später):
git rebase -i HEAD~50
```

---

## 🚀 NÄCHSTE SCHRITTE

- [ ] PowerShell-Script testen (manuell ausführen)
- [ ] Windows Task Scheduler einrichten (Option A oder B)
- [ ] Authentifizierung konfigurieren (SSH empfohlen)
- [ ] Erste automatische Backup um 21:00 Uhr testen
- [ ] Log-Datei überprüfen

---

**Status:** ✅ Vorbereitet | ⏳ Task Registration (Admin erforderlich)

**GitHub Repo:** https://github.com/joseflinder38-bit/memoria-vault

**Kontakt für Fehler:** Git-Logs in `00 Inbox/GIT-BACKUP-LOG.txt`
