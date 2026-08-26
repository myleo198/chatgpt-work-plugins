---
name: openwiki-work
description: Install, configure, initialize, update, resume, visualize, or troubleshoot OpenWiki 0.4+ for a code repository or personal knowledge sources. Use for OpenWiki setup, Codex integration, source connectors, generated-wiki lifecycle, documentation refreshes, claims/provenance, and OpenWiki troubleshooting.
---

# OpenWiki Work

Use the upstream OpenWiki CLI and repository conventions. This plugin provides
the operating guidance; it does not bundle the OpenWiki executable, model
credentials, or an MCP server. OpenWiki `0.4.0` requires Node.js 22 or newer.
Treat generated wiki pages as derived artifacts and preserve source
configuration.

## Install and integrate with Codex

1. Check the installed CLI first: `openwiki --version` and `openwiki --help`.
2. If it is missing or is older than the required upstream release, install or
   upgrade it with the user's normal Node package manager. Do not put a global
   package install, provider credentials, or generated output into this plugin.
3. From the target Git repository, install the official project-scoped Codex
   integration:

   ```sh
   openwiki integrations install codex --project .
   ```

   Upstream owns the managed MCP block in `.codex/config.toml` and its copied
   skill under `.agents/skills/openwiki`. Do not edit those generated artifacts
   by hand. Inspect with `openwiki integrations list`; if upstream reports a
   modified installation, preserve it and ask before using `--force`.
4. The official Codex integration exposes a resumable page-job lifecycle. Use
   the bundled `openwiki-lifecycle` skill only when those MCP tools are actually
   available in the session. Otherwise use the CLI commands below.

## Workflow

1. Inspect the target Git worktree, existing `openwiki/` content,
   `.openwikiignore`, and `openwiki/INSTRUCTIONS.md` before initializing.
2. Select code mode for repository documentation or personal mode for connected
   knowledge. Code mode writes `openwiki/` in the repository; personal mode
   writes to `~/.openwiki/wiki` by default.
3. Keep secrets in environment variables or `~/.openwiki/.env`; never commit
   raw credentials. `OPENWIKI_CONFIG_DIR` may relocate private state to another
   writable directory but never moves existing state automatically.
4. Use the smallest intended operation:

   ```sh
   openwiki --init --print
   openwiki --update --print
   openwiki personal --init --print
   openwiki personal --update --print
   ```

   An interrupted code-wiki run can resume by repeating the same command in the
   preserved worktree. Do not delete `openwiki/.run.json`, `.claims/`, indexes,
   logs, generated provenance, or `.last-update.json` to force progress.
5. Review generated pages for unsupported claims, broken links, stale diagrams,
   and the intended output language. Current code wikis use OKF v0.2 metadata
   and repository-grounded Claims; preserve user-authored content and let
   OpenWiki manage its own provenance and evidence sidecars.
6. Use `openwiki visualize` for a local loopback graph reader, or
   `openwiki visualize openwiki --export <directory>` for a static export.
7. Report which sources were ingested, which were unavailable, and whether a
   generation completed, resumed, or safely no-op'd.

## Windows launcher troubleshooting

When `openwiki.ps1`, `npm.ps1`, or another local PowerShell launcher fails with
`running scripts is disabled`, use the dedicated `powershell-openwiki-fix`
skill before changing any OpenWiki configuration. It diagnoses the effective
Execution Policy, respects organization-managed policy, and only proposes the
least-privileged `CurrentUser` fix when appropriate.

## Connector Rules

- Store only environment-variable names in committed connector configuration.
- Confirm external writes or OAuth grants before enabling a connector.
- For arbitrary HTTP or stdio MCP sources, prefer the built-in `custom-mcp`
  connector rather than implementing a new connector. Require explicit
  `allowedTools` and/or read-only operations; never grant mutating tools by
  inference.
- Use `openwiki auth <provider>` only when the user approves the OAuth or
  credential flow. Do not display the resulting local `.env` file.

## Source

Adapted from `langchain-ai/openwiki` `0.4.0`, revision `27d835cc617019795065ea0b30d9eb23e62b9789`, under MIT.
