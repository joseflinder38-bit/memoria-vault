---
type: setup-guide
version: "1.0"
last-updated: 2026-10-10
---

# ☁️ CLOUD ROUTINE SETUP GUIDE

**How to set up and configure Claude Cloud Routines for "Karl Market Watch" and other automated agents**

---

## 🎯 WHAT IS A CLOUD ROUTINE?

A Cloud Routine is an agent that runs on Anthropic's cloud servers on a schedule (daily, weekly, monthly, etc.).

**Advantages:**
- Runs even if your computer is off
- No local resources used
- Can send emails, create documents, etc.
- Error handling + logging included

**Use Case:** Market data collection (prices, stocks, crypto) is perfect for Cloud Routines because:
- Needs to run consistently every day
- Doesn't require local files
- Should generate reports
- Benefits from cloud infrastructure

---

## 📋 KARL MARKET WATCH CLOUD ROUTINE

### Setup Step 1: Create the Routine

Go to your Claude Code dashboard and create a **new Cloud Routine** with these specs:

```
Name: "Karl Market Watch Daily"
Schedule: Daily at 10:00 AM (UTC)
Timeout: 5 minutes
```

### Setup Step 2: Define the Agent Task

```
Prompt:
"You are Karl Market Watch, a financial data collector.

Your task:
1. Fetch current prices for:
   - USD/EUR exchange rate (from ECB or similar)
   - Gold price (EUR per ounce)
   - Silver price (EUR per ounce)
   - Bitcoin price (EUR)
   - Ethereum price (EUR)

2. Format the data as:
   ---
   date: YYYY-MM-DD
   timestamp: YYYY-MM-DDTHH:MM:SSZ
   type: market-data
   source: Karl Market Watch
   usd_eur: [number]
   gold_oz_eur: [number]
   silver_oz_eur: [number]
   btc_eur: [number]
   eth_eur: [number]
   ---

3. Save as file:
   02 Areas/Finanzen/Karl-Market-Watch-YYYY-MM-DD.md
   
4. Append data table with market info.

5. Commit to Git:
   git add .
   git commit -m 'Karl Market Watch: Daily data for YYYY-MM-DD'
   git push

6. Send summary email to joseflinder38@gmail.com with key changes."
```

### Setup Step 3: Configure Permissions

The routine needs access to:

```
WRITE:
- 02 Areas/Finanzen/ (for data files)
- .git/ (for commits)

EXECUTE:
- git commands (add, commit, push)
- Email sending (optional)
```

### Setup Step 4: Set Up Error Handling

Configure notifications if the routine fails:

```
On Error: Send email alert to joseflinder38@gmail.com
Include: Error message, timestamp, data collected so far
```

---

## ⚙️ DATA SOURCES FOR KARL

### Option A: Use Public APIs (Recommended)

**Free APIs for market data:**

```
USD/EUR:
  API: https://api.exchangerate-api.com/v4/latest/USD
  Response: { rates: { EUR: 0.92 } }

Gold/Silver:
  API: https://api.metals.live/v1/spot/gold
  Response: { gold: { usd: 2000 } } (convert to EUR)

Bitcoin/Ethereum:
  API: https://api.coingecko.com/api/v3/simple/price
  Query: ?ids=bitcoin,ethereum&vs_currencies=eur
  Response: { bitcoin: { eur: 42000 }, ... }
```

### Option B: Manual Input (If APIs fail)

Karl can ask you to verify prices manually:

```
"Please confirm today's prices:
- USD/EUR: _____
- Gold (EUR/oz): _____
- Bitcoin (EUR): _____"
```

---

## 📊 EXPECTED OUTPUT

After the routine runs successfully, you should have:

**File created:**
```
02 Areas/Finanzen/Karl-Market-Watch-2026-10-10.md
```

**Content:**
```markdown
---
date: 2026-10-10
timestamp: 2026-10-10T10:00:00Z
type: market-data
source: Karl Market Watch Automation
usd_eur: 0.9250
gold_oz_eur: 2150.50
silver_oz_eur: 28.45
btc_eur: 42500.00
eth_eur: 2350.00
prev_gold_oz_eur: 2145.00
prev_btc_eur: 42000.00
---

# Market Data - 2026-10-10

## Change Summary

| Asset | Current | Prev | Change | % |
|-------|---------|------|--------|---|
| Gold | 2150.50 | 2145 | +5.50 | +0.26% |
| Bitcoin | 42500 | 42000 | +500 | +1.19% |
| Ethereum | 2350 | 2330 | +20 | +0.86% |
```

---

## 🔄 INTEGRATION WITH OTHER SYSTEMS

### Link from Daily Notes

In your daily notes, automatically include:

```markdown
## Markets Today

[[02 Areas/Finanzen/Karl-Market-Watch-2026-10-10.md|See today's prices]]
```

### Trigger Price Alerts

When routine completes, check for >3% changes:

```dataview
FROM "02 Areas/Finanzen"
WHERE type = "market-data"
SORT date DESC
LIMIT 2
TABLE date, gold_oz_eur, btc_eur
```

---

## ⚠️ TROUBLESHOOTING

### Problem: Cloud Routine not running

**Check:**
1. Routine is enabled (not paused)
2. Schedule is correct
3. No API errors (check logs)

**Fix:**
```
Disable and re-enable the routine
OR
Run manually to test
```

### Problem: Data not saving to file

**Check:**
1. Git permissions are correct
2. File path is exact
3. No syntax errors in YAML

**Fix:**
```
Test git add/commit manually first
Verify file path structure
```

### Problem: Email not sending

**Check:**
1. Email address is correct
2. Gmail app password is configured (not regular password)
3. SMTP settings in routine config

**Fix:**
```
Generate new Gmail app password at security.google.com
Update routine config with new password
Test send manually
```

---

## 🎯 OPTIONAL: ADVANCED FEATURES

### Feature 1: Trend Analysis

Add to routine:
```
Calculate 7-day and 30-day moving averages
Store in YAML frontmatter
Display in graphs
```

### Feature 2: Anomaly Detection

Add to routine:
```
If price change > 5%, flag as "anomaly"
Send special alert for unusual moves
```

### Feature 3: Portfolio Impact

Add to routine:
```
If you own gold/crypto, calculate impact
Example: "If BTC rises 10%, your portfolio +$500"
```

---

## 📋 CHECKLIST FOR SETUP

- [ ] Cloud Routine created in Claude Code
- [ ] Schedule set to daily 10:00 AM
- [ ] Prompt/instructions written
- [ ] API credentials configured (if using APIs)
- [ ] Git permissions granted
- [ ] Email sending configured
- [ ] Test run completed successfully
- [ ] Error handling verified
- [ ] Logs accessible and readable
- [ ] Daily Notes linked to market data

---

## 🚀 ACTIVATION

When you're ready to activate Karl Market Watch:

1. Test the routine manually in Claude Code
2. Verify file is created in correct location
3. Enable the daily schedule
4. Wait for first automatic run (tomorrow at 10:00)
5. Check that file was created
6. Monitor for 7 days for consistency

---

**Status:** Ready for Setup  
**Estimated Setup Time:** 30 minutes  
**Maintenance:** Minimal (check logs weekly)  
**Cost:** Free (using Anthropic's API)
