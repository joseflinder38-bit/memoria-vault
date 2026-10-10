---
type: quick-start
version: "1.0"
---

# ⚡ QUICK START – Get Your Automation System Running (5 min)

**Everything you need to know, right now.**

---

## 🚀 IN 5 MINUTES

### Step 1: Verify Automations Are Running (1 min)

```powershell
# Open PowerShell and run:
Get-ScheduledTask | Where-Object { $_.TaskName -match "Memoria" } | Select-Object TaskName, State
```

Expected output:
```
TaskName                        State
--------                        -----
Memoria-Daily-Note-Creation     Ready
Memoria-Rainer-Maintenance      Ready
Memoria-Vault-Maintenance       Ready
Memoria-Git-AutoBackup          Ready
Memoria-Nina-Scout-Daily        Ready
```

**All say "Ready"?** ✅ GO TO STEP 2  
**Some say "Disabled"?** ❌ Enable them: `Enable-ScheduledTask -TaskName "Memoria-Daily-Note-Creation"`

---

### Step 2: Check Dashboard (1 min)

```
1. Open: 02 Areas/Agent-Config/dashboard.html
2. Right-click → "Open with Browser"
3. See 95% health score?
```

✅ System is healthy! GO TO STEP 3

---

### Step 3: Use Job Matcher (1 min)

```
1. Open: 02 Areas/Jobsuche/AI-JOB-MATCHER.md
2. Read your profile (at top)
3. Review scoring examples
```

Next: Run the Dataview queries to find your best job matches!

---

### Step 4: Check Financial Status (1 min)

```
1. Open: 02 Areas/Finanzen/FINANCIAL-PROJECTIONS.md
2. Find your scenario (€28k current job)
3. Read: "Norway Emigration Readiness"
```

**Result:** Q4 2026 is feasible if you land €40k job! ✅

---

### Step 5: Activate Notifications (1 min)

**Option A: Telegram (recommended)**
```powershell
# Get bot token: https://t.me/BotFather
# Set environment variable:
$env:TELEGRAM_BOT_TOKEN = "your_token_here"
$env:TELEGRAM_CHAT_ID = "your_chat_id_here"

# Test:
& "C:\Users\josef\logs\telegram-notifier.ps1" -Message "Test!" -Severity "SUCCESS"
```

**Option B: Email** (setup in EMAIL-TEMPLATES.md)

---

## 📚 ESSENTIAL FILES (Bookmark these!)

**Dashboards:**
- `02 Areas/Agent-Config/dashboard.html` — System status (open in browser)
- `02 Areas/Agent-Config/COMPLETE-AUTOMATION-GUIDE.md` — Master reference

**For You:**
- `02 Areas/Jobsuche/AI-JOB-MATCHER.md` — Find best jobs
- `02 Areas/Finanzen/FINANCIAL-PROJECTIONS.md` — Norway timeline
- `02 Areas/Jobsuche/EMAIL-TEMPLATES.md` — Send emails

**For Couple:**
- `02 Areas/Persoenliche Daten/PARTNER-SETUP.md` — Freundin integration

**Monitoring:**
- `02 Areas/Agent-Config/AUTOMATION-STATUS.md` — What's running
- `C:\Users\josef\logs\` — All log files

---

## 🎯 THIS WEEK (Priority Order)

```
Monday:
  [ ] Run AI Job Matcher
  [ ] Apply to top 3 job matches (score 80+)
  
Tuesday:
  [ ] Set up Telegram notifications
  [ ] Share PARTNER-SETUP.md with Freundin
  
Wednesday:
  [ ] Review Financial Projections
  [ ] Plan Norway timeline

Thursday:
  [ ] Check GitHub health: C:\Users\josef\logs\github-health-check.ps1
  
Friday:
  [ ] Review dashboard
  [ ] Apply to 3 more jobs
```

---

## ⚡ QUICK COMMANDS

**Health Check:**
```powershell
& "C:\Users\josef\logs\system-health-check.ps1"
```

**GitHub Status:**
```powershell
& "C:\Users\josef\logs\github-health-check.ps1"
```

**Backup Check:**
```powershell
& "C:\Users\josef\logs\backup-integrity-check.ps1"
```

**Telegram Test:**
```powershell
& "C:\Users\josef\logs\telegram-notifier.ps1" -Message "All systems online!" -Severity "SUCCESS"
```

---

## 🔥 KEY METRICS TO TRACK

**Weekly:**
- [ ] Applications sent: ___ (goal: 3+)
- [ ] Responses received: ___
- [ ] Response rate: ___%
- [ ] Dashboard health: 95%+?

**Monthly:**
- [ ] Total applications: ___ (goal: 12+)
- [ ] Interview count: ___
- [ ] Cumulative savings: €___
- [ ] Freelance income: €___

---

## ❓ IF SOMETHING BREAKS

**Daily Notes not created?**
```powershell
Get-Content "C:\Users\josef\logs\daily-note-creation.log" -Tail 10
```

**Git not syncing?**
```powershell
& "C:\Users\josef\logs\github-health-check.ps1"
```

**Dashboard not loading?**
```
Right-click dashboard.html → Open with → Chrome/Firefox
(Not Internet Explorer - it's too old)
```

**Tasks disabled?**
```powershell
Enable-ScheduledTask -TaskName "Memoria-*"
```

---

## 🎓 WHERE TO LEARN MORE

| Topic | File | Time |
|-------|------|------|
| Job matching | `AI-JOB-MATCHER.md` | 5 min |
| Finances | `FINANCIAL-PROJECTIONS.md` | 10 min |
| Security | `SECURITY-AND-PRIVACY.md` | 10 min |
| Workflows | `WORKFLOW-AUTOMATION-GUIDE.md` | 15 min |
| Complete guide | `COMPLETE-AUTOMATION-GUIDE.md` | 30 min |

---

## 🚀 YOUR NEXT WINS

1. **This month:** Land €40k job (use AI Matcher!)
2. **This quarter:** Save €15k (on track!)
3. **Q4 2026:** Move to Norway (system will help!)

**You've got this!** 💪

---

**Quick Start Version:** 1.0  
**Updated:** 2026-10-10  
**System Status:** 95% ✅
