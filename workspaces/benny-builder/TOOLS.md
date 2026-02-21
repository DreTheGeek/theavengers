# Available Tools & How to Use Them

## MODEL SWITCHING (Via OpenRouter)
You run on DeepSeek Reasoner by default (best for financial analysis). LaSean can switch you at any time.

### Available Models (say "switch to [name]"):
- **deepseek-reasoner** (DEFAULT) - Complex reasoning, financial modeling
- **claude-sonnet-4** - Best overall quality, nuanced analysis
- **gemini-2.5-pro** - Massive context (1M tokens), great for long research docs
- **gpt-4o** - Strong structured output, good for reports
- **deepseek-chat** - Budget mode, good for simple tasks
- **gpt-4o-mini / gemini-flash / haiku** - Fast cheap tasks

### Auto-switch recommendations:
- Standard research -> DeepSeek Chat (save money)
- Financial modeling with complex scenarios -> Stay on Reasoner
- Massive market report analysis -> Suggest Gemini 2.5 Pro
- Final presentation-quality output -> Suggest Claude Sonnet 4

## Supabase (Research & Storage)
Full read/write access to ALL tables.

### Key Tables:
- `business_opportunities` — Log all research with status, financials, recommendation
  - Columns: id, name, industry, status, roi_estimate, confidence, go_nogo, created_at, presentation_date
- `market_research` — Store market data, competitor analysis, pricing research
- `financial_models` — Detailed projections for each opportunity

### Usage Pattern:
1. Log every opportunity you discover (even if rejected)
2. Store financial models with all assumptions documented
3. Track which opportunities were approved and their real-world results
4. Build institutional knowledge — learn from past analyses

## Brave Search (Market Research)
Your primary research tool. Use for:
- Market sizing and growth data
- Competitor identification and pricing
- Industry trends and disruptions
- Customer pain point discovery
- Technology vendor pricing
- Regulatory requirements

### Research Methodology:
1. Search for market size: "[industry] market size 2025 2026"
2. Find competitors: "[solution type] companies pricing"
3. Validate demand: "[pain point] solutions businesses"
4. Check costs: "[technology/service] pricing plans"
5. Cross-reference multiple sources for accuracy

## Firecrawl (Web Scraping)
Scrape full web pages into clean markdown for market research:
- Competitor websites and full pricing pages
- Industry reports and market analysis
- Business directories and company profiles
- Technology vendor documentation and feature lists
- Government databases (regulations, licensing, compliance)

## Fetch (Deep Research)
Use to access specific URLs for:
- Competitor websites and pricing pages
- Industry reports and whitepapers
- Government data and regulatory filings
- Technology documentation and APIs

## Sequential Thinking (Analysis Enhancement)
Use this tool for complex business analysis:
- Financial modeling with multiple variables
- Risk assessment with scenario planning
- Market entry strategy evaluation
- Multi-step implementation planning

### Example Usage:
When evaluating a business opportunity, use sequential thinking to:
1. Map all revenue streams
2. Identify all cost categories
3. Model each scenario (best/expected/worst)
4. Stress-test assumptions
5. Calculate sensitivity to key variables

## Google Drive
Store all presentations and documents:
- Sunday folders: "YYYY-MM-DD - [Business Name]"
- Include: business plan, financials, MCP, mockups
- Version control for iterations
