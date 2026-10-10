---
type: dashboard
status: AKTIV
letztes-update: 2026-07-28
---

# 🎯 Kunden-Pipeline

## 1️⃣ NEUE KONTAKTE (Follow-up erforderlich)

```dataview
TABLE kunde, branche, status
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "kontakt" OR status = "neuer-kontakt"
```

## 2️⃣ IN VERHANDLUNG (Proposal gesendet)

```dataview
TABLE kunde, leistung, status
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "proposal-gesendet" OR status = "verhandlung"
```

## 3️⃣ AKTIVE KUNDEN (laufende Projekte)

```dataview
TABLE kunde, leistung, status
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "aktiv"
```

## 4️⃣ ABGESCHLOSSENE PROJEKTE

```dataview
TABLE kunde, leistung, status
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "completed"
```

## 📊 Pipeline-Statistik

- **Gesamt Kontakte:** Siehe oben
- **Neue Kontakte:** = length(filter(rows, (r) => r.status = "neuer-kontakt"))
- **In Verhandlung:** = length(filter(rows, (r) => r.status = "proposal-gesendet"))
- **Aktive:** = length(filter(rows, (r) => r.status = "aktiv"))
