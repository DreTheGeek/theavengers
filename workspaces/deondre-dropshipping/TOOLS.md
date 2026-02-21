# Available Tools & How to Use Them

## MODEL SWITCHING (Via OpenRouter)
You run on DeepSeek Chat by default. LaSean can switch you at any time.

### Available Models (say "switch to [name]"):
- **deepseek-chat** (DEFAULT) - Product research, supplier lookups, daily operations
- **claude-sonnet-4** - Best for writing product descriptions, ad copy, brand voice
- **deepseek-reasoner** - Complex margin analysis, multi-variable pricing models
- **gemini-2.5-pro** - Analyzing large competitor catalogs, bulk product data (1M context)
- **gpt-4o** - Structured product reports and competitor analysis
- **llama-4-maverick** - Budget bulk research tasks

### Auto-switch recommendations:
- Quick product lookup or price check -> Stay on DeepSeek Chat
- Writing high-converting product descriptions -> Suggest Claude Sonnet 4
- Analyzing competitor store with 500+ products -> Suggest Gemini 2.5 Pro
- Complex profit margin modeling with ad spend -> Suggest DeepSeek Reasoner

## Supabase (Central Database)
Full read/write access to ALL tables.

### Key Tables:
- `products` — Master product catalog with full research data
  - Columns: id, name, category, source_url, supplier, product_cost, shipping_cost, selling_price, margin_pct, status, confidence, demand_score, competition_level, created_at
- `suppliers` — Vetted supplier database
  - Columns: id, name, platform, rating, avg_shipping_days, defect_rate, contact, notes
- `orders` — Order tracking and fulfillment
  - Columns: id, product_id, order_date, customer, revenue, cogs, profit, fulfillment_status, tracking_number
- `product_pipeline` — Products by stage (Discovered → Researching → Validated → Testing → Scaling → Killed)
- `daily_ecom_metrics` — Daily store KPIs (revenue, orders, AOV, conversion_rate, ad_spend, profit)
- `competitor_stores` — Competitor tracking with product counts, pricing trends

### Usage Pattern:
1. Log EVERY product you discover (even rejects — document why)
2. Update product status in real-time as they move through the pipeline
3. Track daily metrics religiously — this is your P&L
4. Build supplier reputation data over time

## Shopify (Store Management)
Manage the store via Shopify Admin API (through fetch tool).

### Key Operations:
- **List Products**: `GET https://{store}.myshopify.com/admin/api/2024-01/products.json`
- **Create Product**: `POST /admin/api/2024-01/products.json`
- **Update Product**: `PUT /admin/api/2024-01/products/{id}.json`
- **Orders**: `GET /admin/api/2024-01/orders.json`
- **Inventory**: `GET /admin/api/2024-01/inventory_levels.json`

### Auth: Use `X-Shopify-Access-Token: ${SHOPIFY_ADMIN_API_TOKEN}` header

## Brave Search + Google Search (Product Research)
Use BOTH search engines for comprehensive research:

### Brave Search:
- Quick product validation and news
- Competitor discovery
- Supplier alternatives

### Google Search (Serper):
- Google Shopping results — see who's advertising what products
- Google Trends data — validate rising demand
- Competitor ad research
- More comprehensive results than Brave for e-commerce queries

### Research Queries:
- "[Product name] dropshipping" — competition check
- "[Product name] TikTok viral" — demand validation
- "[Product category] trending products 2026" — discovery
- "[Competitor store] shopify" — find competitor stores
- "site:aliexpress.com [product name]" — find suppliers
- "[Product name] reviews complaints" — quality check

## Firecrawl (Web Scraping)
Scrape full web pages into clean text. Critical for:

### Competitor Store Scraping:
- Scrape `https://competitor-store.com/products.json` — get ALL their products, prices, variants
- Scrape individual product pages for descriptions, reviews, images
- Scrape competitor collections to understand their strategy

### Supplier Research:
- Scrape AliExpress product pages for full details, reviews, shipping info
- Scrape CJ Dropshipping listings
- Scrape supplier review sites

### Ad Research:
- Scrape Facebook Ad Library for competitor ads
- Scrape TikTok Ad Library for winning creatives

## Fetch (API Calls)
Direct HTTP calls to external APIs:

### CJ Dropshipping API:
- **Search Products**: `GET https://developers.cjdropshipping.com/api2.0/v1/product/list`
- **Product Details**: `GET /api2.0/v1/product/query?pid={id}`
- **Shipping Cost**: `GET /api2.0/v1/logistic/freightCalculate`
- Auth: `CJ-Access-Token: ${CJ_API_KEY}` header

### RapidAPI (AliExpress + Amazon + TikTok Trends):
- All use `X-RapidAPI-Key: ${RAPIDAPI_KEY}` header
- **AliExpress**: Search products, get details, reviews, shipping
- **Amazon**: BSR data, pricing, reviews (demand validation)
- **TikTok Data**: Trending hashtags, video engagement (find viral products)
- **Google Trends**: Rising searches, related queries (validate demand)

### Competitor Shopify Scraping (FREE — no API key):
```
GET https://competitor-store.com/products.json?limit=250
```
Returns: titles, prices, variants, images, inventory — everything you need.

## Sequential Thinking (Analysis)
Use for complex product decisions:
1. Calculate true landed cost with all variables
2. Model best/expected/worst case scenarios
3. Evaluate product-market fit signals
4. Assess competition intensity and differentiation options
5. Build scaling roadmap for validated winners

## Memory (Product Intelligence)
Store persistent insights:
- Which product categories perform best
- Reliable vs. unreliable suppliers
- Seasonal trends and timing patterns
- Ad creative patterns that convert
- Pricing strategies that maximize margin
