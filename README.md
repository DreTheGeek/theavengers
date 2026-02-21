# Deploy and Host The Avengers on Railway

The Avengers is a fleet of 9 AI agents powered by OpenClaw that run 24/7 as a single Docker service. Each agent has domain expertise — sales, trading, research, content, code, real estate, e-commerce — coordinating through Supabase and accessible via Telegram.

## Architecture

Based on [vignesh07/clawdbot-railway-template](https://github.com/vignesh07/clawdbot-railway-template) (165 stars, 646 forks) with multi-agent extensions.

```
Browser / Telegram
       |
  Express Wrapper (port 8080, public)
       |
       |--- /setup/*       → Setup wizard (Basic auth)
       |--- /setup/healthz → Healthcheck
       |--- /setup/export  → Backup download
       |--- /*             → Reverse proxy to gateway
       |
  OpenClaw Gateway (port 18789, loopback)
       |
  LLM APIs via OpenRouter → 13 models
```

The wrapper manages the OpenClaw lifecycle: onboarding → agent config patching → gateway startup → traffic proxying. On first deploy, 9 agent workspaces and 12 cron jobs are automatically seeded from the Docker image into the Railway volume.

## Quick Start

1. Deploy this template on Railway
2. Railway provisions a /data volume automatically
3. Set `SETUP_PASSWORD` in Railway Variables
4. Visit `https://your-app.up.railway.app/setup`
5. Choose OpenRouter as auth provider, paste your API key
6. Enter your Telegram bot token
7. Click Run Setup — the 9 agents are automatically configured
8. Open Telegram, message your bot, and start working

## The 9 Agents

| Agent | Role | Primary Model |
|-------|------|--------------|
| Optimus Prime | COO — coordination, daily reports, monitoring | DeepSeek Chat |
| Benny Builder | Strategic Growth — weekly opportunity analysis | DeepSeek Reasoner |
| Rhianna Research | Intelligence — prospect discovery, market research | DeepSeek Chat |
| Ava Analyst | Revenue — sales pipeline, proposals, outreach | DeepSeek Chat |
| Tammy Trader | Trading — stocks, crypto, forex, sports betting | DeepSeek Reasoner |
| Randy Realty | Real Estate — tax deed auctions, property analysis | DeepSeek Chat |
| Deondre Dropshipping | E-Commerce — product discovery, Shopify management | DeepSeek Chat |
| Cleah Coding | CTO — code, GitHub, deployments, security | DeepSeek Reasoner |
| Carter Content | Marketing — AI images/video, social media posting | DeepSeek Chat |

## Dependencies

### Required
- [OpenRouter](https://openrouter.ai/keys) — Multi-model LLM routing (13 models)
- [Supabase](https://supabase.com/dashboard) — PostgreSQL database for all 9 agents
- [Telegram BotFather](https://t.me/BotFather) — Primary communication channel

### Recommended
- [Brave Search](https://api.search.brave.com/app/keys) — Web search for all agents
- [Serper](https://serper.dev) — Google Search, Shopping, and Trends
- [Replicate](https://replicate.com/account/api-tokens) — AI image and video generation
- [Resend](https://resend.com/api-keys) — Email API for sales outreach

## Implementation Details

OpenClaw is built from source (pinned to a release tag) in a multi-stage Docker build. 13 MCP tool servers are pre-installed globally. The Express wrapper provides a setup wizard at `/setup`, reverse proxies to the internal gateway with auto-injected bearer token auth, and manages gateway lifecycle (start, health-check, auto-restart, graceful shutdown).

Each agent has its own workspace with persona files (SOUL.md, AGENTS.md, KNOWLEDGE.md, TOOLS.md, RULES.md) and a default LLM model with 3 fallbacks. 12 cron jobs handle daily intelligence gathering, content posting, market analysis, and weekly reporting.

State persists across redeploys via a Railway volume at `/data`. The setup wizard handles initial onboarding, and the 9-agent config is automatically patched in after setup completes.

## Local Testing

```bash
docker build -t theavengers .

docker run --rm -p 8080:8080 \
  -e SETUP_PASSWORD=test \
  -e OPENCLAW_STATE_DIR=/data/.openclaw \
  -e OPENCLAW_WORKSPACE_DIR=/data/workspace \
  -v $(pwd)/.tmpdata:/data \
  theavengers

# Visit http://localhost:8080/setup (password: test)
```

## FAQ

**How do I access the setup wizard?**
Visit `https://your-app.up.railway.app/setup` and enter your `SETUP_PASSWORD`.

**How do I add my Telegram bot?**
Enter the bot token during setup. The 9 agents are pre-configured — Optimus Prime handles all Telegram DMs by default.

**How do I approve Telegram pairing?**
Use the "Approve pairing" button in the setup wizard, or the Debug Console.

**How do I reset and start over?**
Click "Reset setup" in the wizard. This deletes the config file but keeps your workspace data.

**How do I back up my data?**
Click "Download backup" in the setup wizard to export a .tar.gz of your /data volume.
