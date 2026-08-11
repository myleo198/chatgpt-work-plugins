# ChatGPT Work Plugins

Personal marketplace for portable ChatGPT Work and Codex plugins adapted from pinned open-source repositories.

## Install

```bash
codex plugin marketplace add myleo198/chatgpt-work-plugins --ref main
```

The marketplace marks its local plugins as `INSTALLED_BY_DEFAULT`; after the marketplace is added, start a new Codex session and use `/plugins` to verify their state. The repository also includes offline transfer launchers in [`distribution/`](distribution/) for a computer where you do not want to use GitHub or Plugin Portal.

## Included plugins

- `firecrawl-work`: web search, scraping, crawling, mapping, and extraction workflows.
- `openwiki-work`: build and query repository or personal knowledge wikis.
- `ponytail-work`: local, pinned Ponytail skills for minimal implementation and over-engineering review.
- `tencentdb-agent-memory-work`: deploy and operate TencentDB Agent Memory workflows.
- `ix-work`: map and query code structure with the Ix CLI and persistent graph.
- `img2threejs-work`: rebuild reference images as quality-gated, editable procedural Three.js models.
- `myleo-work-toolkit`: one skills-only bundle containing the supported workflows for later ChatGPT Web submission.
- `aki-mcp-work`: run the Aki OAuth-protected remote MCP server for local files and allowlisted shell access. See the [Windows HTTPS deployment guide](plugins/aki-mcp-work/skills/aki-mcp-work/references/https-deployment-windows.md).

See [PROVENANCE.md](PROVENANCE.md) for pinned revisions and licenses.
