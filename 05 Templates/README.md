---
tags: [templates, anleitung]
letztes-update: 2026-07-10
---

# 📋 05 Templates – Anleitung

Deine **Vorlagen-Sammlung** für schnelle, konsistente Notiz-Erstellung.

## 🎯 Zweck

Templates sind:
- **Schnelle Starts** (nicht von null anfangen)
- **Konsistente Struktur** (YAML-Felder, Sections)
- **Bewährte Formate** (schon optimiert)
- **Für Obsidian Plugin nutzbar** (Templates Core Plugin)

## 📂 DEINE TEMPLATES (8 DATEIEN)

### 1. **Projekt-Template.md**
Für neue Projekte in `01 Projects/`

**Felder:**
```yaml
---
projekt: [Name]
status: [GEPLANT / IN ARBEIT / ABGESCHLOSSEN]
ziel: [Konkretes Endziel]
deadline: [YYYY-MM-DD]
tags: [projekt]
---
```

**Sections:**
- 🎯 Ziel (Was willst du erreichen?)
- 📊 Status (Aktueller Fortschritt)
- 📋 Aufgaben (To-Dos mit Checkboxen)
- 🎯 Nächster Schritt
- 📝 Notizen & Learnings

**Nutzung:**
```
1. Kopiere Projekt-Template.md
2. Benenne: [Projektname].md
3. Speichere in 01 Projects/ (oder Subfolder)
4. Fülle Felder aus
```

---

### 2. **Bewerbung-Template.md**
Für neue Bewerbungen in `01 Projects/Bewerbungen/Firmen/`

**Felder:**
```yaml
---
firma: [Firmenname]
position: [Position]
status: [RECHERCHE / ANSCHREIBEN / VERSENDET / ...]
anschreiben-link: [[Link zu Anschreiben]]
deadline: [YYYY-MM-DD]
tags: [bewerbung]
---
```

**Sections:**
- 🏢 Firma
- 📍 Position & Requirements
- 📋 Bewerbungs-Verlauf (Timeline)
- 📝 Nächster Schritt

**Nutzung:**
```
1. Kopiere Bewerbung-Template.md
2. Benenne: [Firmenname].md
3. Speichere in 01 Projects/Bewerbungen/Firmen/
4. Forsche & finde Anschreiben
5. Update Status
```

---

### 3. **Gefahrstoff-Kunde-Template.md**
Für neue Kunden in `01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/`

**Felder:**
```yaml
---
kunde: [Kundenname]
branche: [Branche]
leistung: [Services]
status: [ERSTKONTAKT / ANGEBOT / BEAUFTRAGT / ...]
nächster-kontakt: [YYYY-MM-DD]
tags: [gefahrstoff-kunde]
---
```

**Sections:**
- 🤝 Kunde (Kontaktinfo)
- 📊 Branche & Anforderungen
- 💰 Leistungen (Checkboxen)
- 📅 Status & Nächster Schritt
- 💬 Notizen & Kontakthistorie

**Nutzung:**
```
1. Kopiere Gefahrstoff-Kunde-Template.md
2. Benenne: [Kundenname].md
3. Speichere in 01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/
4. Fülle Kundendaten aus
5. Track Leistungen & Status
```

---

### 4. **Daily-Note-Template.md**
Für tägliche Notizen in `06 Daily Notes/`

**Dateiname:** `YYYY-MM-DD.md`

**Felder:**
```yaml
---
date: [YYYY-MM-DD]
tags: [daily]
---
```

**Sections:**
- 📋 Prioritäten heute
- 📝 Tagebuch-Notizen
- ✅ Heute erledigt
- ❓ Offene Fragen
- 🎯 Morgen planen

**Nutzung:**
```
1. Neuen Daily Note erstellen
2. Dateiname: YYYY-MM-DD.md
3. Speichere in 06 Daily Notes/
4. Nutze Morgens (Planung) & Abends (Reflexion)
```

---

### 5. **Area-Template.md** (Optional)
Für neue Lebensbereiche in `02 Areas/`

**Felder:**
```yaml
---
type: area
status: active
last-reviewed: [YYYY-MM-DD]
tags: [area-name]
---
```

**Sections:**
- 🎯 Vision
- 📊 Aktueller Status
- 📚 Ressourcen & Kategorien
- 📝 Learnings
- 🔗 Verknüpfungen

---

### 6. **Betriebsanweisung-Template.md**
Für Kundenprojekte (Gefahrstoff-Beratung)

**Format:** Muster-Betriebsanweisung (BA)

**Sections:**
- 🏢 Betrieb & Tätigkeit
- ⚠️ Gefahren
- 🛡️ Schutzmaßnahmen
- 🚨 Notfallmaßnahmen
- 📋 Persönliche Schutzausrüstung (PSA)

**Nutzung:**
Für Kundenprojekte → jede BA individuell füllen

---

### 7. **Angebot-Template.md** (Optional)
Für Kundenangebote (Freelance)

**Felder:**
- Kunde & Kontakt
- Leistungsbeschreibung
- Zeitrahmen
- Preiskalkulationen
- AGB & Zahlungsbedingungen

---

### 8. **Daily-Routine-Checkliste.md** (Optional)
Für regelmäßige Tasks

**Inhalte:**
- Morgen-Routine (Planung)
- Arbeits-Routine (Fokus)
- Abend-Routine (Reflexion)

---

## 🔌 OBSIDIAN TEMPLATES PLUGIN

**Integration mit Obsidian's "Templates" Core Plugin:**

1. Öffne **Settings → Core Plugins → Templates**
2. Aktiviere: ✅ Templates
3. Wähle Ordner: `05 Templates/`
4. Jetzt: `Cmd+Option+T` (Mac) oder `Ctrl+Alt+T` (Windows)
5. Template auswählen → automatisch einfügen!

### Schnelle Neuanlage:
```
1. Neue Datei erstellen (Cmd/Ctrl + N)
2. Cmd/Ctrl + Alt + T
3. Template auswählen
4. Vollautomatisch gefüllt mit Struktur!
```

---

## ✏️ TEMPLATE ANPASSEN

Wenn du ein Template verändern willst:

```
1. Template-Datei öffnen
2. Sektion ändern / hinzufügen
3. Speichern
4. Nächste Nutzung hat neue Struktur!
```

**Beispiel: Mehr Felder hinzufügen?**

In `Bewerbung-Template.md`:
```yaml
---
firma: [Firmenname]
position: [Position]
kontakt: [Name & Email]        ← NEU
telefon-kontakt: [Nummer]      ← NEU
status: [Status]
---
```

---

## 📌 REGELN

**DO:**
- ✅ Templates regelmäßig nutzen
- ✅ Bewährte Strukturen beibehalten
- ✅ Felder aus YAML nicht löschen
- ✅ neue Templates hinzufügen (wenn oft brauchst)

**DON'T:**
- ❌ Template-Datei selbst als Projekt nutzen
- ❌ Alte/veraltete Templates hier lagern
- ❌ Templates löschen (sind wertvoll)
- ❌ YAML-Struktur kaputtmachen

## 🎯 TEMPLATES-WORKFLOW

```
1. Neue Aufgabe kommt auf
   (z.B. "Neue Bewerbung schreiben")
   ↓
2. Passend Template suchen
   ↓
3. Duplizieren & umbenennen
   ↓
4. In richtigem Ordner speichern
   ↓
5. Felder ausfüllen
   ↓
6. Work! 🚀
```

## 📊 TEMPLATES-ÜBERSICHT

| Template | Für | Ordner |
|----------|-----|--------|
| Projekt | Neue Projekte | `01 Projects/` |
| Bewerbung | Jobsuche | `01 Projects/Bewerbungen/Firmen/` |
| Gefahrstoff-Kunde | Freelance Kunden | `01 Projects/Freelance/Kunden/` |
| Daily Note | Tägliche Notizen | `06 Daily Notes/` |
| Area | Neue Lebensbereich | `02 Areas/` |
| Betriebsanweisung | Kundenprojekte | (im Projekt-Ordner) |
| Angebot | Kundenprojekte | (im Projekt-Ordner) |

---

**Stand:** 2026-07-05  
**Ziel:** Schnelle, konsistente Notizerstellung
