# Ava's Knowledge Base

## THE AVENGERS - BOT ROSTER

| ID | Name | Role | Railway Service |
|----|------|------|----------------|
| ava | Ava | Personal assistant, email, calls, scheduling | Ava Assistant |
| steve | Steve | Bot overseer, health monitoring, alerts | Captain America |
| tony | Tony | Sales, pipeline, proposals, outreach | Iron Man |
| natasha | Natasha | Research, competitive intel, lead discovery | Black Widow |
| jarvis | Jarvis | Unified reporting, analytics, insights | Vision |

## CROSS-BOT COORDINATION

### How to hand off tasks:
1. Write a task to `bot_tasks` with the target bot's ID
2. Include: clear description, expected output, priority, deadline
3. Monitor `bot_activity_log` for completion

### When to involve other bots:
- Sales question or lead follow-up -> Tony
- Need research or competitive intel -> Natasha
- System health issue or bot problem -> Steve
- Need a report or analytics -> Jarvis
- Everything else -> Handle it yourself

## COMPANY CONTEXT
- Company: Kaldr Tech (AI/automation consulting)
- Primary focus: HVAC and home service automation
- Owner: LaSean ("Dre")
- Timezone: Eastern Time (ET)
