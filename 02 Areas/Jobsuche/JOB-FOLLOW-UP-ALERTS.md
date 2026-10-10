---
type: automation-dashboard
version: "1.0"
last-updated: 2026-10-10
---

# 🚨 JOB FOLLOW-UP ALERTS – AUTOMATISCH AKTUALISIERT

**Zweck:** Warnt vor Bewerbungen, die älter als 14 Tage ohne Rückmeldung sind  
**Aktualisiert:** Täglich automatisch via Dataview  
**Status:** ✅ AKTIV

---

## ⏰ DRINGEND – FOLLOW-UP FÄLLIG (14+ Tage ohne Rückmeldung)

```dataview
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status = "Applied" AND date_applied < date(today) - dur(14 days)
SORT date_applied ASC
TABLE
  title,
  company,
  date_applied,
  (date(today) - date(date_applied)).days as Tage_seit_Bewerbung,
  status
```

---

## ⚠️ BALD FÄLLIG – 7 BIS 14 TAGE (Follow-up in Kürze)

```dataview
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status = "Applied" 
  AND date_applied >= date(today) - dur(14 days) 
  AND date_applied < date(today) - dur(7 days)
SORT date_applied ASC
TABLE
  title,
  company,
  date_applied,
  (date(today) - date(date_applied)).days as Tage_seit_Bewerbung,
  status
```

---

## 📋 ALLE OFFENEN BEWERBUNGEN (Sortiert nach Alter)

```dataview
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status = "Applied" OR status = "Interview" OR status = "Offer"
SORT date_applied ASC
TABLE
  title,
  company,
  date_applied,
  (date(today) - date(date_applied)).days as Tage_seit_Bewerbung,
  status,
  deadline
```

---

## 📊 STATISTIK – BEWERBUNGS-ÜBERSICHT

```dataview
FROM "01 Projects/Bewerbungen/Firmen"
TABLE
  length(rows) as "Gesamt",
  length(filter(rows, (r) => r.status = "Applied")) as "Ausstehend",
  length(filter(rows, (r) => r.status = "Interview")) as "Interviews",
  length(filter(rows, (r) => r.status = "Offer")) as "Angebote",
  length(filter(rows, (r) => r.status = "Rejected")) as "Abgelehnt"
```

---

## 💡 EMPFEHLUNG FÜR FOLLOW-UP

Wenn eine Bewerbung älter als 14 Tage ist **OHNE Rückmeldung**:

1. **Rufe an** (am besten zwischen 09:00-11:00 Uhr)
2. **Frage höflich nach:** "Ich wollte nur nachfragen, ob es bei meiner Bewerbung vom XX.XX. neue Entwicklungen gibt?"
3. **Wenn keine Rückmeldung:** Nach 1 Woche erneut versuchen
4. **Nach 3 Wochen ohne Rückmeldung:** Kann man davon ausgehen, dass es eine Absage ist

---

**Monitor:** Diese Übersicht wird täglich von der Nina Scout Automation aktualisiert  
**Nächste Überprüfung:** Täglich 06:15 Uhr
