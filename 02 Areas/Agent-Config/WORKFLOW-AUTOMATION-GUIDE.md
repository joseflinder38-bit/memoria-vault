---
type: workflow-guide
version: "1.0"
last-updated: 2026-10-10
---

# 🔄 ADVANCED WORKFLOW AUTOMATION

**Guide for creating complex multi-step automation workflows beyond basic task scheduling**

---

## 📋 WORKFLOW PATTERNS

### Pattern 1: Sequential Workflows

**Example:** "After job interview, automatically create follow-up reminder"

```
┌──────────────────────┐
│ Interview Scheduled  │ (User action)
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Add "Interview" tag  │ (Automation)
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Create follow-up     │ (Automation)
│ date = interview +2d │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Update Dataview      │ (Auto-refresh)
│ dashboard            │
└──────────────────────┘
```

**Implementation:**
```yaml
---
title: "Fachkraft Arbeitssicherheit - Caritas"
company: "Caritas Montabaur"
status: "Interview"
interview_date: 2026-10-15
follow_up_date: 2026-10-17  # Auto-calculated
---
```

---

### Pattern 2: Conditional Workflows

**Example:** "If no response in 14 days, escalate to follow-up"

```
┌─────────────────────────────┐
│ Daily: Check all "Applied"  │
│ applications                │
└──────────┬──────────────────┘
           │
           ▼
      Is age > 14 days?
           /\
          /  \
         NO  YES
        /      \
       ▼        ▼
    IGNORE   UPDATE
              STATUS
              "Follow-Up"
              |
              ▼
              NOTIFY
              USER
```

**Dataview Query:**
```dataview
FROM "01 Projects/Bewerbungen/Firmen"
WHERE status = "Applied" 
  AND date_applied < date(today) - dur(14 days)
TABLE title, company, date_applied
```

---

### Pattern 3: Parallel Workflows

**Example:** "When freelance client signs contract, trigger 3 things in parallel"

```
┌──────────────────────────┐
│ Contract signed          │ (User action)
└──────────┬───────────────┘
           │
      ┌────┴─────┬──────────────┐
      │           │              │
      ▼           ▼              ▼
   Create      Send Thank    Add to
   Invoice     You Email     CRM
      │           │              │
      └────┬─────┴──────────────┘
           │
           ▼
    All 3 complete
           │
           ▼
    Update Dashboard
```

---

### Pattern 4: Feedback Loops

**Example:** "Monitor job applications, track success rate, adjust strategy"

```
Week 1: Send 5 applications
  │
  ├─ Get response rate
  │
  ├─ If rate < 10%:
  │    Update resume
  │    Revise email template
  │
  ├─ If rate > 30%:
  │    Scale up (send 10/week)
  │
Week 2: Apply updated strategy
  │
  └─ Measure again...
```

---

## 🚀 READY-TO-USE WORKFLOW: Job Application Funnel

### Step 1: Create Application

```yaml
---
title: "Software Engineer"
company: "Tech Corp"
date_applied: 2026-10-10
status: "Applied"
deadline: 2026-10-24
next_follow_up: 2026-10-17  # 7 days
---
```

### Step 2: Auto-Generate Reminders

Dataview query (runs daily):
```dataview
FROM "01 Projects/Bewerbungen/Firmen"
WHERE next_follow_up = date(today)
TABLE title, company, date_applied
```

### Step 3: Follow-Up Workflow (Triggered by reminder)

```powershell
# Pseudo-code for follow-up workflow
$Date = Get-Date -Format 'yyyy-MM-dd'
$Applications = Get-Applications | Where-Object { $_.next_follow_up -eq $Date }

foreach ($App in $Applications) {
    # Step A: Send email or call
    Write-Host "Follow up with: $($App.company)"
    
    # Step B: Update status
    $App.status = "Follow-up-Attempted"
    $App.last_contact = $Date
    
    # Step C: Schedule next follow-up
    if ($App.status_response -eq "Waiting") {
        $App.next_follow_up = (Get-Date).AddDays(7)
    }
    
    # Step D: Log in Dataview
    Update-ApplicationNote -Company $App.company -Status $App.status
    
    # Step E: Notify user
    Send-Notification "Follow-up required for $($App.company)"
}
```

---

## 🔧 WORKFLOW AUTOMATION TOOLBOX

### Tool 1: Scheduled Dataview Queries

Runs every time Obsidian opens:
```dataview
FROM "01 Projects/Bewerbungen/Firmen"
WHERE date_applied < date(today) - dur(14 days) AND status = "Applied"
SORT date_applied
```

**Trigger:** Displays automatically in your dashboard

---

### Tool 2: Button Automation

Add buttons to notes that trigger workflows:

```markdown
<!-- Example button that marks interview complete -->
[Mark Interview Complete](button://set-field?field=status&value=Interview)
```

---

### Tool 3: Daily Note Automation

Every day, your Daily Note automatically includes:

```markdown
## Jobs to Follow Up On

<!-- Auto-inserted from Dataview -->
- [[ <link to overdue jobs> ]]
```

---

### Tool 4: Git Commit Automation

When you save a note with certain tags:
```
Every edit to a "Bewerbung" note = auto-commits to Git
```

---

## 📊 WORKFLOW MONITORING

Track workflow effectiveness with these metrics:

```dataview
FROM "01 Projects/Bewerbungen/Firmen"
TABLE
  status,
  count(rows) as "Count",
  avg(days_to_response) as "Avg Days"
GROUP BY status
```

---

## 🎯 ADVANCED: Custom Workflow Scripts

Create your own workflow in PowerShell:

```powershell
# Example: "Auto-create weekly summary"

$Week = Get-Date -UFormat "%V"
$Applications = Get-Applications
$InterviewCount = $Applications | Where-Object { $_.status -eq "Interview" } | Measure-Object
$OfferCount = $Applications | Where-Object { $_.status -eq "Offer" } | Measure-Object

$Summary = @"
# Weekly Summary - Week $Week

- Total applications: $($Applications.Count)
- Interviews: $($InterviewCount.Count)
- Offers: $($OfferCount.Count)
- Response rate: $(($($InterviewCount.Count) + $($OfferCount.Count)) / $Applications.Count * 100)%
"@

# Save as weekly note
$Summary | Out-File -FilePath "Weekly-Summary-$Week.md"

# Commit to git
git add "Weekly-Summary-$Week.md"
git commit -m "Weekly summary - week $Week"
```

---

## 🚨 WORKFLOW ANTI-PATTERNS (What NOT to do)

### ❌ Anti-Pattern 1: Too Many Parallel Tasks

```
DON'T: Trigger 10 different scripts at the same time
DO: Run scripts sequentially or use wait-between
```

### ❌ Anti-Pattern 2: Missing Error Handling

```
DON'T: Chain scripts without checking for failures
DO: Add try/catch and exit codes to every step
```

### ❌ Anti-Pattern 3: Unclear Dependencies

```
DON'T: Have Task A depend on Task B but Task B doesn't run first
DO: Document dependencies clearly (this guide!)
```

---

## 📚 NEXT STEPS

To implement custom workflows:

1. **Identify** the workflow you want (Sequential? Conditional? Parallel?)
2. **Design** it using the patterns above
3. **Test** each step manually first
4. **Automate** with PowerShell / Dataview
5. **Monitor** with the performance dashboard
6. **Iterate** based on results

---

**Created:** 2026-10-10  
**Status:** Ready for Implementation  
**Complexity Level:** Advanced
