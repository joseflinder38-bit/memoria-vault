---
type: automation-helper
version: "1.0"
last-updated: 2026-10-10
---

# 🔍 FRONTMATTER VALIDATOR – Prüft Datenintegrität

**Zweck:** Validiert YAML-Frontmatter in Bewerbungen & Kunden-Dateien  
**Status:** ✅ READY (Dataview-Queries)

---

## 🚨 DATENVALIDIERUNG – FEHLERHAFTE EINTRÄGE FINDEN

Wenn eine Bewerbungs- oder Kunden-Datei korrumpierte Frontmatter hat, **brechen Dataview-Queries teilweise ab**. Diese Queries helfen, solche Fehler zu finden:

---

## ❌ BEWERBUNGEN MIT FEHLENDEN PFLICHTFELDERN

```dataview
FROM "01 Projects/Bewerbungen/Firmen"
WHERE !title OR !company OR !status OR !date_applied
TABLE title, company, status, date_applied
SORT date_applied DESC
```

**Was wird geprüft:**
- `title` (Job-Titel) — PFLICHT
- `company` (Firma) — PFLICHT
- `status` (Bewerbungs-Status) — PFLICHT
- `date_applied` (Anwendungs-Datum) — PFLICHT

**Wenn diese Query etwas zeigt:** Diese Dateien müssen repariert werden!

---

## ❌ KUNDEN MIT FEHLENDEN PFLICHTFELDERN

```dataview
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE !company_name OR !industry OR !status
TABLE company_name, industry, status, contact_name
SORT file.ctime DESC
```

**Was wird geprüft:**
- `company_name` (Kundenname) — PFLICHT
- `industry` (Branche) — PFLICHT
- `status` (Projekt-Status) — PFLICHT

---

## ⚠️ BEWERBUNGEN MIT UNGÜLTIGEN STATUS-WERTEN

```dataview
FROM "01 Projects/Bewerbungen/Firmen"
WHERE !contains("Applied", "Interview", "Offer", "Rejected", "Withdrawn", status)
TABLE title, company, status
```

**Gültige Status-Werte:**
- `Applied` — Bewerbung versendet
- `Interview` — Interview eingeladen
- `Offer` — Angebot erhalten
- `Rejected` — Abgelehnt
- `Withdrawn` — Zurückgezogen

**Wenn diese Query etwas zeigt:** Status muss korrigiert werden!

---

## ⚠️ ALLE DATEIEN MIT SYNTAX-FEHLERN

```dataview
FROM "01 Projects/Bewerbungen/Firmen"
WHERE !title
TABLE file.name, file.path
```

Dies findet Dateien, bei denen Dataview überhaupt **nicht** auf den `title`-Field zugreifen kann (meist YAML-Syntax-Fehler).

---

## 🔧 WIE MAN FEHLER REPARIERT

**Beispiel: Datei hat kein `status` Feld**

**FEHLER:**
```yaml
---
title: "Fachkraft Arbeitssicherheit"
company: "Caritas Montabaur"
date_applied: 2026-07-15
---
```

**KORREKT:**
```yaml
---
title: "Fachkraft Arbeitssicherheit"
company: "Caritas Montabaur"
date_applied: 2026-07-15
status: "Applied"  # MUSS VORHANDEN SEIN
---
```

---

## 📋 FRONTMATTER-TEMPLATE (Kopiere für neue Dateien)

### Für Bewerbungen:
```yaml
---
title: "[Job-Titel]"
company: "[Firma]"
date_applied: [yyyy-MM-dd]
status: "Applied"  # Applied | Interview | Offer | Rejected
location: "[Stadt]"
salary: "[Gehalt z.B. 40000-50000]"
url: "[Link zur Stellenanzeige]"
contact_person: "[Name]"
contact_email: "[Email]"
contact_phone: "[Telefon]"
deadline: "[Optional: yyyy-MM-dd]"
notes: "[Notizen]"
tags: ["#bewerbung", "#[branche]", "#[stadt]"]
---
```

### Für Kunden:
```yaml
---
company_name: "[Firma]"
industry: "[Branche]"
status: "Prospekt"  # Prospekt | Lead | Client | Closed
contact_name: "[Name]"
contact_email: "[Email]"
contact_phone: "[Telefon]"
first_contact: [yyyy-MM-dd]
last_contact: [yyyy-MM-dd]
service_offered: "[Welche Leistung]"
estimated_value: "[Budget z.B. 5000-10000]"
next_follow_up: [yyyy-MM-dd]
tags: ["#kunde", "#[branche]"]
---
```

---

## 🤖 AUTOMATISCHE VALIDIERUNG

Diese Seite sollte **wöchentlich überprüft werden**. Wenn eine der obigen Queries etwas zeigt, dann:

1. Öffne die Datei
2. Überprüfe die Frontmatter (Text oben zwischen `---`)
3. Füge fehlende Felder hinzu
4. Speichere die Datei

---

**Last Validation Check:** 2026-10-10  
**Next Check:** Wöchentlich (jeden Sonntag)
