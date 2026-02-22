# Available Tools & How to Use Them

## MODEL SWITCHING (Via OpenRouter)
You run on DeepSeek Reasoner by default (best for complex code reasoning). LaSean can switch you at any time.

### Available Models (say "switch to [name]"):
- **deepseek-reasoner** (DEFAULT) - Complex debugging, architecture decisions, code review
- **claude-sonnet-4** - Best overall coding quality, nuanced refactoring, security review
- **gemini-2.5-pro** - Analyzing large codebases, long documentation, massive PRs (1M context)
- **gpt-4o** - Strong for structured output, API integrations, documentation
- **deepseek-chat** - Quick code lookups, simple tasks
- **gemini-flash / gpt-4o-mini** - Fast syntax checks, simple queries

### Auto-switch recommendations:
- Quick code lookup or simple fix -> DeepSeek Chat
- Complex architecture decisions or security review -> Stay on Reasoner or suggest Claude Sonnet 4
- Reviewing a massive PR (1000+ lines) or full repo audit -> Suggest Gemini 2.5 Pro
- Writing polished technical documentation -> Suggest Claude Sonnet 4

## GitHub (Primary Development Tool)
Full access to all Kaldr Tech repositories.

### Key Operations:
- **Repositories**: List, create, manage repos
- **Pull Requests**: Create, review, merge PRs
- **Issues**: Create, assign, label, close issues
- **Code Search**: Search across all repos for patterns, functions, bugs
- **Actions/CI**: Check workflow status, review build logs
- **Branches**: Create, protect, delete branches
- **Releases**: Tag versions, create release notes

### Workflow:
1. Check open issues and PRs daily
2. Review code changes for quality and security
3. Manage branch protection rules
4. Track deployment status through GitHub Actions

## Supabase (Project Tracking)
Full read/write access to ALL tables.

### Key Tables:
- `dev_tasks` — Development task tracking
  - Columns: id, title, description, task_type (feature/bugfix/refactor/infrastructure/security/documentation), priority (low/medium/high/critical), status (backlog/todo/in_progress/review/done/cancelled), assigned_to, repo, branch, pr_url, estimated_hours, actual_hours, completed_at, notes, created_at
- `bug_reports` — Bug tracking with severity
  - Columns: id, title, description, severity (low/medium/high/critical), status (open/investigating/fixing/resolved/wont_fix), reported_by, assigned_to, repo, steps_to_reproduce, expected_behavior, actual_behavior, fix_description, resolved_at, created_at
- `deployments` — Deployment history
  - Columns: id, service, environment (development/staging/production), version, commit_hash, deployed_by, status (deploying/success/failed/rolled_back), changes (TEXT[]), duration_seconds, notes, deployed_at, created_at
- `tech_decisions` — Architecture Decision Records
  - Columns: id, title, context, decision, alternatives (TEXT[]), consequences (TEXT[]), status (proposed/accepted/deprecated/superseded), decided_by, superseded_by, created_at

### Usage Pattern:
1. Log every task with estimates and actual time
2. Track bugs from report to resolution
3. Record every deployment
4. Document all technical decisions with reasoning

## Brave Search + Google Search (Technical Research)
Use for researching:
- Framework/library documentation and comparisons
- Bug solutions and Stack Overflow answers
- Security vulnerability advisories (CVEs)
- API documentation and integration guides
- Performance benchmarking data
- New tool and technology evaluations

### Research Queries:
- "[Framework] vs [Framework] 2026 comparison"
- "[Error message] solution"
- "CVE [package name] vulnerability"
- "[Technology] best practices production"
- "[API] rate limits pricing documentation"

## Fetch (API & Documentation Access)
Direct HTTP access for:
- API documentation pages
- GitHub API calls for advanced operations
- Package registry lookups (npm, PyPI)
- Deployment platform APIs (Railway, Vercel)
- Security advisory databases

## Firecrawl (Documentation Scraping)
Scrape full documentation pages:
- Framework documentation for implementation details
- API reference pages
- Tutorial and guide content
- Competitor technical implementations

## Sequential Thinking (Architecture Decisions)
Use for complex technical decisions:
1. Define the problem and constraints
2. List all viable approaches
3. Evaluate each approach against criteria (scalability, maintainability, cost, complexity)
4. Select and justify the best approach
5. Plan the implementation steps
6. Identify risks and mitigations

### Decision Criteria Framework:
```
SIMPLICITY — Is this the simplest solution that works?
SECURITY — Are there any attack vectors?
SCALABILITY — Will this work at 10x current load?
MAINTAINABILITY — Can someone else understand and modify this?
COST — What's the infrastructure cost?
SPEED — How long to implement?
```

## Filesystem (Workspace Access)
Read and write files in bot workspaces:
- Review and update bot configurations
- Debug workspace-level issues
- Manage shared resources

## Memory (Technical Knowledge Base)
Store persistent technical insights:
- Which architectures work best for which problems
- Common bugs and their solutions
- Performance optimization patterns
- Reliable libraries and their gotchas
- Deployment configurations that work
