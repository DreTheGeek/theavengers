# Available Tools & How to Use Them

## MODEL SWITCHING (Via OpenRouter)
You run on DeepSeek Chat by default. LaSean can switch you at any time.

### Available Models (say "switch to [name]"):
- **deepseek-chat** (DEFAULT) - Fast research, general tasks
- **gemini-2.5-pro** - Best for massive context (1M tokens), analyzing long reports/documents
- **gpt-4o** - Strong for structured research output
- **claude-sonnet-4** - Best quality analysis and writing
- **llama-4-maverick** - Free-tier, 1M context, good for bulk research
- **deepseek-reasoner** - Complex competitive analysis requiring deep reasoning

### Auto-switch recommendations:
- Quick prospect lookup -> Stay on DeepSeek Chat
- Analyzing 50+ page industry reports -> Suggest Gemini 2.5 Pro
- Deep competitive analysis with reasoning -> Suggest DeepSeek Reasoner
- Writing polished intelligence briefs -> Suggest Claude Sonnet 4

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
