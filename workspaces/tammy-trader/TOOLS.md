# Available Tools & How to Use Them

## Supabase (Trading Database)
Full read/write access to ALL tables.

### Key Tables:
- `trades` — Every trade (paper and real)
  - Columns: id, asset, direction, entry_price, exit_price, position_size, stop_loss, take_profit, status, pnl, pnl_pct, strategy, thesis, entry_date, exit_date
- `positions` — Currently open positions
  - Columns: id, asset, direction, entry_price, current_price, unrealized_pnl, stop_loss, take_profit, opened_at
- `performance_metrics` — Daily/weekly/monthly performance snapshots
  - Columns: id, period, total_return, win_rate, profit_factor, max_drawdown, sharpe_ratio, date
- `market_analysis` — Research notes and analysis
- `sports_bets` — Sports betting records with odds and outcomes

### Usage Pattern:
1. Log EVERY trade decision (entry and exit) immediately
2. Update positions with current prices during market hours
3. Calculate and store performance metrics weekly
4. Review historical trades to identify patterns

## Brave Search (Market Intelligence)
Research markets and news:
- "[Asset] news today"
- "[Company] earnings report Q4 2025"
- "crypto market analysis February 2026"
- "[Team] injury report [sport]"
- "economic indicators this week"
- "[Asset] technical analysis support resistance"

### Sports Research:
- "[Team] vs [Team] stats history"
- "[Sport] betting odds comparison"
- "[Player] performance statistics 2025-2026"
- "[Team] lineup injury report today"

## Fetch (Market Data)
Access specific URLs for:
- Financial news sites
- Economic calendar data
- Sports statistics databases
- Odds comparison sites
- Technical analysis charts

## Sequential Thinking (Trading Analysis)
Critical for complex trading decisions:

### Pre-Trade Checklist (use every time):
1. What's the setup? (Pattern, catalyst, data)
2. What's the entry price and why there specifically?
3. Where does the thesis break? (Stop loss level)
4. What's the target and why? (Take profit)
5. What's the position size based on risk parameters?
6. What's the risk/reward ratio? Is it ≥ 2:1?
7. Does this trade follow all risk management rules?
8. Am I trading rationally or emotionally?

### Expected Value Calculation:
```
EV = (Win Probability × Average Win) - (Loss Probability × Average Loss)
Position only if EV > 0
```

## Memory (Trading Journal)
Store persistent trading insights:
- Which strategies work best in which market conditions
- Common mistakes to avoid
- Patterns in winning vs losing trades
- Market regime indicators
