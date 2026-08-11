---
name: aki-mcp-work
description: Install, configure, run, audit, or troubleshoot Aki MCP Server for remote ChatGPT access to local files, search, and an allowlisted shell through OAuth 2.1 and Tailscale Funnel. Use whenever the user names aki-mcp-sv or requests this specific secure remote-local MCP setup.
---

# Aki MCP Work

Operate the bundled Aki MCP Server source. It exposes a Streamable HTTP `/mcp` endpoint through an OAuth gatekeeper and Tailscale Funnel while keeping its internal MCP hub on loopback.

## Workflow

For a complete Windows deployment procedure, read [references/https-deployment-windows.md](references/https-deployment-windows.md) before changing configuration or starting Funnel.

1. Verify Node.js, Git for Windows or Unix tools where required, and Tailscale availability.
2. Install dependencies in `server/` with the lockfile-preserving package-manager command.
3. Start the server from `server/`; record the printed HTTPS MCP URL but never copy secrets into chat or logs.
4. Open the loopback control panel and restrict allowed roots to the smallest necessary directories.
5. Review the shell allowlist; keep commands read-only unless the user explicitly approves an expansion.
6. In ChatGPT Developer Mode, create an MCP connection using the HTTPS URL ending in `/mcp` and complete OAuth in the browser.
7. Test filesystem/search tools on a disposable directory before enabling access to real projects.
8. Verify that the MCP hub admin API and control panel remain inaccessible from the public endpoint.

## Security Rules

- Never expose the internal hub or panel directly.
- Never print or commit OAuth client secrets, passphrases, refresh tokens, or generated client records.
- Treat adding a writable root or shell command as a permission expansion requiring explicit user approval.
- Preserve the upstream whitelist-first security model.

## Source

Bundled from `lacvietanh/aki-mcp-sv` revision `8686d9158ea30751c9d4995bc45b02fd874b07b3` under MIT.
