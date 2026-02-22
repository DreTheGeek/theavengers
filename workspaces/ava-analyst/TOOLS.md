# Available Tools & How to Use Them

## Supabase (Your Primary Data Source)
Full read access to ALL tables across ALL bots. Write access to analytics-specific tables.

### Tables You Read (Cross-Bot):
- `prospects` — Sarah's prospect pipeline data
- `pipeline` — Deal stages, values, velocity
- `proposals` — Proposal status and conversion
- `deals` — Closed deals with outcomes
- `trades` — Tammy's trade history and P&L
- `products` — Deondre's product catalog and margins
- `ecom_orders` — E-commerce order data
- `daily_ecom_metrics` — Daily store KPIs
- `content_calendar` — Carter's content schedule
- `content_performance` — Post engagement data
- `properties` — Randy's property analysis
- `tax_deed_sales` — Auction tracking
- `business_opportunities` — Benny's opportunities
- `research_findings` — Rhianna's intelligence
- `bot_tasks` — Optimus's task tracking

### Tables You Write:
- `analytics_reports` — Your generated reports
  - Columns: id, report_type, title, summary, report_data (JSONB), metrics (JSONB), insights (TEXT[]), recommendations (TEXT[]), period_start, period_end, bot_id, created_at
- `kpi_snapshots` — Point-in-time metric captures
  - Columns: id, snapshot_date, kpi_name, kpi_value, target_value, unit, category, trend (up/down/stable), notes, created_at
- `anomaly_alerts` — Unusual patterns detected
  - Columns: id, metric_name, expected_value, actual_value, deviation_percent, severity (low/medium/high/critical), description, acknowledged, acknowledged_at, resolved, resolved_at, created_at

### Usage Pattern:
1. Pull data from all bot tables daily
2. Calculate KPIs and store snapshots
3. Compare against targets and historical baselines
4. Flag anomalies and generate alerts
5. Compile weekly analytics reports

## Brave Search (Benchmark Research)
Research industry benchmarks and best practices:
- "[Industry] SaaS conversion rate benchmarks 2026"
- "Average e-commerce return rate by category"
- "Sales pipeline velocity benchmarks B2B"
- "[Industry] customer acquisition cost average"

## Sequential Thinking (Complex Analysis)
Use for multi-step analytical reasoning:
- Forecasting revenue with multiple variables
- Root cause analysis on declining metrics
- Correlation analysis between bot activities and outcomes
- Scenario modeling (what-if analysis)

### Analysis Framework:
1. Define the question precisely
2. Identify all relevant data sources
3. Pull and clean the data
4. Apply appropriate analytical method
5. Validate findings (sanity check)
6. Translate to business recommendations

## Memory (Analytics Baselines)
Store persistent reference data:
- Historical KPI baselines for comparison
- Seasonal patterns and cyclical trends
- Metric definitions and calculation methods
- Target thresholds for anomaly detection
- Which metrics LaSean cares about most
