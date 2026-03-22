# life-admin

Personal productivity repo for Miles. Connects Claude to health, nutrition, and recipe data via MCP.

## What this repo is for

- Querying and analysing personal health/fitness data (WHOOP, Cronometer)
- Recipe and meal planning via Paprika
- Any scripts, automations, or analysis related to personal life admin

## MCP servers

Three project-local MCPs are configured in `.mcp.json`. All require credentials to be filled in before use.

### Cronometer
Reads food logs, macros, micros, biometrics, fasting, and diary entries.

- **Package:** `cronometer-mcp` (Python, via `uvx`)
- **Requires:** Cronometer Gold account
- **Credentials needed:** Set `CRONOMETER_USERNAME` and `CRONOMETER_PASSWORD` in `.mcp.json`
- **Caveat:** Uses Cronometer's internal GWT-RPC protocol (no public API). May break when Cronometer pushes a web update — if auth fails, the GWT permutation hash in the package needs updating.

### Paprika
Read, create, and update recipes in Paprika 3.

- **Package:** `paprika-3-mcp` (Python, via `uvx`)
- **Requires:** Paprika 3 with cloud sync enabled
- **Credentials needed:** Set `PAPRIKA_EMAIL` and `PAPRIKA_PASSWORD` in `.mcp.json`

### WHOOP
Full access to WHOOP v2 API: recovery, sleep, HRV, workouts, cycles.

- **Requires:** WHOOP Developer account + app registration
- **Setup steps (one-time):**
  1. Go to https://developer.whoop.com and create an application
  2. Set redirect URI to `http://localhost:3000/callback`
  3. Note your Client ID and Client Secret
  4. Clone and build the server:
     ```
     git clone https://github.com/nissand/whoop-mcp-server-claude tools/whoop-mcp
     cd tools/whoop-mcp
     npm install && npm run build
     ```
  5. Fill in `WHOOP_CLIENT_ID` and `WHOOP_CLIENT_SECRET` in `.mcp.json`
- **Auth flow (each new session):** Ask Claude to authenticate with WHOOP. It will give you an OAuth URL. After authorising in browser, copy the `code` param from the redirect URL and paste it back to Claude.

## Setup checklist

- [ ] Fill in Cronometer credentials in `.mcp.json`
- [ ] Fill in Paprika credentials in `.mcp.json`
- [ ] Register WHOOP developer app and clone/build `tools/whoop-mcp`
- [ ] Fill in WHOOP credentials in `.mcp.json`

## Global MCPs also available

These are configured globally (`~/.claude.json`) and available in all sessions:

- **Perplexity** — web search and research
- **Google Calendar** — via official Claude.ai connector (not in `.mcp.json`)
- **Notion** — via official Claude.ai connector (not in `.mcp.json`)
- **fetch** — raw HTTP fetching
