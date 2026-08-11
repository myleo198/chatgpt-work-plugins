---
name: openwiki-work
description: Build, initialize, update, configure, or query an OpenWiki knowledge base for a code repository or personal knowledge sources. Use for OpenWiki setup, source connectors, wiki generation, documentation refreshes, and OpenWiki troubleshooting.
---

# OpenWiki Work

Use the upstream OpenWiki CLI and repository conventions. Treat generated wiki pages as derived artifacts and preserve source configuration.

## Workflow

1. Inspect the target repository and existing `openwiki/` configuration before initializing anything.
2. Verify the installed OpenWiki version and available commands with its own help output.
3. Select `code` mode for repository documentation or `personal` mode for connected personal sources.
4. Keep secrets in environment variables or `~/.openwiki/.env`; never commit raw credentials.
5. Run the smallest generation or update command needed for the request.
6. Review generated pages for missing sources, unsupported claims, broken links, and Mermaid syntax errors.
7. Report which sources were ingested and which were unavailable.

## Windows launcher troubleshooting

When `openwiki.ps1`, `npm.ps1`, or another local PowerShell launcher fails with
`running scripts is disabled`, use the dedicated `powershell-openwiki-fix`
skill before changing any OpenWiki configuration. It diagnoses the effective
Execution Policy, respects organization-managed policy, and only proposes the
least-privileged `CurrentUser` fix when appropriate.

## Connector Rules

- Store only environment-variable names in committed connector configuration.
- Confirm external writes or OAuth grants before enabling a connector.
- For MCP sources, inspect the advertised tools and restrict them to the minimum required access.

## Source

Adapted from `langchain-ai/openwiki` revision `50e897dbff260203afbdaa2d385de99957877e49` under MIT.
