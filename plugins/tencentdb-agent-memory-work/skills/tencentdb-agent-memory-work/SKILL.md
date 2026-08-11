---
name: tencentdb-agent-memory-work
description: Install, deploy, configure, migrate, or operate TencentDB Agent Memory, including Memory Core, Memory Hub, Proxy, Wiki, CodeGraph, chat memory, and reusable skills. Use when the user names TencentDB Agent Memory or asks to establish its persistent agent-memory stack.
---

# TencentDB Agent Memory Work

Use the upstream deployment method matching the pinned source revision. Treat memory assets as user data, not disposable cache.

## Workflow

1. Inventory the host: Node.js version, Docker availability, storage, database, ports, LLM providers, and data residency requirements.
2. Read the upstream install or deployment document that matches the chosen topology before running commands.
3. Create environment configuration from the supplied example without committing secrets.
4. Start the smallest component set required; verify health before importing data.
5. Back up existing data before migrations or schema changes.
6. Validate owner, team, role, visibility, and agent ACL behavior on imported assets.
7. Confirm Wiki and CodeGraph indexes against a small representative source before bulk ingestion.
8. Report component versions, endpoints, persistent volumes, and rollback steps.

## Safety

- Never expose the management panel or unauthenticated services publicly.
- Require explicit confirmation before deleting memories, reindexing destructively, or migrating production data.
- Separate private, team, and restricted assets according to the upstream access model.

## Source

Adapted from `TencentCloud/TencentDB-Agent-Memory` revision `0a568c328ea1aae3f22ed3656e7900da7ea565c1` under MIT.
