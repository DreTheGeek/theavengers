# Available Tools & How to Use Them

## Replicate (AI Image & Video Generation)
Your primary creative tool. Access hundreds of AI models.

### Image Generation:
- **Flux Pro** — Highest quality images, photorealistic, great for hero content
- **Flux Schnell** — Fast generation, good for bulk content and testing concepts
- **SDXL** — Open-source Stable Diffusion, great for stylized content

### Video Generation:
- **Kling Video 3.0** — Best overall video generation, supports text-to-video and image-to-video, native audio
- **Hailuo 2.3** — Excellent character motion, 6-10 second clips at 1080p
- **Minimax** — Video + speech synthesis with voice cloning

### Usage Tips:
- Generate 3-5 image variations, pick the best — never settle for the first output
- For product marketing: use image-to-video (upload product image → animated showcase)
- For social hooks: generate eye-catching 3-5 second clips as video openers
- Always specify aspect ratios for each platform: 9:16 (Reels/TikTok), 1:1 (Feed), 16:9 (YouTube)

## OpenAI (DALL-E Image Generation)
Backup image generation with excellent text rendering.
- GPT Image 1 Mini: $0.005/image — use for bulk content
- GPT Image 1: $0.011-$0.25/image — use for high-quality hero images
- Best for: images with text overlays, infographics, quote graphics

## Social Media APIs (via Fetch)
Post content directly to each platform:

### Meta Graph API (Facebook + Instagram + Threads):
- **Facebook Page Post**: `POST https://graph.facebook.com/v22.0/{page-id}/feed`
  - Body: `message`, `link`, or upload photo/video
  - Auth: `access_token=${META_PAGE_ACCESS_TOKEN}`
- **Instagram Post**: Two-step process:
  1. Create media container: `POST https://graph.facebook.com/v22.0/{ig-id}/media` with `image_url` + `caption`
  2. Publish: `POST https://graph.facebook.com/v22.0/{ig-id}/media_publish` with `creation_id`
  - Supports: Single image, carousel, Reels, Stories
- **Threads Post**: `POST https://graph.threads.net/v1.0/{user-id}/threads`
  - Body: `text`, optional `image_url` or `video_url`
- Auth for all Meta: `access_token` parameter or `Authorization: Bearer` header

### X/Twitter API v2:
- **Post Tweet**: `POST https://api.twitter.com/2/tweets`
  - Body: `{ "text": "your tweet" }`
  - For images: Upload media first via `POST https://upload.twitter.com/1.1/media/upload.json`
  - Auth: OAuth 1.0a with `X_API_KEY`, `X_API_SECRET`, `X_ACCESS_TOKEN`, `X_ACCESS_TOKEN_SECRET`
- Free tier: 500 tweets/month (write-only — cannot read)

### LinkedIn Posts API:
- **Create Post**: `POST https://api.linkedin.com/rest/posts`
  - Body: `author`, `commentary`, `visibility`, `distribution`, optional `content` (image/video/article)
  - Auth: `Authorization: Bearer ${LINKEDIN_ACCESS_TOKEN}`
  - Header: `LinkedIn-Version: 202501`
- Supports: Text, images, videos, documents, articles

### TikTok Content Posting API:
- **Upload Video**: Multi-step process:
  1. Init upload: `POST https://open.tiktokapis.com/v2/post/publish/inbox/video/init/`
  2. Upload chunks to provided URL
  3. Publish
  - Auth: `Authorization: Bearer ${TIKTOK_ACCESS_TOKEN}`
- NOTE: Unaudited apps = PRIVATE-ONLY posts. Must pass TikTok audit for public posting.

## Brave Search + Google Search (Trend Research)
Research what's trending across platforms:

### Trend Discovery Queries:
- "trending tiktok sounds this week 2026"
- "viral instagram reels formats [month] 2026"
- "linkedin content trends B2B 2026"
- "[industry] viral content examples"
- "trending hashtags [platform] today"
- "[competitor brand] social media content"

### Content Research Queries:
- "[topic] hook ideas" — find proven hooks to adapt
- "[industry] memes trending" — find shareable formats
- "best performing [platform] posts [month] 2026"

## Firecrawl (Competitor Content Scraping)
Scrape competitor content for analysis:
- Competitor social media profiles (public posts, engagement rates)
- Content inspiration sites and trend aggregators
- Viral content databases and roundups
- Industry blog posts and articles for content repurposing

## Supabase (Content Operations Database)
Full read/write access to ALL tables.

### Key Tables:
- `content_calendar` — Scheduled content with platform, status, posting time
  - Columns: id, platform, format, caption, image_prompt, video_script, hashtags, scheduled_time, status, posted_url, created_at
- `content_performance` — Post-publish analytics
  - Columns: id, content_id, platform, views, likes, comments, shares, saves, engagement_rate, measured_at
- `content_assets` — Generated images and videos library
  - Columns: id, type, prompt, url, platform_optimized_for, used_in, created_at
- `trending_content` — Tracked trends and viral formats
  - Columns: id, platform, trend_type, description, example_url, peak_date, our_angle, status
- `brand_pages` — All managed social media accounts and credentials
  - Columns: id, platform, page_name, account_id, follower_count, last_post_date

### Usage Pattern:
1. Plan content in content_calendar — always stay 3-7 days ahead
2. Log every post with its performance data
3. Track trends as you discover them
4. Build asset library so you can reuse and repurpose

## Sequential Thinking (Content Strategy)
Use for complex content planning:
1. Analyze what content patterns are working (from content_performance data)
2. Identify gaps in content mix (platform, format, topic coverage)
3. Plan content series that build on each other
4. Design A/B tests for hooks, formats, and posting times
5. Model content → engagement → conversion funnels

## Memory (Content Intelligence)
Store persistent insights:
- Which hooks and formats work best per platform
- Optimal posting times (refined over time with real data)
- Trending sounds/formats lifecycle (rising, peak, declining)
- Brand voice guidelines and approved messaging
- Competitor content strategies and their effectiveness
