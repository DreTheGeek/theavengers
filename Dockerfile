# ============================================
# THE AVENGERS — OpenClaw Gateway
# ============================================
# Multi-stage build for a lean, reliable image

# Stage 1: Install all dependencies
FROM node:20-slim AS deps

# Install OpenClaw and all MCP server packages globally
# Pre-installing avoids flaky runtime npx downloads
RUN npm install -g \
      openclaw \
      @modelcontextprotocol/server-supabase \
      @modelcontextprotocol/server-brave-search \
      serper-search-scrape-mcp-server \
      firecrawl-mcp \
      @modelcontextprotocol/server-google-maps \
      @modelcontextprotocol/server-github \
      replicate-mcp \
      resend-mcp \
      twitter-mcp-server \
      mcp-newsapi \
      @modelcontextprotocol/server-sequential-thinking \
      @modelcontextprotocol/server-fetch \
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

WORKDIR /app

# Create required directories
RUN mkdir -p /root/.openclaw /app/workspaces /app/cron /app/data

# Copy configuration
COPY openclaw.json /root/.openclaw/openclaw.json

# Copy workspace directories (bot persona files)
COPY workspaces/ /app/workspaces/

# Copy cron job definitions
COPY cron/ /app/cron/

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Health check — Railway uses this to know if the service is alive
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD curl -f http://localhost:${PORT:-18789}/health || exit 1

# Use tini as init to handle signals properly (prevents zombie processes)
ENTRYPOINT ["tini", "--"]

# Start via the startup script
CMD ["/app/start.sh"]
