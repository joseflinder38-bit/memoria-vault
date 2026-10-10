---
type: multi-user-setup
version: "1.0"
last-updated: 2026-10-10
---

# 👥 PARTNER SETUP – Couple Automation System

**Setup automations for Freundin (ICU Nurse + BWL Student)**

---

## YOUR PARTNER'S PROFILE

```yaml
name: [Freundin]
role: ICU Nurse + BWL Student
income_primary: EUR 2,200/month (ICU)
income_studies: Variable (exam-dependent)
emigration_goal: Norway Q4 2026 (together!)

automations_needed:
  - Shift schedule tracking
  - Study reminders
  - Job opportunities (Norway healthcare)
  - Financial tracking (couple budget)
  - Health/wellness reminders
```

---

## SHARED AUTOMATIONS (Josef + Freundin)

### 1. Couple Budget Tracking

```
Shared Expenses:
  Housing: €1,200 (split: €600 each)
  Food: €500 (split: €250 each)
  Utilities: €200 (split: €100 each)
  
Individual Tracking:
  Josef freelance: €800/month
  Freundin studies: Variable
  
Combined Automation:
  - Monthly expense sync
  - Savings goal tracking (€15k by Q4 2026)
  - Norway budget planning
```

### 2. Couple Emigration Planning

```
Shared Tasks:
  - Both apply for Norway jobs
  - Coordinate moving timeline
  - Joint visa/work permit research
  - House hunting together
  
Automation Dashboard:
  [[Couple Emigration Timeline]]
  - Josef's job search status
  - Freundin's job search status
  - Combined savings progress
  - Relocation checklist
```

### 3. Wellness & Health Tracking

```
Freundin-Specific:
  - ICU shift calendar (automated from employer API)
  - Sleep tracking (after night shifts)
  - Study break reminders
  - Mental health check-ins
  
Joint:
  - Weekly couple check-in (reminder)
  - Shared wellness goals
  - Exercise tracking
```

---

## FREUNDIN'S AUTOMATION SETUP

### Health Reminders (ICU Nurse)

```powershell
# Auto-remind after night shifts
if (shift_type -eq "night") {
    reminder_time = 14:00  # 2 PM
    message = "Take nap before evening activities"
}
```

### Study Reminders (BWL Student)

```powershell
# Monthly: Exam prep tracker
# Exam on [date]: Send notification 2 weeks before
# Daily: 30-min study reminder during exam periods
```

### Job Search (Healthcare in Norway)

```
Target Positions:
  - ICU Nurse (kreftavdelingen)
  - Healthcare manager
  - Nursing supervisor
  
Locations:
  - Oslo (major hospital)
  - Bergen
  - Stavanger

Salary expectations (Norway):
  - Starting: NOK 450k-500k (€42-47k)
  - With experience: NOK 550k+ (€51k+)
```

---

## SHARED VAULT STRUCTURE

```
02 Areas/
├── Couple/
│   ├── Budget.md (shared expense tracking)
│   ├── Emigration-Timeline.md (joint progress)
│   ├── Norway-Job-Search.md (both apply)
│   └── Couple-Dashboard.md (overview)
├── Freundin/
│   ├── Study-Schedule.md
│   ├── ICU-Shifts.md (synced from hospital)
│   ├── Health-Log.md
│   └── Job-Applications.md
└── Josef/
    └── (existing structure)
```

---

## COUPLE EMIGRATION CHECKLIST

### NOW (October 2026)

- [ ] Create shared couple budget file
- [ ] Both apply for Norway jobs (10+ applications each)
- [ ] Research visa requirements together
- [ ] Estimate moving costs (joint)
- [ ] Check language requirements (Norwegian A2?)

### Q4 2026

- [ ] Target: Combined €15k saved
- [ ] Both interview stage (hoped!)
- [ ] Book housing viewings (virtual)
- [ ] Prepare for move

### Q1 2027

- [ ] Start new jobs in Norway
- [ ] Find couple housing
- [ ] Complete relocation
- [ ] Activate Norwegian automations

---

## AUTOMATION SHARING RULES

✅ **What to share in Git:**
- Budget tracking
- Job search progress
- Emigration planning
- General health goals

❌ **What NOT to share:**
- Personal health details
- Study answers/materials
- Financial passwords
- Private journal entries

---

## COUPLE AUTOMATION EXAMPLES

### Example 1: Weekly Check-In Reminder

```powershell
# Every Sunday 19:00
$Day = Get-Date -DayOfWeek Sunday
Send-Notification -To "both" -Message "Couple check-in time! 💑"
Open "02 Areas/Couple/Weekly-Check-In-$(Get-Date -f 'yyyy-MM-dd').md"
```

### Example 2: Joint Savings Tracker

```dataview
FROM "02 Areas/Couple"
WHERE type = "savings"
TABLE
  date,
  josef_income,
  freundin_income,
  total_expenses,
  combined_savings,
  cumulative_total,
  "target_norway" = (15000 - cumulative_total)
```

### Example 3: Norway Job Alert

```
When new job posted in Norway (healthcare):
  1. Notify both via Telegram
  2. Add to shared job board
  3. Set follow-up reminder
  4. Track both applications
```

---

## NEXT STEPS

- [ ] Share vault access with Freundin
- [ ] Create couple folder structure
- [ ] Set up shared budget tracking
- [ ] Activate couple emigration dashboard
- [ ] Begin joint job search

---

**Status:** Ready for Activation  
**Couple Readiness:** HIGH ✅  
**Norway Timeline:** Q4 2026 realistic with this system
