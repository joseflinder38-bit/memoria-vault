---
date: 2026-10-10
timestamp: 2026-10-10T16:00:00Z
type: market-data
source: Karl Market Watch Automation
---

# Karl Market Watch Data Structure

**This file documents the required structure for Karl's market data so that automated price alert detection works correctly.**

---

## YAML Frontmatter (Required for Automation)

```yaml
---
date: YYYY-MM-DD
timestamp: YYYY-MM-DDTHH:MM:SSZ
type: market-data
source: Karl Market Watch Automation
usd_eur: 1.0850            # US Dollar to Euro
gold_oz_eur: 2150.50       # Gold per ounce in EUR
silver_oz_eur: 28.45       # Silver per ounce in EUR
btc_eur: 42500.00          # Bitcoin price in EUR
eth_eur: 2350.00           # Ethereum price in EUR
prev_gold_oz_eur: 2145.00  # Previous gold price (for comparison)
prev_silver_oz_eur: 27.90  # Previous silver price
prev_btc_eur: 42000.00     # Previous BTC price
---
```

---

## Market Data Table (Content)

```markdown
# Market Data - 2026-10-10

## Exchange Rates

| Pair | Rate | Change % |
|------|------|----------|
| USD/EUR | 1.0850 | +0.15% |
| GBP/EUR | 1.1750 | -0.05% |

## Precious Metals

| Metal | Price (EUR/oz) | 24h Change | 7d Trend |
|-------|----------------|-----------|----------|
| Gold | 2150.50 | +0.26% | +1.2% |
| Silver | 28.45 | -0.18% | -0.5% |
| Platinum | 895.00 | +0.10% | +0.8% |

## Cryptocurrencies

| Coin | Price (EUR) | 24h Change | 7d Change |
|------|-------------|-----------|-----------|
| Bitcoin | 42500.00 | +1.5% | +3.2% |
| Ethereum | 2350.00 | +0.8% | +1.9% |
| Monero | 185.50 | -0.3% | -1.1% |
```

---

## PRICE ALERT RULES (To activate)

Once this structure is in place, use this Dataview query to track price movements:

```dataview
FROM "02 Areas/Finanzen"
WHERE type = "market-data"
SORT date DESC
TABLE
  date,
  gold_oz_eur,
  prev_gold_oz_eur,
  ((gold_oz_eur - prev_gold_oz_eur) / prev_gold_oz_eur * 100) as "Gold_Change_%",
  btc_eur,
  prev_btc_eur,
  ((btc_eur - prev_btc_eur) / prev_btc_eur * 100) as "BTC_Change_%"
LIMIT 7
```

---

## AUTOMATED ALERT THRESHOLDS

When implementing price alerts, use these rules:

```
IF Gold change > +3% OR < -3%: ALERT
IF Silver change > +5% OR < -5%: ALERT
IF Bitcoin change > +5% OR < -5%: ALERT
IF Ethereum change > +5% OR < -5%: ALERT
IF USD/EUR change > +2% OR < -2%: ALERT
```

---

## EXAMPLE: Gold Alert Script

```powershell
# Pseudo-code for price alert logic
$Today = Get-Content "Karl-Market-Watch-2026-10-10.md" | ConvertFrom-YAML
$Yesterday = Get-Content "Karl-Market-Watch-2026-10-09.md" | ConvertFrom-YAML

$GoldChange = (($Today.gold_oz_eur - $Yesterday.gold_oz_eur) / $Yesterday.gold_oz_eur) * 100

if ([math]::Abs($GoldChange) -gt 3) {
    # Send alert
    Send-Notification -Title "Gold Price Alert" -Message "Gold moved $GoldChange%"
}
```

---

## INTEGRATION WITH OTHER SYSTEMS

### Connect to Slack:
```
When Gold > +3%:
  Post to #investments: "Gold Alert: +3.2% (EUR 2150.50)"
```

### Connect to Email:
```
When BTC > +5%:
  Send email: "Crypto Movement: Bitcoin +5.5%"
```

### Connect to Daily Notes:
```
Each daily note links to Karl data:
[[02 Areas/Finanzen/Karl-Market-Watch-2026-10-10.md|Today's Markets]]
```

---

## FUTURE FEATURES

- [ ] Trend analysis (7-day, 30-day moving average)
- [ ] Correlation detection (when BTC rises, EUR usually falls)
- [ ] Anomaly detection (unusual spikes)
- [ ] Historical comparison (same date last year)
- [ ] Portfolio impact calculation

---

**Last Updated:** 2026-10-10  
**Status:** Template Ready for Implementation  
**Next Step:** Configure Karl Cloud Routine to output in this format
