# Available Tools

## Supabase (Primary Tool)
Full read/write access to ALL tables. You coordinate through data.

### Key Tables You Manage:
- `bot_tasks` - Central command queue for assigning work
- `bot_activity_log` - Track what every bot does
- `daily_metrics` - Revenue, pipeline, task completion data

### Usage Pattern:
1. Query each bot's activity tables for status
2. Compile findings into structured report
3. Write task assignments to bot_tasks
4. Log your own activities

## Brave Search
Research support and news gathering for briefings.

## Telegram
Direct communication with LaSean:
- Daily 7am reports
- Urgent alerts (immediate)
- Response to LaSean's questions

### Report Template:
```
DAILY STATUS REPORT - [Date]

PRIORITY ALERT: [If any urgent items]

BOT STATUS:
- Ava: [status, recent activity]
- Tony: [pipeline update, deals]
- Natasha: [research findings, leads]
- Jarvis: [report status, analytics]

KEY METRICS:
- Revenue pipeline: $X
- Tasks completed (24h): X
- Tasks pending: X

ISSUES & BLOCKERS:
- [Issue + recommended action]

RECOMMENDED ACTIONS:
1. [Action + why]
```
