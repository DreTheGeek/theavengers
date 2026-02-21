# Available Tools & How to Use Them

## Supabase (Pipeline & Data)
Full read/write access to ALL tables.

### Key Tables:
- `prospects` — All prospect records with research
  - Columns: id, company_name, industry, decision_makers, pain_points, status, source, created_at
- `pipeline` — Deal tracking through stages
  - Columns: id, prospect_id, stage, deal_value, probability, next_action, next_action_date, notes
- `proposals` — Proposal versions and status
  - Columns: id, prospect_id, version, status, sent_date, response, follow_up_history
- `deals` — Closed deals (won and lost) with outcomes

### Pipeline Stages:
New Lead → Researching → Qualified → Proposal Creation → Proposal Sent → Follow-Up → Negotiation → Closed Won/Lost

### Usage Pattern:
1. Check prospects table daily for new leads (from Rhianna or LaSean)
2. Update pipeline stage in real-time as deals progress
3. Log every interaction and touchpoint
4. Track win/loss reasons for continuous improvement

## Brave Search (Prospect Research)
Research prospects thoroughly:
- "[Company name] reviews complaints"
- "[Company name] leadership team"
- "[Company name] technology software"
- "HVAC company [city] automation"
- "[Industry] automation ROI case studies"
- "HVAC scheduling software pricing"

## Fetch (Deep Research)
Access specific URLs for:
- Company websites (services, about, team pages)
- Review sites (Google, BBB, Yelp)
- LinkedIn profiles (public)
- Industry benchmarks and case studies
- Competitor pricing pages

## Sequential Thinking (Proposal Enhancement)
Use for complex financial modeling:
- Multi-variable ROI calculations
- Scenario analysis (best/expected/worst)
- Competitive positioning strategy
- Objection anticipation and response planning

### ROI Calculation Framework:
1. Identify all current costs (labor, software, inefficiency, lost revenue)
2. Calculate each automation's specific savings
3. Add implementation and ongoing costs
4. Model net benefit over 1/3/5 years
5. Calculate payback period
6. Stress-test with -20% savings scenario

## Communication Tools
- **Email**: Personalized outreach and follow-ups
- **VAPI**: Phone calls for discovery and presentations
- **Telegram**: Coordination with LaSean

## Google Drive
Store all proposals organized by prospect:
- "[Company Name]/Proposal_v1.md"
- "[Company Name]/Research_Notes.md"
- "[Company Name]/ROI_Model.md"
