# Deploy and Host The Avengers on Railway

The Avengers is a fleet of 9 AI agents powered by OpenClaw that run 24/7 as a single Docker service. Each agent has domain expertise — sales, trading, research, content, code, real estate, e-commerce — coordinating through Supabase and accessible via Telegram.

## About Hosting The Avengers

Deploying The Avengers on Railway gives you a fully operational AI team in minutes. The template builds a Docker container with the OpenClaw gateway, 16 pre-installed MCP tool servers, and 9 agent workspaces. Set your API keys as Railway environment variables, run the included SQL schema against your Supabase database, and your agents are live. They communicate through Telegram, store all operational data in Supabase, and route LLM calls through OpenRouter with access to 13 models from DeepSeek, Anthropic, OpenAI, Google, Meta, and Mistral.

## Common Use Cases

- Automate a full sales pipeline with AI prospect research, proposal generation, email outreach, and deal tracking
- Monitor financial markets and sports betting odds with paper trading, risk management, and daily P&L reporting
- Discover trending e-commerce products, validate demand, and manage a Shopify dropshipping store
- Generate AI images and video, write platform-native copy, and post to Instagram, TikTok, Facebook, LinkedIn, X, and Threads
- Source tax deed auction properties across multiple states, run valuations, and model ROI for flip vs. rental exits
- Coordinate all 9 agents through a central COO bot that sends daily status reports to Telegram every morning

## Dependencies for The Avengers Hosting

- OpenRouter API key — routes LLM calls to 13 AI models
- Supabase project URL and service role key — PostgreSQL database for all 9 agents
- Telegram bot token — primary interface for communicating with your agents

### Deployment Dependencies

- [OpenRouter](https://openrouter.ai/keys) — Required. Multi-model LLM routing.
- [Supabase](https://supabase.com/dashboard) — Required. PostgreSQL database with Row Level Security.
- [Telegram BotFather](https://t.me/BotFather) — Required. Create your bot token.
- [Brave Search](https://api.search.brave.com/app/keys) — Recommended. Web search for all agents.
- [Serper](https://serper.dev) — Recommended. Google Search, Shopping, and Trends.
- [Replicate](https://replicate.com/account/api-tokens) — Recommended. AI image and video generation.
- [Resend](https://resend.com/api-keys) — Recommended. Email API for sales outreach.

### Implementation Details

The container runs as a non-root user with read-only workspace files. Each bot has its own workspace with persona files (SOUL.md, AGENTS.md, KNOWLEDGE.md, TOOLS.md, RULES.md) and a default LLM model with 3 fallbacks. The startup script validates API keys, masks secrets in logs, and reports active integrations before launching the gateway. 12 cron jobs handle daily intelligence gathering, content posting, market analysis, and weekly reporting across all agents.

## Why Deploy The Avengers on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying The Avengers on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
