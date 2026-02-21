# ============================================
# THE AVENGERS — OpenClaw Gateway
# Multi-stage build based on vignesh07/clawdbot-railway-template
# 9 Agents | 13 MCP Servers | Full Ecosystem
# ============================================

# Stage 1: Build OpenClaw from source (pinned to a known-good release)
FROM node:22-bookworm AS openclaw-build

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    curl \
    python3 \
    make \
    g++ \
  && rm -rf /var/lib/apt/lists/*

# Install Bun (openclaw build uses it)
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

RUN corepack enable

WORKDIR /openclaw

# Pin to a known-good ref (tag/branch). Override in Railway template settings if needed.
ARG OPENCLAW_GIT_REF=v2026.2.9
RUN git clone --depth 1 --branch "${OPENCLAW_GIT_REF}" https://github.com/openclaw/openclaw.git .

# Patch: relax version requirements for packages that may reference unpublished versions.
RUN set -eux; \
  find ./extensions -name 'package.json' -type f | while read -r f; do \
    sed -i -E 's/"openclaw"[[:space:]]*:[[:space:]]*">=[^"]+"/"openclaw": "*"/g' "$f"; \
    sed -i -E 's/"openclaw"[[:space:]]*:[[:space:]]*"workspace:[^"]+"/"openclaw": "*"/g' "$f"; \
  done

RUN pnpm install --no-frozen-lockfile
RUN pnpm build
ENV OPENCLAW_PREFER_PNPM=1
RUN pnpm ui:install && pnpm ui:build


# Stage 2: Runtime image
FROM node:22-bookworm
ENV NODE_ENV=production

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    tini \
    git \
    python3 \
    python3-venv \
  && rm -rf /var/lib/apt/lists/*

# Force git to use HTTPS instead of SSH (some MCP server deps use git)
RUN git config --global url."https://github.com/".insteadOf "ssh://git@github.com/" \
  && git config --global --add url."https://github.com/".insteadOf "git@github.com:"

# Install all 13 MCP server packages globally (before /data prefix is set)
RUN npm install -g --prefer-online \
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

# OpenClaw update expects pnpm. Provide it in the runtime image.
RUN corepack enable && corepack prepare pnpm@10.23.0 --activate

# Persist user-installed tools by targeting the Railway volume at runtime.
# npm/pnpm installs done AFTER deploy go to /data so they survive redeploys.
ENV NPM_CONFIG_PREFIX=/data/npm
ENV NPM_CONFIG_CACHE=/data/npm-cache
ENV PNPM_HOME=/data/pnpm
ENV PNPM_STORE_DIR=/data/pnpm-store
ENV PATH="/data/npm/bin:/data/pnpm:${PATH}"

WORKDIR /app

# Wrapper dependencies
COPY package.json package-lock.json ./
RUN npm install --omit=dev && npm cache clean --force

# Copy built OpenClaw from build stage
COPY --from=openclaw-build /openclaw /openclaw

# Provide an openclaw executable
RUN printf '%s\n' '#!/usr/bin/env bash' 'exec node /openclaw/dist/entry.js "$@"' > /usr/local/bin/openclaw \
  && chmod +x /usr/local/bin/openclaw

# Copy wrapper server + setup wizard
COPY src ./src

# Copy Avengers seed data (workspaces, cron jobs, agent config)
COPY seed ./seed
COPY workspaces ./seed/workspaces
COPY cron ./seed/cron

EXPOSE 8080

# Ensure PID 1 reaps zombies and forwards signals.
ENTRYPOINT ["tini", "--"]
CMD ["node", "src/server.js"]
