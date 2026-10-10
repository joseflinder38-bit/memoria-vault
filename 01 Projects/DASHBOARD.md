---
type: project-dashboard
created: 2026-07-09
last-update: 2026-07-09
version: "1.0"
letztes-update: 2026-07-10
---

# 📊 PROJECT DASHBOARD

**Live-Übersicht aller aktiven Projekte & Kundenakquisition**

> 💡 **Tipp:** Dataview-Queries aktualisieren sich automatisch. Keine manuellen Updates nötig!

---

## 🎯 QUICK STATUS

```dataview
TABLE WITHOUT ID
	file.name as "Projekt",
	status as "Status",
	deadline as "Deadline",
	ziel as "Ziel"
FROM "01 Projects"
WHERE status != "completed" AND status != "archiv"
SORT deadline
```

---

## 📋 ALLE AKTIVEN BEWERBUNGEN

**Übersicht:** Welche Bewerbungen sind noch offen?

```dataview
TABLE WITHOUT ID
	file.name as "Firma",
	status as "Status",
	deadline as "Bewerbungs-Frist",
	position as "Position"
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status != "rejected" AND status != "completed"
SORT deadline
```

---

## 👥 FREELANCE-KUNDENAKQUISITION

**Pipeline:** Welche Kunden sind in welchem Stadium?

```dataview
TABLE WITHOUT ID
	file.name as "Kunde",
	status as "Status",
	branche as "Branche",
	leistung as "Service"
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status != "no-go" AND status != "abgeschlossen"
SORT file.name
```

---

## ⏰ DEADLINE-MONITOR (Nächste 30 Tage)

**Warnung:** Welche Projekte brauchen sofort Aufmerksamkeit?

```dataview
TABLE WITHOUT ID
	file.name as "Projekt",
	deadline as "Deadline",
	status as "Status",
	floor(datebetween(now, deadline, "days")) as "Tage verbleibend"
FROM "01 Projects"
WHERE deadline AND status != "completed" AND status != "archiv" AND datebetween(now, deadline, "days") <= 30
SORT deadline
```

---

## 🔥 HÖCHSTE PRIORITÄT

**Top 5 Projekte mit der kürzesten Deadline:**

```dataview
TABLE WITHOUT ID
	file.name as "Projekt",
	deadline as "Deadline",
	status as "Status"
FROM "01 Projects"
WHERE deadline AND status != "completed" AND status != "archiv"
SORT deadline
LIMIT 5
```

---

## 📈 STATUS-ÜBERSICHT

**Wie viele Projekte in welchem Status?**

```dataview
TABLE WITHOUT ID
	status as "Status",
	length(rows) as "Anzahl"
FROM "01 Projects"
WHERE status
GROUP BY status
SORT status
```

---

## 🎓 BEWERBUNGS-FORTSCHRITT

**Bewerbungs-Statistik:**

```dataview
TABLE WITHOUT ID
	status as "Status",
	length(rows) as "Anzahl Bewerbungen"
FROM "01 Projects/Bewerbungen/Firmen"
GROUP BY status
SORT status DESC
```

---

## 💼 FREELANCE-PIPELINE

**Kundenakquisitions-Übersicht:**

```dataview
TABLE WITHOUT ID
	status as "Status",
	length(rows) as "Anzahl Kunden",
	join(distinct(map(rows, (x) => x.branche)), ", ") as "Branchen"
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
GROUP BY status
SORT status DESC
```

---

## 🏢 BRANCHEN-ÜBERSICHT (Freelance)

**Welche Branchen sind vertreten?**

```dataview
TABLE WITHOUT ID
	branche as "Branche",
	length(rows) as "Anzahl Kunden",
	join(map(rows, (x) => x.status), ", ") as "Status"
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
GROUP BY branche
SORT branche
```

---

## ✅ ABGESCHLOSSENE PROJEKTE (Diesen Monat)

**Was wurde bereits erledigt?**

```dataview
TABLE WITHOUT ID
	file.name as "Projekt",
	file.mtime as "Abgeschlossen am"
FROM "01 Projects"
WHERE status = "completed" AND file.mtime >= date(today) - dur(30 days)
SORT file.mtime DESC
```

---

## 📞 NÄCHSTE KONTAKTE

**Wann sollen nächste Kontakte stattfinden?**

```dataview
TABLE WITHOUT ID
	file.name as "Kunde",
	naechster_kontakt as "Nächster Kontakt",
	status as "Status"
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE naechster_kontakt AND status != "no-go"
SORT naechster_kontakt
```

---

## 🚀 QUICK ACTIONS

**Schnelle Links zu Templates & Ordnern:**

- 📝 **Neue Bewerbung:** `[[05 Templates/Bewerbung-Template.md]]`
  → Kopiere nach: `01 Projects/Bewerbungen/Firmen/[Firmenname].md`

- 💼 **Neuer Kunde:** `[[05 Templates/Gefahrstoff-Kunde-Template.md]]`
  → Kopiere nach: `01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/[Kundenname].md`

- 📋 **Neues Projekt:** `[[05 Templates/Projekt-Template.md]]`
  → Kopiere nach: `01 Projects/[Projektname].md`

---

## 💡 WIE MAN DIESES DASHBOARD NUTZT

### Dashboard aktualisieren
Die Queries aktualisieren sich **automatisch**, sobald du eine Datei bearbeitest:
1. Öffne eine Bewerbung oder einen Kunden
2. Ändere Status, Deadline, etc.
3. Speichere
4. Dieses Dashboard zeigt die neuen Werte sofort!

### Neue Spalten hinzufügen
Wenn du mehr Infos sehen möchtest, sag mir Bescheid:
- Zahl der Bewerbungen pro Firma?
- Umsatzvolumen pro Kunde?
- Anzahl Kontakte?

Ich kann die Queries anpassen!

### Fehlende Frontmatter-Felder?
Wenn eine Query keine Daten zeigt, check ob die Frontmatter-Felder in der Datei gesetzt sind:
```markdown
---
status: aktiv
deadline: 2026-07-15
ziel: Position finden
---
```

---

## 📚 DATAVIEW REFERENZEN

**Frontmatter-Felder, die in den Queries verwendet werden:**

### Alle Projekte (01 Projects/)
- `status` — aktiv, completed, archiv, etc.
- `deadline` — Deadline-Datum
- `ziel` — Projektbeschreibung/Ziel

### Bewerbungen (01 Projects/Bewerbungen/Firmen/)
- `status` — aktiv, rejected, interview, offer, completed
- `position` — Stellenbeschreibung
- `deadline` — Bewerbungs-Frist
- `firma` — Firmenname

### Freelance-Kunden (01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/)
- `status` — active, inquiry, proposal, contract, completed, no-go
- `branche` — Industrie/Branche
- `leistung` — Services (Kataster, Betriebsanweisungen, etc.)
- `naechster_kontakt` — Datum für nächsten Kontakt
- `kunde` — Kundenname

---

## 🔗 VERKNÜPFUNGEN

- **Agent-Übersicht:** [[../07 Agents/README.md]]
- **Vault-Status:** [[../02 Areas/Persönliche Daten/ARBEITSSTAND.md]]
- **Cloud Routines:** [[../02 Areas/Persönliche Daten/CLOUD-ROUTINES.md]]

---

**Zuletzt aktualisiert:** 2026-07-09  
**Dashboard-Version:** 1.0  
**Status:** ✅ Live & aktiv
