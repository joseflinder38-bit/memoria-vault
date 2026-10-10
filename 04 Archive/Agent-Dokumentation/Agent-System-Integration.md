---
type: integration-guide
version: "3.0"
letztes-update: 2026-07-04
---

# 🔗 AGENT-SYSTEM INTEGRATION

**Komplette Dokumentation: Wie die 4 Agenten zusammenarbeiten**

---

## 🤖 DEIN AGENT-TEAM (4 Agenten)

**Die vier Säulen deines persönlichen Assistenten-Teams:**

```
┌─────────────────────────────────────────────────────────┐
│                   DEIN AGENT-TEAM                        │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  Henry (Knowledge)        Tim (Manager)                  │
│  ✅ Datenquelle           ✅ Koordinator                 │
│  📊 Qualifikationen       📋 Anfrage-Verarbeitung        │
│  🎯 Expertise             🔄 Brian briefen              │
│                                                           │
│  Brian (Executor)         Rainer (Maintenance)          │
│  ✅ Output-Generator      ✅ Vault-Wächter              │
│  📝 Bewerbungen           🗑️ Aufräumen & Optimieren    │
│  💼 Angebote              📊 2x täglich Checks          │
│  📧 E-Mails               🔧 Automatische Reparaturen   │
│                                                           │
└─────────────────────────────────────────────────────────┘
```

---

## 🔄 SYSTEM-WORKFLOW

| Komponente | Funktion | Trigger |
|-----------|----------|---------|
| **Henry** (Knowledge) | Zentrale Datenquelle | Automatisch |
| **Tim** (Manager) | Koordiniert Anfragen | `/tim [command]` |
| **Brian** (Executor) | Generiert Outputs | Tim aktiviert |
| **Rainer** (Maintenance) | Optimiert Vault | 2x täglich (auto) |

**Wie es funktioniert:**
```
Du: /tim write-bewerbung "Firma XYZ" "Position"
    ↓
Tim liest deine Anfrage
    ↓
Tim fragt Henry: "Welche Daten brauchen wir?"
Henry: "TRGS 519/521, AEG-ALLODEMONT Erfahrung..."
    ↓
Tim briefed Brian: "Schreib Bewerbung mit diesen Infos"
    ↓
Brian schreibt fertiges Anschreiben
    ↓
Fertig zum Versenden! ✅
```

---

## 🚀 VERFÜGBARE COMMANDS

Alle Commands laufen über **TIM**:

```bash
/tim write-bewerbung "Firma" "Position" [Job-Beschreibung optional]
→ Brian schreibt Bewerbungspaket

/tim generate-lebenslauf [Position optional]
→ Brian erstellt CV

/tim create-freelance-offer "Klient-Info" "Projekt"
→ Brian schreibt Angebot

/tim prepare-interview "Firma" "Position"
→ Brian bereitet dich vor

/tim analyze-job "[Job-Text]"
→ Brian bewertet Match & Chancen

/tim write-email "Empfänger" "Kontext" "Ziel"
→ Brian schreibt professionelle E-Mail

/tim research "Firma" "Was willst du wissen?"
→ Brian recherchiert & analysiert
```

---

## 📁 ZENTRALE DATENQUELLE

### `[[07 Agents/Henry_Knowledge.md]]`

Diese **eine Datei** enthält alles, was Brian braucht:

**Für Bewerbungen:**
- Wer bist du? (Name, Qualifikationen, Erfahrung)
- Was sind deine Stärken? (Zertifikate, Soft Skills)
- Was suchst du? (Zielposition, Branche, Region)

**Für Freelance-Angebote:**
- Deine Expertise (TRGS 519/521, Brandschutz, etc.)
- Deine Leistungen (Gefahrstoffkataster, Betriebsanweisungen, Unterweisungen)
- Deine Zielkunden (Branchen, Größe, Budget)

**Für Kommunikation:**
- Kontaktdaten
- Berufliche Referenzen
- Geschäftsziele & Timeline

**⚠️ WICHTIG:** Halte diese Datei aktuell! Alle Outputs basieren darauf.

---

## 🔄 WORKFLOW-BEISPIELE

### Beispiel 1: Neue Stelle gefunden

```
1. Du siehst interessante Stellenanzeige
2. Du fragst Tim: /tim analyze-job "[Jobtext]"
3. Tim & Brian: "Match: 85%. Deine TRGS-Zertifikate sind gold wert!"
4. Du aktivierst: /tim write-bewerbung "Firma XYZ" "Office Manager"
5. Brian schreibt Anschreiben (basierend auf Henry_Knowledge)
6. Fertig in 5 Min! Du versendest direkt.
```

### Beispiel 2: Kundenanfrage zu Gefahrstoffkataster

```
1. Potenzialkundin: "Brauchen Gefahrstoffkataster für 40 Mitarbeiter"
2. Du fragst Tim: /tim create-freelance-offer "MusterGmbH" "Gefahrstoffkataster"
3. Brian liest Henry_Knowledge (Zertifikate, Preismodelle, Zielkunden)
4. Brian schreibt professionelles Angebot:
   - Mit deinen echten Zertifikaten
   - Mit realistischer Kalkulation
   - Mit Branchenfokus
5. Fertig in 5 Min! Ready-to-send.
```

### Beispiel 3: Interview-Vorbereitung

```
1. Du hast Interview-Einladung
2. Du fragst Tim: /tim prepare-interview "Traumfirma AG" "Sicherheitsleiter"
3. Brian erstellt:
   - Q&A zu häufigen Fragen
   - Deine Stärke-Punkte
   - Strategie für Schwächen
   - Szenario-Spielen
4. Du bist vorbereitet! 🎤
```

---

## 📝 DATEN AKTUALISIEREN

Wenn sich etwas ändert (neue Zertifikate, neue Position, etc.):

1. **Öffne Henry:** `[[07 Agents/Henry_Knowledge.md]]`
2. **Aktualisiere:** Relevante Sektion
3. **Speichern** – Fertig!

→ Tim & Brian nutzen automatisch die neuen Daten bei nächsten Aufgaben

---

## 📁 ZUGEHÖRIGE DATEIEN

Siehe auch:
- **[[07 Agents/README.md]]** – Zentrale Übersicht
- **[[Tim_Manager.md]]** – Tims Rollen & Regeln
- **[[Brian_Executor.md]]** – Brians Fähigkeiten
- **[[07 Agents/Henry_Knowledge.md]]** – Datenquelle
- **[[07 Agents/Rainer_Maintenance.md]]** – Vault-Wartung

---

**Die Agenten arbeiten zusammen für dich!** 🚀
