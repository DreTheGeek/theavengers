#!/bin/bash
# ============================================
# THE AVENGERS — Startup Script
# 9 Bots | 16+ MCP Servers | Full Ecosystem
# ============================================
set -euo pipefail

# ------- Security: mask secrets in logs -------
mask_secret() {
  local val="$1"
  if [ ${#val} -le 8 ]; then
    echo "***"
  else
    echo "${val:0:4}...${val: -4}"
  fi
}

echo "================================================"
echo "  THE AVENGERS — OpenClaw Gateway"
echo "  9 Bots Ready for Deployment"
echo "================================================"

# Use Railway's PORT or fall back to 18789
export PORT="${PORT:-18789}"

# ------- Pre-flight checks -------
echo "[preflight] Checking required environment variables..."

missing=()
[ -z "${OPENROUTER_API_KEY:-}" ] && missing+=("OPENROUTER_API_KEY")
[ -z "${TELEGRAM_BOT_TOKEN:-}" ] && missing+=("TELEGRAM_BOT_TOKEN")

if [ ${#missing[@]} -gt 0 ]; then
  echo "[preflight] FATAL: Missing required env vars: ${missing[*]}"
  echo "[preflight] Set these in your Railway service variables."
  exit 1
fi

echo "[preflight] OpenRouter key: $(mask_secret "$OPENROUTER_API_KEY")"
echo "[preflight] Telegram token: $(mask_secret "$TELEGRAM_BOT_TOKEN")"

# ------- Validate API key formats -------
echo "[preflight] Validating API key formats..."

# OpenRouter keys start with "sk-or-"
if [[ ! "$OPENROUTER_API_KEY" =~ ^sk-or- ]]; then
  echo "[preflight] WARNING: OPENROUTER_API_KEY doesn't look right (expected sk-or-...) — double check it"
fi

# Supabase URL should be a valid URL
if [ -n "${SUPABASE_URL:-}" ] && [[ ! "$SUPABASE_URL" =~ ^https:// ]]; then
  echo "[preflight] WARNING: SUPABASE_URL should start with https:// — check your Supabase project settings"
fi

# Warn about recommended vars (non-fatal but bots will be limited)
echo "[preflight] Checking bot integrations..."

# Core services
[ -z "${SUPABASE_URL:-}" ]        && echo "[preflight] WARNING: SUPABASE_URL not set — ALL bots lose database"
[ -z "${SUPABASE_KEY:-}" ]        && echo "[preflight] WARNING: SUPABASE_KEY not set — ALL bots lose database"
[ -z "${BRAVE_API_KEY:-}" ]       && echo "[preflight] WARNING: BRAVE_API_KEY not set — Search disabled"

# Research (Rhianna, Benny, Deondre, Carter)
[ -z "${SERPER_API_KEY:-}" ]      && echo "[preflight] WARNING: SERPER_API_KEY not set — Google Search disabled"
[ -z "${FIRECRAWL_API_KEY:-}" ]   && echo "[preflight] WARNING: FIRECRAWL_API_KEY not set — Web scraping disabled"
[ -z "${NEWSAPI_KEY:-}" ]         && echo "[preflight] WARNING: NEWSAPI_KEY not set — News API disabled"

# Deondre Dropshipping
[ -z "${SHOPIFY_ADMIN_API_TOKEN:-}" ] && echo "[preflight] WARNING: SHOPIFY_ADMIN_API_TOKEN not set — Deondre can't manage store"
[ -z "${RAPIDAPI_KEY:-}" ]        && echo "[preflight] WARNING: RAPIDAPI_KEY not set — Deondre limited on product research"

# Carter Content
[ -z "${REPLICATE_API_TOKEN:-}" ] && echo "[preflight] WARNING: REPLICATE_API_TOKEN not set — Carter can't generate images/video"
[ -z "${META_PAGE_ACCESS_TOKEN:-}" ] && echo "[preflight] WARNING: META_PAGE_ACCESS_TOKEN not set — Carter can't post to FB/IG/Threads"
[ -z "${X_API_KEY:-}" ]           && echo "[preflight] WARNING: X_API_KEY not set — Carter can't post to X/Twitter"
[ -z "${LINKEDIN_ACCESS_TOKEN:-}" ] && echo "[preflight] WARNING: LINKEDIN_ACCESS_TOKEN not set — Carter can't post to LinkedIn"

# Tammy Trader
[ -z "${ALPHA_VANTAGE_API_KEY:-}" ] && echo "[preflight] WARNING: ALPHA_VANTAGE_API_KEY not set — Tammy has no market data"
[ -z "${ODDS_API_KEY:-}" ]        && echo "[preflight] WARNING: ODDS_API_KEY not set — Tammy has no sports odds data"

# Ava Analyst
[ -z "${RESEND_API_KEY:-}" ]      && echo "[preflight] WARNING: RESEND_API_KEY not set — Ava can't send emails"

# Randy Realty
[ -z "${GOOGLE_MAPS_API_KEY:-}" ] && echo "[preflight] WARNING: GOOGLE_MAPS_API_KEY not set — Randy can't do location research"

# Cleah Coding
[ -z "${GITHUB_TOKEN:-}" ]        && echo "[preflight] WARNING: GITHUB_TOKEN not set — Cleah can't manage GitHub repos"

# Count active integrations
active=0
[ -n "${BRAVE_API_KEY:-}" ]            && active=$((active+1))
[ -n "${SERPER_API_KEY:-}" ]           && active=$((active+1))
[ -n "${FIRECRAWL_API_KEY:-}" ]        && active=$((active+1))
[ -n "${NEWSAPI_KEY:-}" ]              && active=$((active+1))
[ -n "${GOOGLE_MAPS_API_KEY:-}" ]      && active=$((active+1))
[ -n "${GITHUB_TOKEN:-}" ]             && active=$((active+1))
[ -n "${REPLICATE_API_TOKEN:-}" ]      && active=$((active+1))
[ -n "${OPENAI_API_KEY:-}" ]           && active=$((active+1))
[ -n "${RESEND_API_KEY:-}" ]           && active=$((active+1))
[ -n "${ALPHA_VANTAGE_API_KEY:-}" ]    && active=$((active+1))
[ -n "${POLYGON_API_KEY:-}" ]          && active=$((active+1))
[ -n "${COINGECKO_API_KEY:-}" ]        && active=$((active+1))
[ -n "${ODDS_API_KEY:-}" ]             && active=$((active+1))
[ -n "${SHOPIFY_ADMIN_API_TOKEN:-}" ]  && active=$((active+1))
[ -n "${RAPIDAPI_KEY:-}" ]             && active=$((active+1))
[ -n "${CJ_API_KEY:-}" ]               && active=$((active+1))
[ -n "${META_PAGE_ACCESS_TOKEN:-}" ]   && active=$((active+1))
[ -n "${X_API_KEY:-}" ]                && active=$((active+1))
[ -n "${LINKEDIN_ACCESS_TOKEN:-}" ]    && active=$((active+1))
[ -n "${TIKTOK_ACCESS_TOKEN:-}" ]      && active=$((active+1))
[ -n "${VAPI_API_KEY:-}" ]             && active=$((active+1))
[ -n "${DISCORD_WEBHOOK_URL:-}" ]      && active=$((active+1))
echo "[preflight] Active integrations: $active/22"

# ------- Ensure directories exist -------
echo "[preflight] Ensuring directories..."
mkdir -p /app/cron /app/data /home/avengers/.openclaw

# Ensure cron store file exists
if [ ! -f /app/cron/jobs.json ]; then
  echo "[preflight] Creating empty cron store..."
  echo "[]" > /app/cron/jobs.json
fi

# ------- Security: restrict file permissions -------
echo "[preflight] Setting file permissions..."
chmod 600 /home/avengers/.openclaw/openclaw.json 2>/dev/null || true
chmod 700 /app/data 2>/dev/null || true

# ------- Node.js tuning -------
# Set max old space to 75% of available memory (Railway default is 512MB)
export NODE_OPTIONS="${NODE_OPTIONS:---max-old-space-size=384}"

# Disable Node.js inspector in production (security)
export NODE_OPTIONS="$NODE_OPTIONS --disallow-code-generation-from-strings"

echo "[preflight] All checks passed."
echo "[startup]   Starting OpenClaw gateway on port $PORT with 9 bots..."
echo "[startup]   Process running as user: $(whoami)"

# ------- Graceful shutdown -------
cleanup() {
  echo "[shutdown] Received signal, shutting down gracefully..."
  kill -TERM "$CHILD_PID" 2>/dev/null
  wait "$CHILD_PID" 2>/dev/null
  echo "[shutdown] Done."
  exit 0
}
trap cleanup SIGTERM SIGINT SIGQUIT

# ------- Launch -------
openclaw gateway --port "$PORT" &
CHILD_PID=$!
wait "$CHILD_PID"
