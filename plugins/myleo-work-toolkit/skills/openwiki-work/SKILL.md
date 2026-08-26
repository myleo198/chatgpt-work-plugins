---
name: openwiki-work
description: Install, configure, initialize, update, resume, visualize, or troubleshoot OpenWiki 0.4+ for a code repository or personal knowledge sources. Use for OpenWiki setup, Codex integration, source connectors, generated-wiki lifecycle, documentation refreshes, claims/provenance, and OpenWiki troubleshooting.
---

# OpenWiki Work

Use the upstream OpenWiki CLI and repository conventions. This toolkit provides
operating guidance, not the OpenWiki executable, credentials, or MCP server.
OpenWiki `0.4.0` requires Node.js 22 or newer.

## Codex integration

From the target Git repository, install the official project-scoped integration:

```sh
openwiki integrations install codex --project .
```

Upstream owns the managed MCP block in `.codex/config.toml` and its copied skill
under `.agents/skills/openwiki`. Inspect with `openwiki integrations list` and
do not overwrite a modified installation without the user's approval. Use the
`openwiki-lifecycle` skill only when the official MCP lifecycle tools are present
in the current session.

## Workflow

1. Inspect the target Git worktree, `openwiki/`, `.openwikiignore`, and
   `openwiki/INSTRUCTIONS.md` before initializing.
2. Use code mode for repository docs and personal mode for connected sources.
   Keep credentials in environment variables or `~/.openwiki/.env`; never
   commit raw credentials. `OPENWIKI_CONFIG_DIR` can relocate private state.
3. Use the smallest intended command:

   ```sh
   openwiki --init --print
   openwiki --update --print
   openwiki personal --init --print
   openwiki personal --update --print
   ```

4. Repeat the same command to resume an interrupted preserved code-wiki run.
   Never manually edit OpenWiki-managed `.run.json`, `.claims`, indexes, logs,
   provenance, or `.last-update.json`.
5. Review generated content for supported claims, valid links, diagrams, and
   output language. Current code wikis use OKF v0.2 and grounded Claims.
6. Use `openwiki visualize` for the local graph reader or `--export` for static
   output.

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
  connector with explicit read-only `allowedTools`/operations.

## Source

Adapted from `langchain-ai/openwiki` `0.4.0`, revision `27d835cc617019795065ea0b30d9eb23e62b9789`, under MIT.
