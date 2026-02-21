# Available Tools & How to Use Them

## Supabase (Property Database)
Full read/write access to ALL tables.

### Key Tables:
- `tax_deed_sales` — Upcoming auction tracking
  - Columns: id, county, state, auction_date, registration_deadline, format, properties_count, url, notes
- `properties` — Individual property records with full analysis
  - Columns: id, address, parcel_id, type, auction_id, min_bid, est_market_value, equity_spread, repair_est, status, confidence, recommendation
- `market_analysis` — Regional market data and trends
- `portfolio` — Acquired properties and performance tracking
- `property_comps` — Comparable sales data

### Usage Pattern:
1. Track ALL upcoming tax deed auctions across monitored states
2. Log every property you analyze (even if rejected — document why)
3. Maintain comps database for frequently monitored areas
4. Track portfolio performance against projections

## Brave Search (Property Research)
Your primary research tool:
- "[County] tax deed sale 2026 schedule"
- "[Address] property records zillow"
- "[Zip code] median home price 2026"
- "[County] tax deed auction results"
- "[Neighborhood] real estate market trends"
- "[City] rental rates average"
- "Bid4Assets [state] upcoming auctions"
- "[County] assessor parcel search"

### Research Checklist Per Property:
1. Search property address on Zillow/Redfin for comps and estimates
2. Check county assessor for tax records and legal description
3. Search for liens and code violations
4. Check neighborhood reviews and crime data
5. Look for recent sales in same subdivision
6. Verify auction details on platform or county site

## Fetch (Deep Property Research)
Access specific URLs:
- County assessor websites (parcel details, tax history)
- Auction platforms (Bid4Assets, RealAuction, GovEase)
- Zillow, Redfin, Realtor.com (comps and estimates)
- Google Maps/Street View links (property condition)
- HOA websites (fees, rules, violations)
- Flood zone maps (FEMA)

## Sequential Thinking (Deal Analysis)
Use for comprehensive property evaluation:

### Due Diligence Checklist:
1. Property identification and basic data
2. Market value estimation (minimum 3 comparable sales)
3. Physical condition assessment (available data)
4. Title and lien research
5. Financial modeling (acquisition + repairs + holding + selling costs)
6. ROI calculation for each exit strategy
7. Risk factor identification and mitigation
8. Go/No-Go decision with confidence rating

### Financial Model Template:
```
ACQUISITION: $bid + $closing costs = $total acquisition
REPAIRS: $estimated + $contingency (15%) = $total repairs
HOLDING: $months × ($insurance + $taxes + $utilities) = $total holding
SELLING: $market_value × (6% agent + 2% closing) = $total selling costs
TOTAL INVESTMENT: $acquisition + $repairs + $holding = $total_in
NET PROFIT (FLIP): $market_value - $total_selling - $total_in = $profit
ROI: $profit / $total_in × 100 = X%
RENTAL YIELD: $monthly_rent × 12 / $total_in × 100 = X%
```

## Memory (Market Intelligence)
Store persistent market data:
- Which counties have the best deals
- Typical price ranges by property type
- Reliable comp sources for each market
- Historical auction results and competition levels
