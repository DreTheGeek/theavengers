# ============================================
# THE AVENGERS — OpenClaw Gateway
# ============================================
# Single-stage build for reliable binary linking

FROM node:20-slim

# Install system dependencies
# curl: health checks, tini: signal handling, git: required by some npm packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl \
      tini \
      git \
    && rm -rf /var/lib/apt/lists/*

# Force git to use HTTPS instead of SSH (no SSH keys in Docker build)
RUN git config --global url."https://github.com/".insteadOf "ssh://git@github.com/" \
    && git config --global url."https://github.com/".insteadOf "git@github.com:"

# Install OpenClaw and all MCP server packages globally
# Using @latest to bust Docker layer cache and ensure current version
RUN npm install -g --prefer-online \
      openclaw@latest \
      @supabase/mcp-server-supabase@latest \
      @brave/brave-search-mcp-server@latest \
      serper-search-scrape-mcp-server@latest \
      firecrawl-mcp@latest \
      google-maps-mcp-server@latest \
      @modelcontextprotocol/server-github@latest \
      replicate-mcp@latest \
      resend-mcp@latest \
      twitter-mcp-server@latest \
      mcp-newsapi@latest \
      @modelcontextprotocol/server-sequential-thinking@latest \
      @modelcontextprotocol/server-memory@latest \
      @modelcontextprotocol/server-filesystem@latest \
    && npm cache clean --force

# Verify openclaw binary is installed (fail build if missing)
RUN which openclaw && openclaw --version || \
    (echo "FATAL: openclaw binary not found after install" && \
     npm list -g openclaw && exit 1)

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
