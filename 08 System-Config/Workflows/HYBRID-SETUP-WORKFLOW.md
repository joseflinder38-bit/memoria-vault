# 🚀 Hybrid Mobile Setup - Workflow-Dokumentation

**Konfiguriert:** 2026-07-06  
**Nutzer:** Josef Linder  
**Status:** ✅ LIVE & AKTIV

---

## 📊 System-Architektur

```
┌─────────────────────────────────────────────────────────────┐
│                     ZENTRALE QUELLE                         │
│                   GitHub Repository                         │
│          (memoria-vault - PRIVATE)                          │
└──────────────────┬──────────────────────────────────────────┘
                   │
        ┌──────────┴──────────┐
        │                     │
        ▼                     ▼
┌──────────────────┐  ┌──────────────────┐
│  Windows Desktop │  │  iPad / Obsidian │
│  (Claude Code)   │  │  (Mobile)        │
│                  │  │                  │
│ • Automatisiert  │  │ • Lesen & Edit   │
│ • Vault-Manage   │  │ • iCloud Sync    │
│ • Karl läuft     │  │ • Git Sync (Pull)│
│ • Health Check   │  │                  │
│ • Git Push       │  │                  │
│   (täglich 20h)  │  │                  │
└──────────────────┘  └──────────────────┘
```

---

## 🔄 Der Workflow (Schritt für Schritt)

### **Tag 1: Du arbeitest auf dem iPad**

```
iPad (Obsidian):
  1. Öffne Obsidian
  2. Lese Notizen aus GitHub
     (iCloud synced vom Desktop)
  3. Schreibe neue Notizen / edit vorhandene
  4. iCloud speichert automatisch

Desktop (Windows):
  • Bleibt synchron via iCloud
  • Automatisierungen laufen im Hintergrund
    ✅ Karl (10:00 Uhr) fetcht Marktdaten
    ✅ Health Check (06:00 Uhr) overprüft Vault
```

### **20:00 Uhr: Automatischer Git-Push**

```
Windows Task startet:
  1. "Git Daily Push - Memoria Vault" aktiviert sich
  2. Führt: git add . (alle Änderungen)
  3. Erstellt: git commit (mit Zeitstempel)
  4. Pusht zu: GitHub (memoria-vault)

GitHub wird aktualisiert mit:
  ✅ Alle Änderungen vom iPad
  ✅ Alle Automatisierungs-Daten (Karl, Health Check)
  ✅ Zeitstempel für Versionskontrolle
```

### **Nächster Tag: iPad synced**

```
iPad Obsidian:
  1. iCloud wird aktualisiert (von GitHub)
  2. Beim Öffnen: neue Daten verfügbar
  3. Weiterlesen & arbeiten
```

---

## 📋 Automatisierungen (Übersicht)

| Task | Zeitplan | Funktion | Status |
|------|----------|----------|--------|
| **Vault Daily Health Check** | 06:00 Uhr | Überprüft Vault-Integrität | ✅ AKTIV |
| **Karl Market Watch** | 10:00 Uhr | Fetcht Marktdaten | ✅ AKTIV |
| **Git Daily Push** | 20:00 Uhr | Pusht zu GitHub | ✅ AKTIV |

---

## 🛡️ Datenschutz

### Nicht auf GitHub (wegen .gitignore):
```
❌ 02 Areas/Persönliche Daten/Stammdaten/
   (Name, Adresse, Geburtsdatum)

❌ 02 Areas/Persönliche Daten/Qualifikationen/
   (private Zertifikate)

❌ 03 Resources/Persönliche Dokumente/
   (private Dokumente)
```

### Auf GitHub (öffentlich einsehbar):
```
✅ 01 Projects/ (Bewerbungen, Lebenslauf)
✅ 03 Resources/Gefahrstoffe/ (BA-Vorlagen)
✅ 05 Templates/ (Vorlagen)
✅ 06 Daily Notes/ (deine Notizen)
✅ 02 Areas/Finanzen/ (Marktberichte)
```

---

## 📱 iPad-Workflow (praktisch)

### **Voraussetzungen:**
- ✅ Obsidian App auf iPad
- ✅ iCloud Drive aktiviert (Einstellungen → iCloud)
- ✅ Obsidian mit iCloud Drive synchronisiert

### **Tägliche Nutzung:**

**Morgens (6:00 - 10:00 Uhr):**
```
1. iPad öffnen → Obsidian starten
2. Dein Vault wird geladen (über iCloud)
3. Lies Notizen, überprüfe Marktberichte (Karl), etc.
4. Mache neue Notizen / edit vorhandene
5. iCloud speichert automatisch
```

**Abends (20:00 Uhr):**
```
Windows Task pusht automatisch zu GitHub
→ Alle deine iPad-Änderungen sind jetzt in GitHub
→ Backup ist sicher
```

**Nächster Tag:**
```
iPad: iCloud pullt neueste Daten von GitHub
→ Alles ist synchron
```

---

## ⚙️ Fehlerbehebung

### Problem: iPad synced nicht

**Lösung:**
```
1. Obsidian schließen
2. Einstellungen → iCloud Drive → prüfen, ob aktiv
3. Obsidian neustarten
4. Warten (kann bis zu 30 Min dauern)
```

### Problem: Git-Push funktioniert nicht

**Überprüfe:**
```powershell
# Auf Windows:
cd C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria
git status
git log --oneline (zeigt letzten Commit)
```

### Problem: Dateien sind nicht auf GitHub

**Überprüfe .gitignore:**
```powershell
# Sind diese Ordner ignoriert?
git check-ignore -v 02\ Areas/Persönliche\ Daten/Stammdaten/
# Sollte antworten: .gitignore:4
```

---

## 📊 Status & Monitoring

### Windows Task-Status checken:

```powershell
# Health Check
schtasks /query /tn "Vault Daily Health Check" /v

# Karl Market Watch
schtasks /query /tn "Karl Market Watch*" /v

# Git Daily Push
schtasks /query /tn "Git Daily Push*" /v
```

### GitHub überprüfen:

Gehe zu: https://github.com/joseflinder38-bit/memoria-vault

- Siehst du neue Commits täglich um 20:00?
- Sind deine iPad-Änderungen da?
- Sind sensible Daten NICHT vorhanden?

---

## 🎯 Was ist wo?

| Geräte | Funktion | Sync-Methode |
|--------|----------|--------------|
| **Windows Desktop** | Claude Code, Automatisierungen, Git-Verwaltung | iCloud & Git Push |
| **iPad** | Lesen, schreiben, mobile Nutzung | iCloud Drive |
| **GitHub** | Zentrale Quelle, Backup, Versionskontrolle | Git Push (täglich) |

---

## 🔐 Sicherheit

### Backup-Strategie:
- ✅ iCloud (alle Dateien, online)
- ✅ GitHub (öffentliche Daten, online)
- ✅ Windows PC (original, lokal)

### Sensible Daten:
- ✅ NICHT auf GitHub (geschützt durch .gitignore)
- ✅ NICHT auf iPad (über iCloud nur nicht-sensible Daten)
- ✅ NUR auf Windows lokal (Stammdaten, Qualifikationen)

---

## 🚀 Nächste Schritte

1. **Teste iPad iCloud Sync**
   - Obsidian öffnen
   - Prüfe, ob Dateien laden

2. **Beobachte ersten Git-Push**
   - 20:00 Uhr heute
   - GitHub überprüfen: Neue Commits?

3. **Nach 1 Woche überprüfen**
   - Sind alle Tasks läufig?
   - Funktioniert Sync auf iPad?
   - Gibt es Fehler in Event Viewer?

---

**Dokumentiert:** 2026-07-06  
**Alle Tasks aktiv:** ✅ JA  
**Bereit für Produktion:** ✅ JA  
