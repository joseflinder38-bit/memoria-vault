---
type: global-rules
version: "2.0"
letztes-update: 2026-07-25
---

# 📋 GLOBALE REGELN

**Bindende Richtlinien für alle Agenten, Reports, Exports und Vault-Operationen.**

---

## 🔐 DATENSCHUTZ-REGEL

In **KEINEM** Scan, Report, Export oder Log dürfen folgende Daten erscheinen:

### ❌ NICHT ERLAUBT:
- Telefonnummern
- Adressen (vollständig)
- Geburtsdaten
- Ausweisdaten (Personalausweis-Nummern, Führerschein-Nummern, etc.)
- Inhalte aus `02 Areas/Persönliche Daten/` und `03 Resources/Persönliche Dokumente/`

### ✅ ERLAUBT:
- Ordnernamen: "02 Areas/Persönliche Daten/ vorhanden" ✓
- Allgemeine Kategorien: "Zertifikate: 7 Dateien" ✓
- Archiv-Status: "Archive/Für Henry/: 5 Dateien" ✓
- Zertifikatstitel (z.B. "TRGS 519/521 Trainer") ohne Nummern/Gültigkeitsdatum

### 📌 GILT FÜR:
- Alle Agenten (Henry, Tim, Brian, Rainer, Karl, Nina, Vera, etc.)
- Alle Reports und Scans
- Alle Exports und Logs
- Alle Vault-Status-Dateien

---

## ⚙️ AUTOMATION-STATUS-REGEL

**"Automatisch", "aktiv", "läuft", "2x täglich" — diese Begriffe darf KEINE Agent-Datei oder Report enthalten, ohne dass eine entsprechende Task-Scheduler-Aufgabe nachgewiesen wurde.**

### Gültige Aussagen (mit schtasks-Nachweis):

```
❌ FALSCH:
"Agent läuft täglich 08:00 Uhr"  (kein Nachweis)

✅ RICHTIG:
"Agent läuft täglich 08:00 Uhr (schtasks zeigt Task 'ClaudeCode_Nina_Scout')"
```

### Fallback bei fehlendem Nachweis:

```
Status: GEPLANT – Implementierung ausstehend
ODER
Aktivierungsmethode: Manuell bei Bedarf
ODER
Hinweis: Automatische Ausführung noch nicht eingerichtet
```

### Verifizierung vor jedem Report/Export:

```powershell
schtasks /query /fo LIST /v | findstr /i "claude|rainer|nina|karl|vera"
```

**Ergebnis-Interpretation:**
- ✅ Task vorhanden → "Status: AKTIV" ist erlaubt
- ❌ Keine Ausgabe → Status muss "GEPLANT" oder "MANUELL" sein

### 📌 GILT FÜR:
- Agenten-Status-Dateien
- Reports über Automation-Status
- CLAUDE.md und alle Agent-Dokumentation
- Vault-Übersichts-Dateien

---

## 📊 MESSUNGS-REGEL

**Jede Zählung, Größe oder Messung muss einen echten Befehl haben.**

### ❌ NICHT ERLAUBT:

```
Vault-Struktur: ✅ Checksum OK (116 Dateien)
Status: 🟢 Organisiert
07 Agents: 8 Agenten ← Kein Befehl, nur Zählung!
```

### ✅ ERLAUBT (mit Befehl + Rohausgabe):

```powershell
BEFEHL:
Get-ChildItem -Path "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria" -Recurse -File | Measure-Object

ROHAUSGABE:
Count    : 116

BEFUND:
116 Dateien insgesamt, verteilt auf 11 Ordner.
03 Resources: 36 (größter Ordner)
```

### Format für Reports:

1. **Befehl angeben** (PowerShell/Bash/Git)
2. **Rohausgabe zeigen** (ungekürzt)
3. **Interpretation/Befund** schreiben
4. **Keine Emojis/Tilden** ohne Beleg

### 📌 GILT FÜR:
- Vault-Struktur-Reports
- Agent-Statistiken
- Datei-Zählungen
- Performance-Messungen
- Alle Scan-Ergebnisse

---

## 📝 BEISPIELDATEN-REGEL

**Beispieleinträge in Dokumentations- und README-Dateien dürfen KEINE realen Firmennamen, erfundenen Ereignisse oder Zahlen ohne Messbefehl enthalten.**

### ✅ ERLAUBT:

- `[Kundenname]` – klarer Platzhalter
- `[Firmenname]` – offensichtlicher Platzhalter
- `[Datum]` – generischer Platzhalter
- `[Betrag]` – unausgefülltes Feld
- Beispiel: "Müller Metallbau" (als Lehr-Beispiel, mit `<!-- z.B. ... -->` gekennzeichnet)

### ❌ NICHT ERLAUBT:

- Echte Firmennamen wie "Siemens", "Bosch", "BASF" (außer als tatsächliche Referenzen)
- Erfundene Ereignisse als wären sie passiert ("wurde am 5.7.2026 durchgeführt" – ohne dass es passiert ist)
- Statistiken ohne Messbefehl ("5 Kunden akquiriert" ohne PowerShell-Nachweis)
- Fiktive Telefonnummern oder Adressen in READMEs

### 📌 GILT FÜR:
- Alle README.md-Dateien
- Agent-Dokumentation
- Vault-Status-Dateien
- Templates und Anleitung-Dateien
- Alle frontmatter-Felder

---

## 🔒 ORDNER-ZUGRIFFSREGELN

**Struktur seit 2026-07-05:**

- `02 Areas/Persönliche Daten/Stammdaten/` – Basis-Daten (Name, Kontakt, Profil)
- `02 Areas/Persönliche Daten/Qualifikationen/` – Zertifikate, Schulungen, Zeugnisse
- `02 Areas/Persönliche Daten/Privat/` – Interne Dokumentation, Agent-Konfiguration

### Agent-Zugriff pro Ordner:

| Ordner | Henry | Tim | Brian | Rainer | Andere Agenten |
|--------|-------|-----|-------|--------|-----------------|
| **Stammdaten/** | ✅ Lesen (Basisdaten) | ❌ Nein | ❌ Nein | ❌ Nein | ❌ Nein |
| **Qualifikationen/** | ❌ Nein | ✅ Lesen (für Angebote) | ✅ Lesen (für Bewerbungen) | ❌ Nein | ❌ Nein |
| **Privat/** | ❌ Nein | ❌ Nein | ❌ Nein | ❌ Nein | ❌ Nein (nur Josef manuell) |

### Exportbeschränkungen:

- **Stammdaten**: Keine Telefonnummern, Adressen, Ausweisdaten exportieren. Nur strukturelle Daten.
- **Qualifikationen**: Nur Zertifikatstitel und Gültigkeitsdaten. Keine Prüfungsergebnisse.
- **Privat**: Kein Inhalt außerhalb dieses Ordners referenzieren oder exportieren.

---

## 📌 Verwandte Dokumentation

- [[02 Areas/Agent-Config/AGENTEN-REGISTER.md]] – Alle Agenten & ihre Rollen
- [[02 Areas/Agent-Config/SKILLS-ÜBERSICHT.md]] – Verfügbare Skills
- [[CLAUDE.md]] – Vault-Struktur & Konventionen (basiert auf diesen Regeln)
