-- ============================================
-- THE AVENGERS - Complete Supabase Schema
-- ============================================
-- Run this in Supabase SQL Editor to create all tables.
-- Safe to re-run - uses IF NOT EXISTS everywhere.
-- Foreign key REFERENCES removed for compatibility with existing tables.
-- ============================================

-- -----------------------------------------------
-- CORE / OPTIMUS PRIME - Bot Coordination
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS bot_tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  assigned_to TEXT NOT NULL,
  assigned_by TEXT DEFAULT 'optimus-prime',
  task_description TEXT NOT NULL,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'in_progress', 'completed', 'blocked', 'cancelled')),
  priority TEXT DEFAULT 'medium' CHECK (priority IN ('critical', 'high', 'medium', 'low')),
  due_date TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS bot_activity_log (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  bot_id TEXT NOT NULL,
  action TEXT NOT NULL,
  details TEXT,
  status TEXT DEFAULT 'success' CHECK (status IN ('success', 'failure', 'warning')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS daily_metrics (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  date DATE DEFAULT CURRENT_DATE,
  total_revenue NUMERIC(12,2) DEFAULT 0,
  consulting_revenue NUMERIC(12,2) DEFAULT 0,
  dropshipping_revenue NUMERIC(12,2) DEFAULT 0,
  trading_pnl NUMERIC(12,2) DEFAULT 0,
  pipeline_value NUMERIC(12,2) DEFAULT 0,
  deals_in_progress INTEGER DEFAULT 0,
  tasks_completed INTEGER DEFAULT 0,
  tasks_pending INTEGER DEFAULT 0,
  active_bots INTEGER DEFAULT 9,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- -----------------------------------------------
-- RHIANNA RESEARCH - Intelligence Database
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS research_findings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  category TEXT NOT NULL CHECK (category IN ('prospect', 'competitor', 'market_trend', 'technology', 'opportunity', 'threat', 'general')),
  title TEXT NOT NULL,
  finding TEXT NOT NULL,
  source TEXT,
  source_url TEXT,
  confidence TEXT DEFAULT 'medium' CHECK (confidence IN ('high', 'medium', 'low')),
  relevance TEXT DEFAULT 'medium' CHECK (relevance IN ('critical', 'high', 'medium', 'low')),
  relevant_to TEXT[], -- which bots should see this
  expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS competitive_intel (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  competitor_name TEXT NOT NULL,
  industry TEXT,
  website TEXT,
  strengths TEXT,
  weaknesses TEXT,
  pricing_info TEXT,
  recent_moves TEXT,
  threat_level TEXT DEFAULT 'medium' CHECK (threat_level IN ('high', 'medium', 'low')),
  last_updated TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS market_trends (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  trend_name TEXT NOT NULL,
  category TEXT,
  description TEXT NOT NULL,
  impact TEXT CHECK (impact IN ('positive', 'negative', 'neutral')),
  confidence TEXT DEFAULT 'medium',
  source TEXT,
  first_spotted DATE DEFAULT CURRENT_DATE,
  status TEXT DEFAULT 'emerging' CHECK (status IN ('emerging', 'growing', 'peak', 'declining', 'dead')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- -----------------------------------------------
-- AVA ANALYST - Sales Pipeline
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS prospects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  company_name TEXT NOT NULL,
  industry TEXT DEFAULT 'HVAC',
  website TEXT,
  phone TEXT,
  email TEXT,
  decision_makers JSONB DEFAULT '[]',
  pain_points TEXT,
  company_size TEXT,
  estimated_revenue TEXT,
  source TEXT DEFAULT 'rhianna',
  status TEXT DEFAULT 'new' CHECK (status IN ('new', 'researching', 'qualified', 'disqualified', 'assigned')),
  assigned_to TEXT DEFAULT 'ava-analyst',
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS pipeline (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  prospect_id UUID,
  company_name TEXT NOT NULL,
  stage TEXT DEFAULT 'new_lead' CHECK (stage IN ('new_lead', 'researching', 'qualified', 'proposal_creation', 'proposal_sent', 'follow_up', 'negotiation', 'closed_won', 'closed_lost')),
  deal_value NUMERIC(12,2),
  probability INTEGER DEFAULT 10 CHECK (probability >= 0 AND probability <= 100),
  next_action TEXT,
  next_action_date DATE,
  close_date_est DATE,
  loss_reason TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS proposals (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  prospect_id UUID,
  pipeline_id UUID,
  version INTEGER DEFAULT 1,
  title TEXT NOT NULL,
  content TEXT,
  deal_value NUMERIC(12,2),
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'sent', 'viewed', 'accepted', 'rejected', 'revised')),
  sent_date TIMESTAMPTZ,
  response TEXT,
  follow_up_history JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS deals (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  prospect_id UUID,
  pipeline_id UUID,
  company_name TEXT NOT NULL,
  deal_value NUMERIC(12,2) NOT NULL,
  recurring_value NUMERIC(12,2) DEFAULT 0,
  outcome TEXT NOT NULL CHECK (outcome IN ('won', 'lost')),
  win_reason TEXT,
  loss_reason TEXT,
  close_date DATE DEFAULT CURRENT_DATE,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- -----------------------------------------------
-- BENNY BUILDER - Business Opportunities
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS business_opportunities (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  industry TEXT,
  concept TEXT NOT NULL,
  target_customer TEXT,
  market_size TEXT,
  startup_cost_est NUMERIC(12,2),
  monthly_revenue_est NUMERIC(12,2),
  roi_estimate NUMERIC(8,2),
  break_even_months INTEGER,
  confidence INTEGER DEFAULT 5 CHECK (confidence >= 1 AND confidence <= 10),
  go_nogo TEXT CHECK (go_nogo IN ('go', 'no_go', 'needs_research')),
  status TEXT DEFAULT 'researching' CHECK (status IN ('discovered', 'researching', 'analyzed', 'presented', 'approved', 'rejected', 'archived')),
  presentation_date DATE,
  full_analysis TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS financial_models (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  opportunity_id UUID,
  model_name TEXT NOT NULL,
  assumptions JSONB NOT NULL,
  projections JSONB NOT NULL,
  scenarios JSONB DEFAULT '{"best": {}, "expected": {}, "worst": {}}',
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- -----------------------------------------------
-- TAMMY TRADER - Trading Database
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS trades (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  asset TEXT NOT NULL,
  asset_class TEXT CHECK (asset_class IN ('stock', 'crypto', 'forex', 'options', 'futures', 'sports_bet')),
  direction TEXT NOT NULL CHECK (direction IN ('long', 'short', 'over', 'under', 'moneyline', 'spread')),
  entry_price NUMERIC(16,6),
  exit_price NUMERIC(16,6),
  position_size NUMERIC(12,2),
  stop_loss NUMERIC(16,6),
  take_profit NUMERIC(16,6),
  risk_reward_ratio NUMERIC(6,2),
  status TEXT DEFAULT 'open' CHECK (status IN ('planned', 'open', 'closed', 'cancelled')),
  pnl NUMERIC(12,2),
  pnl_pct NUMERIC(8,4),
  strategy TEXT,
  thesis TEXT,
  exit_reason TEXT,
  entry_date TIMESTAMPTZ DEFAULT NOW(),
  exit_date TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS positions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  asset TEXT NOT NULL,
  asset_class TEXT,
  direction TEXT NOT NULL,
  entry_price NUMERIC(16,6) NOT NULL,
  current_price NUMERIC(16,6),
  position_size NUMERIC(12,2),
  unrealized_pnl NUMERIC(12,2),
  unrealized_pnl_pct NUMERIC(8,4),
  stop_loss NUMERIC(16,6),
  take_profit NUMERIC(16,6),
  opened_at TIMESTAMPTZ DEFAULT NOW(),
  last_updated TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS performance_metrics (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  period TEXT NOT NULL CHECK (period IN ('daily', 'weekly', 'monthly')),
  date DATE DEFAULT CURRENT_DATE,
  total_return NUMERIC(12,2) DEFAULT 0,
  total_return_pct NUMERIC(8,4) DEFAULT 0,
  win_rate NUMERIC(6,2),
  profit_factor NUMERIC(6,2),
  max_drawdown NUMERIC(8,4),
  sharpe_ratio NUMERIC(6,2),
  total_trades INTEGER DEFAULT 0,
  winning_trades INTEGER DEFAULT 0,
  losing_trades INTEGER DEFAULT 0,
  avg_win NUMERIC(12,2),
  avg_loss NUMERIC(12,2),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS sports_bets (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  sport TEXT NOT NULL,
  event TEXT NOT NULL,
  bet_type TEXT NOT NULL,
  selection TEXT NOT NULL,
  odds NUMERIC(8,4),
  implied_probability NUMERIC(6,4),
  estimated_edge NUMERIC(6,4),
  stake NUMERIC(12,2),
  potential_payout NUMERIC(12,2),
  result TEXT CHECK (result IN ('pending', 'won', 'lost', 'push', 'cancelled')),
  pnl NUMERIC(12,2),
  reasoning TEXT,
  event_date TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS market_analysis (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  asset TEXT,
  analysis_type TEXT CHECK (analysis_type IN ('technical', 'fundamental', 'sentiment', 'macro', 'sports')),
  timeframe TEXT,
  summary TEXT NOT NULL,
  key_levels JSONB,
  bias TEXT CHECK (bias IN ('bullish', 'bearish', 'neutral')),
  confidence INTEGER CHECK (confidence >= 1 AND confidence <= 10),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- -----------------------------------------------
-- RANDY REALTY - Property Database
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS tax_deed_sales (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  county TEXT NOT NULL,
  state TEXT NOT NULL,
  auction_date DATE,
  registration_deadline DATE,
  deposit_required NUMERIC(12,2),
  format TEXT CHECK (format IN ('online', 'in_person', 'hybrid')),
  platform TEXT,
  platform_url TEXT,
  properties_count INTEGER,
  notes TEXT,
  status TEXT DEFAULT 'upcoming' CHECK (status IN ('upcoming', 'registered', 'active', 'completed', 'missed')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS properties (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  auction_id UUID,
  address TEXT NOT NULL,
  city TEXT,
  county TEXT,
  state TEXT,
  zip TEXT,
  parcel_id TEXT,
  property_type TEXT CHECK (property_type IN ('sfr', 'multi', 'commercial', 'land', 'condo', 'townhouse', 'other')),
  bedrooms INTEGER,
  bathrooms NUMERIC(4,1),
  sqft INTEGER,
  lot_size TEXT,
  year_built INTEGER,
  min_bid NUMERIC(12,2),
  est_market_value NUMERIC(12,2),
  equity_spread NUMERIC(12,2),
  equity_spread_pct NUMERIC(6,2),
  repair_estimate NUMERIC(12,2),
  flip_profit_est NUMERIC(12,2),
  rental_yield_est NUMERIC(6,2),
  confidence INTEGER CHECK (confidence >= 1 AND confidence <= 10),
  recommendation TEXT CHECK (recommendation IN ('strong_buy', 'buy', 'watch', 'pass')),
  risks TEXT,
  status TEXT DEFAULT 'researching' CHECK (status IN ('researching', 'recommended', 'bidding', 'won', 'lost', 'passed')),
  google_maps_url TEXT,
  photos JSONB DEFAULT '[]',
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS property_comps (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  property_id UUID,
  comp_address TEXT NOT NULL,
  sale_price NUMERIC(12,2),
  sale_date DATE,
  sqft INTEGER,
  price_per_sqft NUMERIC(8,2),
  condition TEXT,
  distance_miles NUMERIC(6,2),
  source TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS portfolio (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  property_id UUID,
  address TEXT NOT NULL,
  acquisition_price NUMERIC(12,2) NOT NULL,
  acquisition_date DATE,
  total_invested NUMERIC(12,2),
  current_value NUMERIC(12,2),
  strategy TEXT CHECK (strategy IN ('flip', 'rent', 'hold', 'wholesale')),
  status TEXT DEFAULT 'owned' CHECK (status IN ('owned', 'renovating', 'listed', 'rented', 'sold')),
  monthly_rent NUMERIC(12,2),
  monthly_expenses NUMERIC(12,2),
  sale_price NUMERIC(12,2),
  sale_date DATE,
  total_profit NUMERIC(12,2),
  roi_pct NUMERIC(8,2),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- -----------------------------------------------
-- DEONDRE DROPSHIPPING - E-Commerce Database
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT,
  source_url TEXT,
  supplier TEXT,
  supplier_id UUID,
  product_cost NUMERIC(10,2),
  shipping_cost NUMERIC(10,2),
  platform_fees NUMERIC(10,2),
  est_ad_cost_per_unit NUMERIC(10,2),
  total_cost NUMERIC(10,2),
  selling_price NUMERIC(10,2),
  margin_pct NUMERIC(6,2),
  profit_per_unit NUMERIC(10,2),
  demand_score INTEGER CHECK (demand_score >= 1 AND demand_score <= 10),
  competition_level TEXT CHECK (competition_level IN ('low', 'medium', 'high', 'saturated')),
  wow_factor BOOLEAN DEFAULT FALSE,
  problem_solver BOOLEAN DEFAULT FALSE,
  impulse_buy BOOLEAN DEFAULT FALSE,
  lightweight BOOLEAN DEFAULT FALSE,
  legal_clear BOOLEAN DEFAULT FALSE,
  proven_demand BOOLEAN DEFAULT FALSE,
  not_local BOOLEAN DEFAULT FALSE,
  winner_criteria_passed INTEGER DEFAULT 0,
  demand_proof TEXT,
  tiktok_views TEXT,
  google_trend TEXT,
  status TEXT DEFAULT 'discovered' CHECK (status IN ('discovered', 'researching', 'validated', 'testing', 'scaling', 'killed', 'paused')),
  kill_reason TEXT,
  shopify_product_id TEXT,
  confidence INTEGER CHECK (confidence >= 1 AND confidence <= 10),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS suppliers (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  platform TEXT CHECK (platform IN ('aliexpress', 'cj_dropshipping', 'spocket', 'other')),
  website TEXT,
  rating NUMERIC(3,1),
  avg_shipping_days INTEGER,
  shipping_from TEXT,
  defect_rate NUMERIC(5,2),
  response_time TEXT,
  min_order INTEGER DEFAULT 1,
  payment_terms TEXT,
  contact_info TEXT,
  reliability TEXT DEFAULT 'untested' CHECK (reliability IN ('excellent', 'good', 'average', 'poor', 'untested')),
  total_orders INTEGER DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS ecom_orders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  product_id UUID,
  shopify_order_id TEXT,
  order_date TIMESTAMPTZ DEFAULT NOW(),
  customer_name TEXT,
  customer_email TEXT,
  revenue NUMERIC(10,2),
  cogs NUMERIC(10,2),
  shipping_cost NUMERIC(10,2),
  platform_fees NUMERIC(10,2),
  ad_cost NUMERIC(10,2),
  profit NUMERIC(10,2),
  fulfillment_status TEXT DEFAULT 'unfulfilled' CHECK (fulfillment_status IN ('unfulfilled', 'processing', 'shipped', 'delivered', 'returned', 'refunded')),
  tracking_number TEXT,
  supplier_order_id TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS daily_ecom_metrics (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  date DATE DEFAULT CURRENT_DATE UNIQUE,
  revenue NUMERIC(12,2) DEFAULT 0,
  orders INTEGER DEFAULT 0,
  avg_order_value NUMERIC(10,2) DEFAULT 0,
  total_cogs NUMERIC(12,2) DEFAULT 0,
  total_ad_spend NUMERIC(12,2) DEFAULT 0,
  total_fees NUMERIC(12,2) DEFAULT 0,
  gross_profit NUMERIC(12,2) DEFAULT 0,
  net_profit NUMERIC(12,2) DEFAULT 0,
  conversion_rate NUMERIC(6,4),
  return_rate NUMERIC(6,4),
  roas NUMERIC(8,2),
  products_testing INTEGER DEFAULT 0,
  products_scaling INTEGER DEFAULT 0,
  products_killed INTEGER DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS competitor_stores (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  store_name TEXT NOT NULL,
  store_url TEXT NOT NULL,
  platform TEXT DEFAULT 'shopify',
  niche TEXT,
  estimated_revenue TEXT,
  product_count INTEGER,
  top_products JSONB DEFAULT '[]',
  pricing_strategy TEXT,
  strengths TEXT,
  weaknesses TEXT,
  last_scraped TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- -----------------------------------------------
-- CARTER CONTENT - Content Operations
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS content_calendar (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  platform TEXT NOT NULL CHECK (platform IN ('instagram', 'tiktok', 'facebook', 'linkedin', 'x_twitter', 'threads', 'youtube')),
  format TEXT CHECK (format IN ('reel', 'carousel', 'story', 'feed_post', 'video', 'text_post', 'thread', 'short', 'live')),
  goal TEXT CHECK (goal IN ('engagement', 'traffic', 'sales', 'brand_awareness', 'lead_gen')),
  hook TEXT,
  caption TEXT,
  image_prompt TEXT,
  video_script TEXT,
  image_url TEXT,
  video_url TEXT,
  hashtags TEXT,
  scheduled_time TIMESTAMPTZ,
  posted_time TIMESTAMPTZ,
  posted_url TEXT,
  status TEXT DEFAULT 'draft' CHECK (status IN ('idea', 'draft', 'ready', 'posted', 'failed')),
  related_product_id UUID,
  campaign TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS content_performance (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  content_id UUID,
  platform TEXT NOT NULL,
  post_url TEXT,
  views INTEGER DEFAULT 0,
  likes INTEGER DEFAULT 0,
  comments INTEGER DEFAULT 0,
  shares INTEGER DEFAULT 0,
  saves INTEGER DEFAULT 0,
  clicks INTEGER DEFAULT 0,
  reach INTEGER DEFAULT 0,
  impressions INTEGER DEFAULT 0,
  engagement_rate NUMERIC(8,4),
  avg_watch_time NUMERIC(8,2),
  follower_change INTEGER DEFAULT 0,
  measured_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS content_assets (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  type TEXT CHECK (type IN ('image', 'video', 'gif', 'audio', 'template')),
  prompt TEXT,
  model_used TEXT,
  url TEXT,
  thumbnail_url TEXT,
  aspect_ratio TEXT,
  platform_optimized_for TEXT,
  tags TEXT[],
  used_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS trending_content (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  platform TEXT NOT NULL,
  trend_type TEXT CHECK (trend_type IN ('sound', 'format', 'topic', 'hashtag', 'challenge', 'meme')),
  description TEXT NOT NULL,
  example_url TEXT,
  engagement_level TEXT CHECK (engagement_level IN ('viral', 'trending', 'rising', 'niche')),
  our_angle TEXT,
  status TEXT DEFAULT 'spotted' CHECK (status IN ('spotted', 'planned', 'created', 'posted', 'expired')),
  peak_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS social_accounts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  platform TEXT NOT NULL,
  account_name TEXT NOT NULL,
  account_id TEXT,
  account_type TEXT CHECK (account_type IN ('kaldr_tech', 'dropshipping', 'personal', 'client')),
  follower_count INTEGER DEFAULT 0,
  following_count INTEGER DEFAULT 0,
  total_posts INTEGER DEFAULT 0,
  avg_engagement_rate NUMERIC(8,4),
  last_post_date TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- -----------------------------------------------
-- CLEAH CODING - Development Tracking
-- -----------------------------------------------

CREATE TABLE IF NOT EXISTS dev_tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  repo TEXT,
  priority TEXT DEFAULT 'medium' CHECK (priority IN ('critical', 'high', 'medium', 'low')),
  status TEXT DEFAULT 'backlog' CHECK (status IN ('backlog', 'todo', 'in_progress', 'review', 'done', 'blocked')),
  assigned_to TEXT DEFAULT 'cleah-coding',
  estimated_hours NUMERIC(6,1),
  actual_hours NUMERIC(6,1),
  pr_url TEXT,
  branch TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS bug_reports (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  repo TEXT,
  severity TEXT DEFAULT 'medium' CHECK (severity IN ('critical', 'high', 'medium', 'low')),
  status TEXT DEFAULT 'open' CHECK (status IN ('open', 'investigating', 'fix_in_progress', 'fix_deployed', 'closed', 'wont_fix')),
  steps_to_reproduce TEXT,
  root_cause TEXT,
  fix_description TEXT,
  reported_by TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  resolved_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS deployments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  service TEXT NOT NULL,
  platform TEXT DEFAULT 'railway' CHECK (platform IN ('railway', 'vercel', 'supabase', 'github', 'other')),
  version TEXT,
  status TEXT CHECK (status IN ('deploying', 'success', 'failed', 'rolled_back')),
  changes TEXT,
  deployed_by TEXT DEFAULT 'cleah-coding',
  deploy_url TEXT,
  notes TEXT,
  deployed_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS tech_decisions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  context TEXT NOT NULL,
  options_considered JSONB DEFAULT '[]',
  decision TEXT NOT NULL,
  consequences TEXT,
  status TEXT DEFAULT 'accepted' CHECK (status IN ('proposed', 'accepted', 'deprecated', 'superseded')),
  decided_by TEXT DEFAULT 'cleah-coding',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- INDEXES: single DO block, each index guarded individually
DO $$
BEGIN
  BEGIN CREATE INDEX IF NOT EXISTS idx_bot_tasks_assigned ON bot_tasks(assigned_to, status); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_bot_tasks_status ON bot_tasks(status); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_bot_activity_bot ON bot_activity_log(bot_id, created_at DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_daily_metrics_date ON daily_metrics(date DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_research_category ON research_findings(category, created_at DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_research_relevance ON research_findings(relevance); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_prospects_status ON prospects(status); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_pipeline_stage ON pipeline(stage); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_proposals_status ON proposals(status); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_trades_status ON trades(status, entry_date DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_trades_asset ON trades(asset, asset_class); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_positions_asset ON positions(asset); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_performance_period ON performance_metrics(period, date DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_properties_status ON properties(status, recommendation); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_properties_state ON properties(state, county); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_tax_deeds_date ON tax_deed_sales(auction_date); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_products_status ON products(status); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_products_margin ON products(margin_pct DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_ecom_orders_date ON ecom_orders(order_date DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_ecom_metrics_date ON daily_ecom_metrics(date DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_content_calendar_schedule ON content_calendar(scheduled_time, status); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_content_calendar_platform ON content_calendar(platform, status); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_content_performance_platform ON content_performance(platform, measured_at DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_trending_content_status ON trending_content(status, platform); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_dev_tasks_status ON dev_tasks(status, priority); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_bug_reports_severity ON bug_reports(severity, status); EXCEPTION WHEN OTHERS THEN NULL; END;
  BEGIN CREATE INDEX IF NOT EXISTS idx_deployments_service ON deployments(service, deployed_at DESC); EXCEPTION WHEN OTHERS THEN NULL; END;
END;
$$;

-- RLS: idempotent, safe to re-run
ALTER TABLE bot_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE bot_activity_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_metrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE research_findings ENABLE ROW LEVEL SECURITY;
ALTER TABLE competitive_intel ENABLE ROW LEVEL SECURITY;
ALTER TABLE market_trends ENABLE ROW LEVEL SECURITY;
ALTER TABLE prospects ENABLE ROW LEVEL SECURITY;
ALTER TABLE pipeline ENABLE ROW LEVEL SECURITY;
ALTER TABLE proposals ENABLE ROW LEVEL SECURITY;
ALTER TABLE deals ENABLE ROW LEVEL SECURITY;
ALTER TABLE business_opportunities ENABLE ROW LEVEL SECURITY;
ALTER TABLE financial_models ENABLE ROW LEVEL SECURITY;
ALTER TABLE trades ENABLE ROW LEVEL SECURITY;
ALTER TABLE positions ENABLE ROW LEVEL SECURITY;
ALTER TABLE performance_metrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE sports_bets ENABLE ROW LEVEL SECURITY;
ALTER TABLE market_analysis ENABLE ROW LEVEL SECURITY;
ALTER TABLE tax_deed_sales ENABLE ROW LEVEL SECURITY;
ALTER TABLE properties ENABLE ROW LEVEL SECURITY;
ALTER TABLE property_comps ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE ecom_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_ecom_metrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE competitor_stores ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_calendar ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_performance ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_assets ENABLE ROW LEVEL SECURITY;
ALTER TABLE trending_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE social_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE dev_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE bug_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE deployments ENABLE ROW LEVEL SECURITY;
ALTER TABLE tech_decisions ENABLE ROW LEVEL SECURITY;
