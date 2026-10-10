---
type: dashboard
status: AKTIV
letztes-update: 2026-07-28
---

# 📊 Bewerbungs-Status Übersicht

## 🔴 Aktive Bewerbungen (noch offen)

```dataview
TABLE firma, position, deadline, status
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status != "rejected" AND status != "completed"
SORT deadline ASC
```

## ✅ Abgeschlossene (Zusagen)

```dataview
TABLE firma, position, datum_zusage
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status = "completed"
SORT datum_zusage DESC
```

## ❌ Abgelehnt

```dataview
TABLE firma, position, datum_ablehnung
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status = "rejected"
```

## 📈 Statistik

**Gesamt Bewerbungen:** = length(filter(all_notes, (n) => n.file.folder = "01 Projects/Bewerbungen/Firmen"))

**Aktive:** = length(filter(all_notes, (n) => n.file.folder = "01 Projects/Bewerbungen/Firmen" AND n.status != "rejected" AND n.status != "completed"))

**Erfolgsquote:** = (success_count / total_count * 100).toFixed(1) + "%"
