---
type: skills-registry
version: "1.0"
letztes-update: 2026-07-25
---

# 🛠️ SKILLS-ÜBERSICHT

**Alle verfügbaren Automatisierungs-Skills für Claude Code (Obsidian Vault)**

---

## Verfügbare Skills

| Skill | Bereich | Beschreibung | Trigger |
|-------|---------|-------------|---------|
| **tagesroutine** | 📅 Workflow | Tagesablauf strukturieren, Prioritäten setzen | `/tagesroutine` |
| **dataviz** | 📊 Visualisierung | Charts, Graphen, Dashboards erstellen (Design-System) | *Vor Chart-Erstellung lesen* |
| **update-config** | ⚙️ Konfiguration | settings.json, Permissions, Env-Vars konfigurieren | `/update-config` |
| **keybindings-help** | ⌨️ Shortcuts | Keyboard-Shortcuts & Keybindings anpassen | `/keybindings-help` |
| **simplify** | 🔧 Code-Optimierung | Code aufräumen, Effizienz verbessern | `/simplify` |
| **fewer-permission-prompts** | 🔐 Permissions | Häufige Tool-Calls in Allowlist hinzufügen | `/fewer-permission-prompts` |
| **loop** | 🔄 Automation | Tasks wiederkehrend auf Interval ausführen | `/loop [interval] [command]` |
| **schedule** | ⏰ Scheduler | Cloud-Agenten mit Cron-Schedule erstellen | `/schedule` |
| **claude-api** | 📚 Referenz | Claude API Dokumentation (Models, Pricing, Params) | `/claude-api` |
| **run** | ▶️ Ausführung | App/Projekt starten & Änderungen testen | `/run` |
| **init** | 📄 Setup | CLAUDE.md initialisieren | `/init` |
| **review** | 👀 Code-Review | GitHub PR reviewen | `/review` |
| **security-review** | 🔒 Sicherheit | Security-Review der ausstehenden Änderungen | `/security-review` |

---

## Skill-Details

### 📅 tagesroutine
**Zweck:** Tages-Struktur, Prioritäten, To-Dos organisieren

```
/tagesroutine
→ Fragt dich nach Prioritäten für heute
→ Erstellt Struktur basierend auf Vorlage
```

---

### 📊 dataviz
**Zweck:** Data Visualization Design-System

**WICHTIG:** Diesen Skill **VOR** jeder Chart/Graph-Erstellung lesen!

→ Lehrt: Form Heuristic, Color Formula, Mark Specs, Interaction Rules  
→ Validierte Default-Palette in `references/palette.md`

```
Triggers on: "chart", "graph", "plot", "data viz", "visualization", 
"dashboard", "analytics", "visualize data", "categorical colors", etc.
```

---

### ⚙️ update-config
**Zweck:** Claude Code Harness konfigurieren (settings.json)

**Wann verwenden:**
- Automated behaviors ("von jetzt an wenn X", "jedes mal X")
- Permission-Änderungen ("allow X", "add permission")
- Env-Vars setzen ("set X=Y")
- Hook-Troubleshooting
- Hook-Konfiguration

```
/update-config
→ Lädt settings.json
→ Fragt nach Änderungen
→ Speichert & validiert
```

---

### ⌨️ keybindings-help
**Zweck:** Keyboard-Shortcuts anpassen (~/.claude/keybindings.json)

**Wann verwenden:**
- Rebind keys
- Chord bindings hinzufügen
- Submit-Key ändern
- Custom shortcuts

```
/keybindings-help
→ Zeigt aktuelle Bindings
→ Editiert ~/.claude/keybindings.json
```

---

### 🔧 simplify
**Zweck:** Code-Qualität ohne Bug-Hunting

**Prüft:**
- Wiederverwendung
- Vereinfachung
- Effizienz
- Altitude Cleanups

```
/simplify
→ Reviewed Code-Änderungen
→ Schlägt Optimierungen vor
→ Appliziert Fixes
```

---

### 🔐 fewer-permission-prompts
**Zweck:** Permission-Prompts reduzieren

**Was es tut:**
1. Scannt deine Transcripts
2. Findet häufige Read-Only Tool-Calls
3. Fügt Prioritized Allowlist hinzu (project .claude/settings.json)

```
/fewer-permission-prompts
→ Weniger Permission-Prompts in Zukunft ✅
```

---

### 🔄 loop
**Zweck:** Wiederkehrende Tasks auf Interval

**Wann verwenden:**
- "Überprüfe Deploy alle 5 Minuten"
- "Führe X täglich aus"
- "Poll für Status jede Minute"

```
/loop 5m /command
→ Führt /command alle 5 Minuten aus

/loop
→ Claude selbst wählt sinnvolles Interval
```

---

### ⏰ schedule
**Zweck:** Scheduled Cloud Agents (Cron Jobs)

**Wann verwenden:**
- Recurring Cloud-Agent einrichten
- Automated Tasks erstellen
- One-time Schedule ("run once at 3pm")
- Existing Tasks verwalten (create, update, list, run)

```
/schedule
→ Erstellt/verwaltet Cloud-Agent mit Cron
```

---

### 📚 claude-api
**Zweck:** Claude API Referenz

**Inhalte:**
- Model IDs (claude-3-opus, claude-3-sonnet, etc.)
- Pricing & Token-Limits
- Parameters & Streaming
- Tool Use & MCP
- Agents & Caching
- Token Counting
- Model Migration Guides

```
/claude-api
→ Zeigt aktuelle API-Dokumentation
```

---

### ▶️ run
**Zweck:** App/Projekt starten & testen

**Wann verwenden:**
- "Starte die App"
- "Teste diese Änderung"
- "Screenshot der UI"
- "Zeige mir die Änderung live"

```
/run
→ Sucht Project-Skill
→ Fallback: built-in Patterns (CLI, Server, TUI, Electron, Browser)
```

---

### 📄 init
**Zweck:** CLAUDE.md initialisieren

```
/init
→ Erstellt/aktualisiert CLAUDE.md mit Vault-Dokumentation
```

---

### 👀 review
**Zweck:** GitHub PR reviewen

```
/review
→ Lädt PR-Diff
→ Reviewed Code & Änderungen
→ Erstellt Review-Report
```

---

### 🔒 security-review
**Zweck:** Security Audit der ausstehenden Änderungen

```
/security-review
→ Analyzed aktuellen Branch
→ Sucht nach Security-Issues
→ Erstellt Security-Report
```

---

## 🔗 Verwandte Links

- [[02 Areas/Agent-Config/AGENTEN-REGISTER.md]] – Alle Agenten
- [[02 Areas/Agent-Config/GLOBAL-RULES.md]] – Globale Regeln
- [[CLAUDE.md]] – Vault-Struktur & Grundlagen
