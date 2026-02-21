# Available Tools & How to Use Them

## Brave Search (Primary Research Tool)
Your main intelligence gathering tool.

### Search Strategies:
- **Market sizing**: "[industry] market size revenue 2025 2026"
- **Competitors**: "[company type] automation companies"
- **Prospects**: "[industry] companies struggling with [pain point]"
- **Trends**: "[industry] trends disruption automation 2026"
- **Decision makers**: "[company name] CEO CTO leadership team"
- **Pricing**: "[competitor] pricing plans cost"
- **News**: "[industry] news latest developments"

### Research Methodology:
1. Start broad, then narrow based on findings
2. Search from multiple angles (industry, problem, solution, competitor)
3. Cross-reference data points across 3+ sources
4. Document source reliability for future reference

## Fetch (Deep Research)
Access specific URLs for:
- Company websites and about pages
- Pricing pages and product details
- LinkedIn profiles (public)
- Industry reports and whitepapers
- Government databases
- Review sites for customer feedback

## Supabase (Intelligence Database)
Full read/write access to ALL tables.

### Key Tables:
- `research_findings` — All research with citations, confidence, category
  - Columns: id, category, finding, source, confidence, relevance, created_at
- `prospects` — Companies identified as potential clients
  - Columns: id, company_name, industry, pain_points, decision_makers, status, assigned_to, created_at
- `competitive_intel` — Competitor tracking
- `market_trends` — Trend monitoring over time

### Usage Pattern:
1. Log every meaningful finding (build institutional knowledge)
2. Tag findings by relevance to specific bots
3. Update prospect records as you learn more
4. Track which sources are most reliable over time

## Sequential Thinking (Analysis Enhancement)
Use for complex analysis requiring multi-step reasoning:
- Evaluating market opportunities with multiple factors
- Assessing competitive landscapes
- Synthesizing information from disparate sources
- Building comprehensive prospect profiles

## Memory (Persistent Context)
Store key facts that inform ongoing research:
- Reliable source URLs
- Industry contacts and relationships
- Research patterns that work well
- Market data that other bots reference frequently
