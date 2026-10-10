---
type: index
version: "1.0"
letztes-update: 2026-07-25
---

# 📋 Agent-Config — Zentrale Verwaltung

**Hier befinden sich alle Konfigurationen, Regeln und Dokumentation für deine Agenten und Automationen.**

---

## 📁 Inhalt dieses Ordners

### 1️⃣ **AGENTEN-REGISTER.md**
Zentrale Tabelle aller **12 Agenten mit Rollen**:
- 8 Benannte Agenten (Henry, Karl, Lena, Max, Nina, Otto, Rainer, Vera)
- 4 Automation-Agenten (Karl, Nina, Vera + geplante Erweiterungen)
- 4 Bereichs-Agenten (Finanzen, Jobsuche, Freelance, Gefahrstoffe)

→ **Nutze diesen Link** wenn du wissen möchtest, welche Agenten es gibt und wer wofür zuständig ist.

---

### 2️⃣ **GLOBAL-RULES.md**
**Bindende Regeln für alle Agenten & Reports:**
- 🔐 **Datenschutz-Regel** — Welche Daten dürfen exportiert werden?
- ⚙️ **Automation-Status-Regel** — Wie dokumentieren wir schtasks-Aufgaben?
- 📊 **Messungs-Regel** — Keine Zählungen ohne Befehl!
- 📝 **Beispieldaten-Regel** — Platzhalter vs. echte Daten
- 🔒 **Ordner-Zugriffsregeln** — Wer darf auf Persönliche Daten zugreifen?

→ **Nutze diesen Link** wenn du Regeln implementieren oder überprüfen möchtest.

---

### 3️⃣ **SKILLS-ÜBERSICHT.md**
Dokumentation aller **13 verfügbaren Skills:**
- `/tagesroutine` — Tagesstruktur
- `/dataviz` — Chart Design System
- `/update-config` — Claude Code Konfigurieren
- `/loop`, `/schedule` — Automation
- Und 8 weitere...

→ **Nutze diesen Link** wenn du einen Skill verwenden möchtest.

---

### 📄 **README.md** (diese Datei)
Deine aktuelle Navigations-Übersicht.

---

## 🚀 Schnelle Navigation

### Ich möchte...

**...einen neuen Agenten erstellen**  
→ Lese [[02 Areas/Agent-Config/AGENTEN-REGISTER.md]] für Übersicht  
→ Lese [[02 Areas/Agent-Config/GLOBAL-RULES.md#ℹ️-automation-status-regel]] für Dokumentation

**...Automation konfigurieren**  
→ Lese [[02 Areas/Agent-Config/SKILLS-ÜBERSICHT.md#⏰-schedule]] oder `#🔄-loop`

**...schtasks überprüfen**  
→ Lese [[02 Areas/Agent-Config/GLOBAL-RULES.md#⚙️-automation-status-regel]] (Verifizierungs-Befehl)

**...Datenschutz-Regeln verstehen**  
→ Lese [[02 Areas/Agent-Config/GLOBAL-RULES.md#🔐-datenschutz-regel]]

**...Permissions für Agenten setzen**  
→ Lese [[02 Areas/Agent-Config/GLOBAL-RULES.md#🔒-ordner-zugriffsregeln]]

---

## 🔗 Verwandte Dateien

- **[[CLAUDE.md]]** — Vault-Struktur & allgemeine Konventionen
- **[[02 Areas/Agenten-Übersicht.md]]** — Wöchentliche Updates der Lebens-Bereiche
- **[[07 Agents/README.md]]** — Alle benannten Agenten (Henry, Karl, Lena, Max, Nina, Otto, Rainer, Vera)

---

## 📞 Kontakt bei Fragen

Alle Regeln, Automationen und Agent-Konfigurationen sind hier **zentral** dokumentiert.  
Keine Regeln sollten in einzelnen Agent-Dateien oder Reports wiederholt werden.

**Quelle der Wahrheit:** `02 Areas/Agent-Config/`
