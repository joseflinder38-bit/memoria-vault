---
type: financial-planning
version: "2.0"
last-updated: 2026-10-10
currency: EUR
---

# 💰 FINANCIAL PROJECTIONS & BUDGETING

**Automated financial planning based on current data**

---

## YOUR CURRENT FINANCIAL SITUATION

### Income Sources

```
Employment (Full-time):
  Monthly: €2,333 (based on €28k/year)
  Annual: €28,000

Freelance (Gefahrstoff Consulting):
  Monthly: €800 (estimated, building)
  Annual: €9,600

TOTAL CURRENT ANNUAL: €37,600
TOTAL MONTHLY: €3,133
```

### Monthly Expenses (Estimated)

```
Housing & Utilities:    €800-1000
Food & Groceries:       €400-500
Transportation:         €200-300
Internet/Phone:         €50
Insurance:              €200
Leisure & Entertainment: €300-400
Miscellaneous:          €200-300

TOTAL MONTHLY: €2,150-2,750
TOTAL ANNUAL: €25,800-33,000
```

### Current Savings Rate

```
Monthly Income:    €3,133
Monthly Expenses:  €2,450 (average)
Monthly Savings:   €683

Annual Savings:    €8,200
Savings Rate:      21.8% ✅ EXCELLENT
```

---

## SCENARIO 1: CURRENT JOB (No Change)

```
Timeline: 2026 - 2028

Year 1 (2026):
  Income:   €37,600
  Expenses: €29,400
  Savings:  €8,200
  Balance:  €8,200

Year 2 (2027):
  Income:   €38,500 (3% raise)
  Expenses: €30,200
  Savings:  €8,300
  Balance:  €16,500

Year 3 (2028):
  Income:   €39,700 (3% raise)
  Expenses: €31,100
  Savings:  €8,600
  Balance:  €25,100

NORWAY EMIGRATION READINESS (Q4 2026):
  Savings by then: €8,200 ✓ Minimum threshold
  Status: JUST BARELY FEASIBLE
```

---

## SCENARIO 2: JOB UPGRADE (€40k Position)

```
Timeline: 2026 - 2028
Assumption: Land job by December 2026

Year 1 (Rest of 2026):
  Income:   €37,600 (old job) + €2,500 (new job prorated)
  Total:    €40,100
  Expenses: €29,400
  Savings:  €10,700
  Balance:  €10,700

Year 2 (2027 - NORWAY YEAR):
  Income:   €40,000 (new job)
  Expenses: €30,200 (baseline)
  +Norway costs: €5,000-8,000/month for relocation
  
  Total Expenses: €35,200 + €20,000 (relocating)
  Savings: €4,800
  Balance: €15,500 (TIGHT but feasible)

Year 3 (2028 - Norway Established):
  Income:   €42,000 (3% raise)
  Expenses: €32,000 (local cost of living)
  Savings:  €10,000
  Balance:  €25,500

NORWAY EMIGRATION READINESS (Q4 2026):
  Savings by then: €10,700 ✓ COMFORTABLE
  Status: WELL-PREPARED
```

---

## SCENARIO 3: SUCCESSFUL FREELANCE SCALING

```
Timeline: 2026 - 2028
Assumption: Scale freelance to €2,000/month

Year 1 (2026):
  Employment: €28,000
  Freelance:  €9,600 (€800/month)
  Total:      €37,600
  (No change from Scenario 1)

Year 2 (2027):
  Employment: €40,000 (upgraded job)
  Freelance:  €24,000 (€2,000/month)
  Total:      €64,000

  Expenses:   €35,200 (slightly higher due to freelance setup)
  Savings:    €28,800
  Balance:    €28,800 + relocation costs = OK for Norway

Year 3 (2028):
  Employment: €42,000
  Freelance:  €30,000 (€2,500/month, scaling well)
  Total:      €72,000

  Expenses:   €35,000
  Savings:    €37,000
  Balance:    €65,800 (EXCELLENT position)

NORWAY EMIGRATION READINESS (Q4 2026):
  Savings: €10,700
  +
  Freelance revenue: €1,600/month (continuing in Norway)
  Status: STRONGEST POSITION
```

---

## SCENARIO 4: PARTNER'S INCOME (Freundin)

**Important for COUPLE EMIGRATION PLAN:**

```
Freundin's Income (BWL Student + ICU Nurse):
  ICU Nursing: €2,200/month (€26,400/year)
  Studies: May reduce hours during exam periods
  
COMBINED HOUSEHOLD INCOME:
  Josef + Freundin: €37,600 + €26,400 = €64,000/year
  
Monthly: €5,333
Monthly Expenses: €4,000-4,500 (shared housing)
Monthly Savings: €833-1,333

COUPLE EMIGRATION READINESS:
  Combined savings potential by Q4 2026: €18,400
  Status: VERY STRONG (plenty for relocation)
```

---

## NORWAY EMIGRATION COST ESTIMATE

### One-Time Costs

```
Moving/Relocation: €3,000-5,000
  - Moving truck/shipping
  - Travel costs
  - Initial setup

Housing Deposit: €2,000-4,000
  - First month + security
  - Norwegian standard

Administrative: €500-1,000
  - Work permits (if needed)
  - Bank account setup
  - Insurance switches

TOTAL ONE-TIME: €5,500-10,000
```

### Monthly Costs in Norway

```
Housing (Oslo area): €1,200-1,800/month
Food & Groceries: €600-800
Transportation: €100-150
Insurance: €150-200
Internet/Phone: €50
Utilities: €150-200
Other: €400-500

TOTAL MONTHLY: €2,850-3,850

Norwegian salary expectations:
  Fachkraft Arbeitssicherheit: NOK 550,000-650,000/year
  = EUR 50,000-60,000/year
  = EUR 4,200-5,000/month

BALANCE (Income - Expenses):
  EUR 350-1,150/month surplus ✓ VIABLE
```

---

## RECOMMENDATION BY SCENARIO

### Best Case Path:

1. **NOW (Oct 2026):** Continue job hunting
2. **BY DECEMBER 2026:** Land €40k position
3. **Q1 2027:** Begin Norway job search & relocation planning
4. **Q4 2026:** Have €10,700+ saved for relocation
5. **2027:** Move to Norway with partner

**Financial Status:** ✅ FEASIBLE & RECOMMENDED

---

### Backup Plan (If Job Upgrade Fails):

1. Continue current job (€28k)
2. Aggressively scale freelance (target €2,000/month)
3. Delay Norway move to 2027-2028
4. Build larger safety net (€20,000+)

**Financial Status:** ✅ STILL POSSIBLE (slower path)

---

## AUTOMATED MONTHLY TRACKING

Create a monthly dashboard with these metrics:

```dataview
FROM "02 Areas/Finanzen"
WHERE type = "monthly-report"
SORT date DESC
LIMIT 12
TABLE
  date,
  income_employment,
  income_freelance,
  total_income,
  total_expenses,
  monthly_savings,
  cumulative_savings,
  norway_readiness_pct
```

---

## ACTION PLAN

### THIS MONTH (October 2026)

- [ ] Track actual income vs. projection
- [ ] Log all expenses accurately
- [ ] Update employment status (job search progress)
- [ ] Estimate freelance growth
- [ ] Calculate cumulative savings

### THIS QUARTER (Q4 2026)

- [ ] Finalize job application strategy
- [ ] Target €40k position landing
- [ ] Hit €10,000+ in savings
- [ ] Begin Norway salary research
- [ ] Plan relocation logistics

### EARLY 2027 (Q1-Q2)

- [ ] Start Norway job applications
- [ ] Partner begins Norway research
- [ ] Finalize relocation budget
- [ ] Book moving companies
- [ ] Apply for work permits if needed

---

## KEY SUCCESS FACTORS

✅ **Income:** Land €40k job = +€12k/year = game-changer  
✅ **Freelance:** Scale to €2k/month = +€12k/year = excellent  
✅ **Partner:** ICU nursing income = stable baseline  
✅ **Savings Rate:** 21.8% is excellent (target: 20%+)  
✅ **Timeline:** Q4 2026 is realistic for Norway prep  

---

## RISKS & MITIGATION

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|-----------|
| Job market weak | 30% | -€12k/year | Have freelance backup |
| Freelance stalls | 25% | -€12k/year | Upskill/marketing |
| Partner job loss | 15% | -€26k/year | Emergency fund (3 months) |
| Norway expensive | 40% | +€5k costs | Realistic budgeting |
| Relocation delayed | 20% | 6mo delay | Flexibility on timeline |

**Recommended Safety Margin:** Save €15,000 (not €10,000) before move

---

## TOOLS TO USE

**Auto-Track Spending:**
- [ ] Set up expense tracking in Finanzen folder
- [ ] Monthly expense report (automated)
- [ ] Dataview dashboard for budget vs. actual

**Auto-Calculate Projections:**
- [ ] Run this script monthly:
  ```
  IF month == December:
    IF cumulative_savings > 10000:
      Status = "Norway ready by Q4 2027"
    ELSE:
      Status = "Target 2028"
  ```

---

**Last Updated:** 2026-10-10  
**Next Review:** Monthly (automated)  
**Emigration Timeline:** Q4 2026 preparation → Q4 2027 execution  
**Financial Health:** ✅ STRONG (21.8% savings rate)
