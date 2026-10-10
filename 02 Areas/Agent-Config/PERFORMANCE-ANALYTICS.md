---
type: performance-dashboard
version: "1.0"
last-updated: 2026-10-10
---

# 📊 PERFORMANCE ANALYTICS DASHBOARD

**Real-time performance metrics for automation system**

---

## 🎯 AUTOMATION PERFORMANCE METRICS

### Daily Note Creation Success Rate

```dataview
FROM "06 Daily Notes"
WHERE file.ctime >= date(today) - dur(30 days)
SORT file.ctime DESC
TABLE
  file.cday as "Date",
  file.size as "Size"
LIMIT 30
```

**Expected:** 30 files in 30 days (1 per day) = 100% success  
**What to watch:** If count < 28, something failed

---

### Job Application Tracking Metrics

```dataview
FROM "01 Projects/Bewerbungen/Firmen"
TABLE
  length(rows) as "Total Applications",
  length(filter(rows, r => r.status = "Applied")) as "Pending",
  length(filter(rows, r => r.status = "Interview")) as "Interviews",
  length(filter(rows, r => r.status = "Offer")) as "Offers",
  length(filter(rows, r => r.status = "Rejected")) as "Rejected",
  (length(filter(rows, r => r.status = "Interview" OR r.status = "Offer")) / length(rows) * 100) as "Success Rate %"
```

**KPIs to track:**
- Success Rate should be 10-20% (interview/offer / total)
- Pending should decrease over time
- Response rate should be tracked

---

### Vault Growth Metrics

```dataview
FROM ""
TABLE
  length(filter(rows, r => r.file.path.includes("01 Projects"))) as "Projects",
  length(filter(rows, r => r.file.path.includes("02 Areas"))) as "Areas",
  length(filter(rows, r => r.file.path.includes("03 Resources"))) as "Resources",
  length(filter(rows, r => r.file.path.includes("06 Daily Notes"))) as "Daily Notes"
```

---

### Freelance Business Pipeline

```dataview
FROM "01 Projects/Freelance Gefahrstoffe Aufbau/Kunden"
TABLE
  company_name,
  industry,
  status,
  estimated_value,
  last_contact
SORT last_contact DESC
```

**Metrics:**
- Total clients in pipeline
- Value of open opportunities
- Contacts within 30 days

---

## 📈 AUTOMATION RELIABILITY SCORES

### Git Backup Reliability

- Expected: Every 10 minutes
- Monitor: `C:\Users\josef\logs\git-backup.log`
- Success Rate Target: >99%

**Check:**
```bash
# Count successful vs failed backups in last 24h
Select-String "\[SUCCESS\]" C:\Users\josef\logs\git-backup.log | Measure-Object
Select-String "\[ERROR\]" C:\Users\josef\logs\git-backup.log | Measure-Object
```

### Job Search Automation Reliability

- Expected: Daily 06:15
- Monitor: `C:\Users\josef\logs\nina-scout.log`
- Success Rate Target: >95%

### Daily Maintenance Success

- Expected: Daily 06:00 (notes) + 08:00 (export)
- Monitor: `C:\Users\josef\logs\daily-note-creation.log` + `rainer-maintenance.log`
- Success Rate Target: 100%

---

## 🎨 CUSTOM METRICS (Manual)

### Monthly Application Velocity

**Count:** How many applications sent per month?

```
October 2026: [Calculate from Bewerbungen folder date_applied field]
- Target: 5-10 per week = 20-40 per month
```

### Response Rate

**Percentage:** How many companies respond?

```
Applied: 40
Interviews scheduled: 8
Response rate: 20%
Target: 15-25%
```

### Average Time to Response

**Days:** How long does it take to hear back?

```
Applications sent: [date_applied]
First interview: [date_received_interview]
Average time: [calculate]
Target: 5-15 days
```

---

## ⚠️ ALERTING RULES

| Metric | Threshold | Action |
|--------|-----------|--------|
| Daily Notes missing | >1 day | Check automation |
| Git commits missing | >30 min | Check GitHub auth |
| Job applications | <5/week | Increase outreach |
| Response rate | <10% | Review applications |
| Git backup errors | >5/day | Debug script |

---

## 📋 WEEKLY REVIEW CHECKLIST

Every Sunday:

- [ ] Check Daily Notes count (should be 7)
- [ ] Check Git commit count (should be 60+)
- [ ] Review Job Application metrics
- [ ] Check Freelance pipeline
- [ ] Review error logs
- [ ] Update this dashboard

---

## 📞 DEBUGGING GUIDE

### If Daily Notes are missing:

```powershell
# 1. Check if task is enabled
Get-ScheduledTask -TaskName "Memoria-Daily-Note-Creation" | Select-Object State

# 2. Check logs
Get-Content C:\Users\josef\logs\daily-note-creation.log -Tail 20

# 3. Check if template exists
Test-Path "05 Templates\Daily-Note-Template.md"
```

### If Git backups are failing:

```powershell
# 1. Check GitHub authentication
cd "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
git status
git log -1

# 2. Check log
Select-String "\[ERROR\]" C:\Users\josef\logs\git-backup.log

# 3. Test push manually
git push origin master
```

---

**Last Review:** 2026-10-10  
**Next Review:** Weekly Sundays  
**Target System Health:** 95%+
