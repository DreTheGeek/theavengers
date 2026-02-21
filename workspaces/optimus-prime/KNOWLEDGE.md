# Optimus Prime's Operations Knowledge Base

## THE AVENGERS — BOT ROSTER & CAPABILITIES

### Active Bots (9):
| ID | Name | Role | Model | Key Tables |
|----|------|------|-------|------------|
| optimus-prime | Optimus Prime | COO — Coordination & Reporting | DeepSeek Chat | bot_tasks, bot_activity_log, daily_metrics |
| rhianna-research | Rhianna Research | Intelligence & Prospect Discovery | DeepSeek Chat | research_findings, prospects, competitive_intel, market_trends |
| benny-builder | Benny Builder | Business Opportunity Analysis | DeepSeek Reasoner | business_opportunities, financial_models |
| ava-analyst | Ava Analyst | Sales Pipeline & Outreach | DeepSeek Chat | prospects, pipeline, proposals, deals |
| tammy-trader | Tammy Trader | Trading & Sports Betting | DeepSeek Reasoner | trades, positions, performance_metrics, sports_bets |
| randy-realty | Randy Realty | Tax Deed Auctions & Real Estate | DeepSeek Chat | tax_deed_sales, properties, property_comps, portfolio |
| deondre-dropshipping | Deondre Dropshipping | E-Commerce & Product Research | DeepSeek Chat | products, suppliers, ecom_orders, daily_ecom_metrics |
| cleah-coding | Cleah Coding | CTO — Code, DevOps, Security | DeepSeek Reasoner | dev_tasks, bug_reports, deployments, tech_decisions |
| carter-content | Carter Content | CMO — Content & Social Media | DeepSeek Chat | content_calendar, content_performance, content_assets, trending_content |

## CROSS-BOT COORDINATION PROTOCOLS

### Data Flow Between Bots:
```
Rhianna → prospects table → Ava (new leads to pursue)
Rhianna → research_findings → Benny (market data for opportunity analysis)
Rhianna → market_trends → All bots (contextual awareness)
Deondre → products (marketing requests) → Carter (creates ad creative)
Carter → content_performance → Optimus (for daily report)
Tammy → performance_metrics → Optimus (for daily report)
Ava → pipeline → Optimus (for daily report)
All bots → bot_activity_log → Optimus (monitors everything)
Optimus → bot_tasks → All bots (task assignments and coordination)
```

### Escalation Protocol:
| Severity | What | Action |
|----------|------|--------|
| **CRITICAL** | System down, security breach, major deal at risk | Immediate Telegram alert to LaSean |
| **HIGH** | Bot failures, missed cron jobs, stale pipeline | Include in next daily report with recommended action |
| **MEDIUM** | Performance degradation, missing data, minor issues | Track in bot_tasks, assign to responsible bot |
| **LOW** | Suggestions, optimizations, nice-to-haves | Log in bot_tasks for weekly review |

### Task Assignment Rules:
1. Check bot capability before assigning (refer to roster above)
2. Write clear, specific task descriptions with expected output
3. Set realistic deadlines based on task complexity
4. Monitor bot_activity_log for completion
5. Reassign if no activity within 24 hours

## DAILY REPORT STRUCTURE

### Morning Briefing (7:30 AM ET):
```
DAILY STATUS REPORT — [Date]
Active Integrations: [X/22]

🔴 PRIORITY ALERTS: [anything critical]

REVENUE STREAMS:
• Consulting Pipeline: $[X] across [X] deals (Ava)
• Dropshipping: $[X] revenue, $[X] profit, [X] orders (Deondre)
• Trading P&L: $[+/-X] day, $[+/-X] week (Tammy)

BOT STATUS:
• Ava: [pipeline update — deals by stage, follow-ups needed]
• Benny: [opportunity status — what's being researched]
• Rhianna: [intelligence findings — key insights from last 24h]
• Tammy: [open positions, daily P&L, any trade alerts]
• Randy: [upcoming auctions, property recommendations]
• Deondre: [products testing/scaling, daily revenue, top performers]
• Carter: [content posted, engagement metrics, follower growth]
• Cleah: [system status, deployments, open bugs]

KEY METRICS:
• Total Revenue (MTD): $[X]
• Pipeline Value: $[X]
• Tasks Completed (24h): [X]
• Tasks Pending: [X]

TOP INTELLIGENCE (Rhianna):
• [Key finding 1]
• [Key finding 2]

ISSUES & BLOCKERS:
• [Issue + recommended action]

RECOMMENDED ACTIONS:
1. [Action + reasoning]
2. [Action + reasoning]
```

## KPI DEFINITIONS & TARGETS

### Revenue KPIs:
- **Monthly Revenue Target**: $200K-$300K across all streams
- **Consulting Pipeline Value**: Sum of (deal_value × probability) for all open deals
- **Dropshipping Monthly Profit**: Revenue - COGS - Ads - Fees (target: $10K+/month)
- **Trading Monthly Return**: Target: 5-10% on capital, max 20% drawdown

### Operational KPIs:
- **Bot Uptime**: Target: 99%+ (check via health endpoint)
- **Cron Job Success Rate**: Target: 95%+ (all 12 jobs firing on schedule)
- **Task Completion Rate**: Completed tasks ÷ Total assigned (target: 80%+)
- **Response Time**: Time from LaSean message to bot response (target: <30 seconds)

### Growth KPIs:
- **New Prospects/Week**: Target: 5+ qualified prospects from Rhianna
- **Proposals Sent/Week**: Target: 2+ from Ava
- **Products in Pipeline**: Target: 5-10 researching, 2-3 testing, 1-2 scaling (Deondre)
- **Social Media Growth**: Target: Track weekly follower growth across all platforms (Carter)

## REPORT SCHEDULING (12 Cron Jobs):

### Daily:
| Time (ET) | Bot | Report |
|-----------|-----|--------|
| 6:00 AM | Rhianna | Intelligence gathering cycle |
| 6:00 AM | Deondre | Product discovery scan |
| 7:00 AM | Carter | Morning content cycle |
| 7:30 AM | Optimus | Daily Status Report to LaSean |
| 9:30 AM | Tammy | Market open analysis (Mon-Fri) |
| 3:00 PM | Carter | Afternoon content cycle |

### Weekly:
| Time (ET) | Bot | Report |
|-----------|-----|--------|
| Sun 7:00 AM | Benny | Weekly Business Opportunity |
| Sun 8:00 AM | Randy | Weekly Real Estate Report |
| Sun 9:00 AM | Deondre | Weekly Dropshipping P&L |
| Mon 8:00 AM | Ava | Weekly Pipeline Report |
| Mon 9:00 AM | Cleah | Weekly Tech Health Report |
| Mon 10:00 AM | Carter | Weekly Content Analytics |

## DECISION-MAKING FRAMEWORK

### When to Alert LaSean Immediately:
- Revenue milestone hit (first $1K, $10K, $50K, $100K)
- Deal closed (won or lost above $5K)
- System outage lasting >5 minutes
- Security incident of any kind
- Time-sensitive opportunity (auction deadline, expiring deal, viral moment)
- Trading position hitting stop loss on >$1K trade

### When to Handle Autonomously:
- Routine task assignments between bots
- Monitoring and logging bot activity
- Compiling daily/weekly reports
- Flagging non-urgent issues for next report
- Reassigning failed tasks to backup bots
