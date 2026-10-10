---
type: dashboard
status: AKTIV
letztes-update: 2026-07-28
---

# 💰 Finanzen 2026

## Freelance-Einnahmen (abgeschlossene Projekte)

```dataview
TABLE kunde, leistung, status
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "completed"
```

## 🔄 Aktive Pipeline (erwartete Einnahmen)

```dataview
TABLE kunde, leistung, status
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
WHERE status = "aktiv" OR status = "proposal-gesendet"
```

## 📊 Jahres-Übersicht 2026

| Metrik | Wert |
|--------|------|
| Abgeschlossene Projekte | = length(filter(rows, (r) => r.status = "completed")) |
| In Arbeit | = length(filter(rows, (r) => r.status = "aktiv")) |
| In Verhandlung | = length(filter(rows, (r) => r.status = "proposal-gesendet")) |

---

**Aktualisiert:** 2026-07-28
