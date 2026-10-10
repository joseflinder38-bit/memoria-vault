---
type: dashboard
tags: [dashboard, jobs, bewerbungen]
letztes-update: 2026-07-19
---

# 📊 JOB BEWERBUNGEN DASHBOARD

**Live-Status aller Bewerbungen (Auto-Updated)**

---

## 🔥 STATUS ÜBERSICHT

```dataview
TABLE status, ziel, deadline, match
FROM "01 Projects/Bewerbungen"
WHERE status != "Archiviert"
SORT deadline ASC
```

---

## 🎯 DIESE WOCHE (PRIORITÄT)

```dataview
TABLE file.link as Firma, deadline, status, match
FROM "01 Projects/Bewerbungen"
WHERE deadline <= date(today) + dur(7 days)
AND status != "Archiviert"
SORT deadline ASC
```

---

## 📈 NACH MATCH-SCORE

```dataview
TABLE status, deadline, match
FROM "01 Projects/Bewerbungen"
WHERE match >= 70
SORT match DESC
```

---

## ⏳ AUSSTEHENDE AKTIONEN

```dataview
TABLE status
FROM "01 Projects/Bewerbungen"
WHERE status = "Zu versenden" OR status = "Kontakt pending"
```

---

## 📅 NÄCHSTER TERMIN

```dataview
TABLE deadline, position
FROM "01 Projects/Bewerbungen"
WHERE deadline != null
SORT deadline ASC
LIMIT 5
```

---

## 🎯 AKTUELLE METRIKEN

**Gesamt-Bewerbungen:** `= length(filter(dv.pages('"01 Projects/Bewerbungen"'), p => p.status != "Archiviert"))`

**Bereit zum Versand:** `= length(filter(dv.pages('"01 Projects/Bewerbungen"'), p => p.status = "Versandbereit"))`

**Diese Woche fällig:** `= length(filter(dv.pages('"01 Projects/Bewerbungen"'), p => p.deadline <= date(today) + dur(7 days)))`

**Erfolgsquote:** ~80% (Branchenschnitt für KMUs)

---

**Zuletzt aktualisiert:** 2026-07-19  
**Datenquelle:** 01 Projects/Bewerbungen/
