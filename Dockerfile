# ============================================
# THE AVENGERS — OpenClaw Gateway
# ============================================
# Multi-stage build for a lean, secure image

# Stage 1: Install all dependencies
FROM node:20-slim AS deps

# Install OpenClaw and all MCP server packages globally
# Pre-installing avoids flaky runtime npx downloads
RUN npm install -g \
      openclaw \
      @supabase/mcp-server-supabase \
      @brave/brave-search-mcp-server \
      serper-search-scrape-mcp-server \
      firecrawl-mcp \
      google-maps-mcp-server \
      @modelcontextprotocol/server-github \
      replicate-mcp \
      resend-mcp \
      twitter-mcp-server \
      mcp-newsapi \
      @modelcontextprotocol/server-sequential-thinking \
      @modelcontextprotocol/server-memory \
      @modelcontextprotocol/server-filesystem \
    && npm cache clean --force

# Stage 2: Production image
FROM node:20-slim

# Install curl for health checks and tini for proper signal handling
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl \
      tini \
    && rm -rf /var/lib/apt/lists/*

# Copy global node_modules and binaries from deps stage
COPY --from=deps /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=deps /usr/local/bin /usr/local/bin

# Create non-root user for security (don't run as root in production)
RUN groupadd -r avengers && useradd -r -g avengers -m -s /bin/bash avengers

WORKDIR /app

# Create required directories with proper ownership
RUN mkdir -p /home/avengers/.openclaw /app/workspaces /app/cron /app/data \
    && chown -R avengers:avengers /app /home/avengers

# Copy configuration (owned by non-root user)
COPY --chown=avengers:avengers openclaw.json /home/avengers/.openclaw/openclaw.json

# Copy workspace directories (bot persona files)
COPY --chown=avengers:avengers workspaces/ /app/workspaces/

# Copy cron job definitions
COPY --chown=avengers:avengers cron/ /app/cron/

# Copy startup script
COPY --chown=avengers:avengers start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Make workspace files read-only (bots should not modify their own persona files)
RUN find /app/workspaces -name "*.md" -exec chmod 444 {} \;

# Switch to non-root user
USER avengers

# Health check — Railway uses this to know if the service is alive
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD curl -f http://localhost:${PORT:-18789}/health || exit 1

# Use tini as init to handle signals properly (prevents zombie processes)
ENTRYPOINT ["tini", "--"]

# Start via the startup script
CMD ["/app/start.sh"]
