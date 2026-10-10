---
type: git-authentication
status: ANLEITUNG (Setup auf deinem PC erforderlich)
letztes-update: 2026-08-09
---

# 🔐 GitHub Authentication Setup für Git-Daily-Backup

**Problem:** Das `git-daily-commit.ps1` Script braucht GitHub-Authentifizierung, um zu pushen.  
**Lösung:** Personal Access Token ODER SSH-Key.

---

## ⚡ SCHNELLE LÖSUNG: Personal Access Token (5 Min)

### Schritt 1: GitHub Personal Access Token erstellen

1. Gehe zu: **https://github.com/settings/tokens**
2. Klick auf **"Generate new token"** → **"Generate new token (classic)"**
3. **Token name:** `memoria-vault-backup`
4. **Expiration:** Kein Ablaufdatum (oder 1 Jahr)
5. **Scopes (Berechtigungen) auswählen:**
   - ✓ `repo` (Vollständiger Zugriff auf Repositories)
   - ✓ `write:repo_hook` (Webhooks schreiben)
6. Klick **"Generate token"**
7. **COPY das Token!** (nur eine Chance zu sehen!)

---

### Schritt 2: Token in Git Config speichern (Windows PowerShell)

**Öffne PowerShell als Administrator** und führe aus:

```powershell
# Token hier einfügen (von GitHub kopiert)
$token = "ghp_XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
$repo = "https://github.com/joseflinder38-bit/memoria-vault.git"

# URL mit Token speichern
git remote set-url origin "https://joseflinder38-bit:$token@github.com/joseflinder38-bit/memoria-vault.git"

# Verifizieren (Token wird NICHT angezeigt!)
git remote -v
```

**Ausgabe sollte sein:**
```
origin  https://joseflinder38-bit:***@github.com/joseflinder38-bit/memoria-vault.git (fetch)
origin  https://joseflinder38-bit:***@github.com/joseflinder38-bit/memoria-vault.git (push)
```

---

### Schritt 3: Test – Git Push durchführen

```powershell
cd "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
git push origin master
```

**Sollte funktionieren ohne Password-Prompt!** ✓

---

## 🔒 SICHERE LÖSUNG: SSH-Key (10 Min, sauberer)

Falls du SSH bevorzugst (sicherer, kein Token abgelaufen):

### Schritt 1: SSH-Key generieren (einmalig)

```powershell
# PowerShell als Administrator öffnen
ssh-keygen -t rsa -b 4096 -f "C:\Users\josef\.ssh\id_rsa" -N ""
```

Das erstellt:
- `C:\Users\josef\.ssh\id_rsa` (privater Key)
- `C:\Users\josef\.ssh\id_rsa.pub` (öffentlicher Key)

### Schritt 2: Öffentlichen Key zu GitHub hinzufügen

```powershell
# Kopiere den öffentlichen Key
Get-Content "C:\Users\josef\.ssh\id_rsa.pub" | Set-Clipboard
```

Gehe zu: **https://github.com/settings/keys**
1. Klick **"New SSH key"**
2. **Title:** `Memoria Vault`
3. **Key type:** Authentication Key
4. **Key:** Paste (Ctrl+V)
5. **Add SSH key**

### Schritt 3: Remote von HTTPS zu SSH wechseln

```powershell
git remote set-url origin "git@github.com:joseflinder38-bit/memoria-vault.git"

# Verifizieren
git remote -v
```

### Schritt 4: Test

```powershell
cd "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
git push origin master
```

**Sollte ohne Prompt funktionieren!** ✓

---

## 🎯 WELCHE METHODE?

| Methode | Sicherheit | Aufwand | Empfehlung |
|---------|-----------|--------|------------|
| **Personal Access Token** | ⭐⭐⭐ | 5 Min | ✓ SCHNELL & EINFACH |
| **SSH-Key** | ⭐⭐⭐⭐⭐ | 10 Min | ✓ SAUBERER |
| **Credential Manager** | ⭐⭐⭐⭐ | 3 Min | ⚠️ Funktioniert nur interaktiv |

**Empfehlung:** SSH-Key ist die sicherste Lösung, aber Personal Access Token ist schneller.

---

## ✅ VERIFIZIERUNG – Token läuft?

Nach dem Setup:

```powershell
cd "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"

# Test: Commit + Push ohne Password-Prompt
git add .
git commit -m "Test: GitHub auth setup"
git push origin master
```

Falls erfolgreich: **Die nächste automatische Task wird auch funktionieren!** 🎉

---

## ⚠️ TROUBLESHOOTING

### "fatal: Authentication failed"
→ Token ist falsch/abgelaufen → Neues Token erstellen

### "fatal: could not read Username"
→ Token noch nicht konfiguriert → Schritt 2 nochmal machen

### SSH: "Permission denied (publickey)"
→ GitHub Key nicht hochgeladen → Schritt 2 (SSH) nochmal machen

---

## 📋 NÄCHSTER SCHRITT

Nach erfolgreicher Authentifizierung:
1. Das `git-daily-commit.ps1` Script läuft täglich um 21:00 Uhr
2. Alle Änderungen werden automatisch committed
3. GitHub wird automatisch aktualisiert ✓

**Questions?** Frag einfach! 💬

---

**Aktualisiert:** 2026-08-09  
**Status:** Anleitung für Benutzer zum manuellen Setup
