# Public HTTPS Deployment on Windows

Use Tailscale Funnel when ChatGPT must reach files on the Windows computer that runs Aki MCP. The computer and the foreground server process must remain running.

## Prerequisites

Install Node.js LTS, Git for Windows, and Tailscale. In PowerShell, verify:

```powershell
node --version
npm --version
git --version
tailscale version
tailscale up
tailscale status
```

Tailscale Funnel requires MagicDNS and HTTPS enabled for the tailnet.

## Install

```powershell
git clone https://github.com/myleo198/chatgpt-work-plugins.git
cd .\chatgpt-work-plugins\plugins\aki-mcp-work\server
npm ci
```

## Restrict accessible data

Never expose a drive root or the full user profile. Set one or more dedicated directories; separate multiple roots with commas:

```powershell
$env:MCP_DATA_DIR="D:\MCP-Shared"
```

Before production use, review `mcp-hub.config.json`. Remove `${HOME}/.claude` and any other root that is not explicitly required because these directories can contain sensitive configuration.

Keep the shell allowlist read-only. Do not add deletion, arbitrary PowerShell, package installation, or remote-download commands unless the user explicitly approves the permission expansion.

## Start

```powershell
npm start
```

The launcher starts the internal hub on port `19999`, the OAuth gatekeeper on `9999`, the loopback-only panel on `127.0.0.1:9998`, and Tailscale Funnel. Record the printed URL ending in `/mcp`.

Never copy the OAuth client secret, passphrase, refresh token, or generated files from `.aki` into chat, logs, source control, or screenshots.

## Verify

From another network, request the public URL:

```powershell
curl.exe -i https://HOSTNAME.TAILNET.ts.net/mcp
```

An unauthenticated request should return `401 Unauthorized` with a `WWW-Authenticate` header. Use MCP Inspector for protocol testing:

```powershell
npx @modelcontextprotocol/inspector@latest
```

Confirm the public endpoint cannot reach the panel or the internal hub.

## Connect ChatGPT

1. In ChatGPT, open **Settings > Security and login** and enable Developer mode.
2. Open **ChatGPT Plugins**, select **+**, and create a developer-mode connection.
3. Enter the public HTTPS URL including `/mcp` and select OAuth.
4. Complete authorization in the browser.
5. Review and limit tools before using real projects.
6. Test on a disposable directory before enabling a production root.

Stop the service with `Ctrl+C`. Do not open router ports `9998`, `9999`, or `19999`; Funnel is the only intended public path.

## References

- OpenAI: https://developers.openai.com/plugins/deploy/connect-chatgpt
- Tailscale Funnel: https://tailscale.com/docs/features/tailscale-funnel
