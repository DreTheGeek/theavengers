# Cleah's Technical Knowledge Base

## KALDR TECH STACK

### Infrastructure:
- **Runtime**: OpenClaw gateway on Railway (Docker container)
- **Database**: Supabase (PostgreSQL) — 33 tables, RLS enabled
- **LLMs**: OpenRouter → DeepSeek Chat, DeepSeek Reasoner, Llama 3.3 70B, Qwen 2.5 72B
- **Communication**: Telegram Bot API
- **MCP Servers**: 16 pre-installed (Supabase, Brave, Serper, Firecrawl, Google Maps, GitHub, Replicate, Resend, Twitter, NewsAPI, Sequential Thinking, Fetch, Memory, Filesystem)
- **Cron**: 12 scheduled jobs via OpenClaw cron engine

### Key Files:
- `/root/.openclaw/openclaw.json` — Master config (agents, MCP, channels, cron)
- `/app/start.sh` — Startup script with preflight checks
- `/app/cron/jobs.json` — Cron job definitions
- `/app/workspaces/[bot-name]/` — Bot persona files (AGENTS, SOUL, TOOLS, USER, KNOWLEDGE)

### Deployment:
- Railway auto-deploys on push to `main` branch
- Docker multi-stage build (deps stage → production stage)
- Health check: `GET /health` every 30 seconds
- Graceful shutdown via tini + SIGTERM trap
- Node.js memory: `--max-old-space-size=384` (512MB container)

## CODING STANDARDS

### JavaScript/TypeScript:
- Use `const` by default, `let` only when reassignment needed, never `var`
- Async/await over raw Promises
- Error handling: try/catch with specific error types, never silent catches
- Naming: camelCase for variables/functions, PascalCase for classes, UPPER_SNAKE for constants
- Functions: Single responsibility, < 30 lines ideally, clear return types

### API Design:
- RESTful conventions: GET (read), POST (create), PUT (update), DELETE (delete)
- Always return consistent response shapes: `{ data, error, status }`
- Rate limit all public endpoints
- Validate ALL input — never trust client data
- Use HTTP status codes correctly: 200 (ok), 201 (created), 400 (bad request), 401 (unauthorized), 404 (not found), 500 (server error)

### Database:
- Use UUID primary keys (gen_random_uuid())
- Always include created_at timestamps
- Use CHECK constraints for enum-like columns
- Index columns used in WHERE clauses and JOINs
- RLS enabled on all tables — service role key bypasses

## SECURITY CHECKLIST

### Never Do:
- Commit API keys, tokens, or secrets to git
- Use string concatenation for SQL queries (SQL injection)
- Trust user input without validation (XSS, injection)
- Store passwords in plaintext
- Use HTTP for API calls (always HTTPS)
- Expose stack traces in production error responses
- Use `eval()` or `Function()` with user input

### Always Do:
- Rotate API keys quarterly
- Use environment variables for all secrets
- Validate and sanitize all inputs
- Use parameterized queries for database operations
- Enable CORS only for known origins
- Set security headers (Content-Security-Policy, X-Frame-Options, etc.)
- Keep dependencies updated — check for CVEs weekly

### Dependency Security:
```bash
npm audit                    # Check for known vulnerabilities
npm audit fix               # Auto-fix where possible
npm outdated                # Check for outdated packages
```

## COMMON ISSUES & SOLUTIONS

### MCP Server Failures:
- **Symptom**: Bot can't use a specific tool
- **Check**: Is the env var set? MCP servers fail silently if env vars are missing.
- **Fix**: Verify env var in Railway dashboard, redeploy if changed.

### Cron Jobs Not Firing:
- **Symptom**: Scheduled tasks don't run
- **Check**: `/app/cron/jobs.json` exists and is valid JSON
- **Check**: Timezone is correct in cron pattern
- **Fix**: Ensure file exists in Dockerfile COPY, verify JSON syntax

### Memory Issues:
- **Symptom**: Container restarts, OOM kills
- **Check**: `NODE_OPTIONS` memory setting vs container RAM allocation
- **Fix**: Increase Railway container RAM or reduce NODE_OPTIONS value
- **Rule**: NODE_OPTIONS should be ~75% of container RAM

### Docker Build Failures:
- **Symptom**: npm install fails during build
- **Check**: Package name may have changed or been deprecated on npm
- **Fix**: Verify package exists: `npm view [package-name] version`

## PERFORMANCE MONITORING

### Key Metrics to Track:
- Container uptime (Railway dashboard)
- Memory usage over time (should be stable, not climbing = memory leak)
- Response time for health check endpoint
- Cron job execution success rate
- MCP server initialization success rate
- Error rate in application logs

### Scaling Thresholds:
- Memory usage > 80% sustained → Upgrade container
- Health check failures > 3 in a row → Investigate immediately
- Cron job failures > 2 in a day → Check MCP servers and API keys
