---
name: firecrawl-work
description: Use Firecrawl to search the web, scrape a URL, map or crawl a site, interact with JavaScript pages, or extract structured data. Trigger when the user explicitly asks for Firecrawl or needs a Firecrawl-backed research, scraping, crawling, mapping, or extraction workflow.
---

# Firecrawl Work

Use the Firecrawl capability available in the current runtime. Verify that either a Firecrawl MCP connection, CLI, SDK, or API key is configured before executing.

## Workflow

1. Choose the smallest operation that satisfies the request: `search`, `scrape`, `map`, `crawl`, batch scrape, or interaction.
2. Confirm the allowed domains and scope before a broad crawl or interactive action.
3. Prefer Markdown for readable content and JSON schema extraction for structured fields.
4. Preserve canonical source URLs in results.
5. Poll asynchronous crawl or batch jobs until completion; report partial failures separately.
6. Never invent scraped content, job status, or citations when Firecrawl is unavailable.

## Safety

- Respect access controls, robots policies, site terms, copyright, and personal-data boundaries.
- Do not submit forms, authenticate, or perform write-like browser actions unless the user explicitly requested them.
- Keep API keys in environment variables such as `FIRECRAWL_API_KEY`; never write them into plugin files or logs.

## Source

Adapted from `firecrawl/firecrawl` revision `af55c2a050a69c03199c9fff4d49bb4ea5acbc26` under AGPL-3.0.
