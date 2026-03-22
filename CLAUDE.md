# life-admin

Personal productivity repo for Miles. Connects Claude to health, nutrition, recipe, and productivity data via MCP.

## What this repo is for

- Querying and analysing personal health/fitness data (WHOOP, Cronometer)
- Recipe and meal planning via Paprika
- Task tracking via plain text files in this repo
- Reminders and calendar management via Apple Reminders/Calendar
- Any scripts, automations, or analysis related to personal life admin

## About Miles

- Based in London, UK — home near Barnet (51.6514° N, 0.1993° W), workplace at Moorgate (51.5185° N, 0.0886° W)
- Vegetarian
- Uses Paprika 3 (305+ recipes) with cloud sync
- Tracks nutrition in Cronometer Gold
- Wears WHOOP for recovery/sleep/HRV tracking
- Transitioning away from Todoist — prefers plain text task files in this repo + Apple Reminders for time-based alerts

## Project-local MCP servers

Configured in `.mcp.json`. Credentials already filled in.

### Cronometer ✅
Reads food logs, macros, micros, biometrics, fasting, and diary entries.

- **Package:** `cronometer-mcp` (Python, via `uvx`)
- **Requires:** Cronometer Gold account
- **Caveat:** Uses Cronometer's internal GWT-RPC protocol (no public API). May break when Cronometer pushes a web update — if auth fails, the GWT permutation hash in the package needs updating.
- **Tools:** `get_food_log`, `get_daily_nutrition`, `get_micronutrients`, `get_recent_biometrics`, `add_food_entry`, `search_foods`, and more

### Paprika ✅
Read, create, and update recipes in Paprika 3. Does **not** support Paprika's built-in grocery list feature.

- **Package:** `paprika-mcp` installed via pipx from GitHub (`sandordaroczi/paprika-mcp-python-server`) — not on PyPI. Pinned to commit `f34e3c0af625853ffae6cefde8330651dd7af52e`. To reinstall at this commit: `pipx install "git+https://github.com/sandordaroczi/paprika-mcp-python-server.git@f34e3c0af625853ffae6cefde8330651dd7af52e"`
- **Binary:** `/Users/milesbryant/.local/bin/paprika-mcp`
- **Env vars:** `PAPRIKA_USERNAME`, `PAPRIKA_PASSWORD`
- **Tools:** `list_recipes`, `search_recipes`, `read_recipe`, `create_recipe`, `update_recipe`, `filter_recipes_by_ingredient`, `filter_recipes_by_time`

### WHOOP ✅
Full access to WHOOP v2 API: recovery, sleep, HRV, workouts, cycles.

- **Built from:** `tools/whoop-mcp/` (cloned from `github.com/nissand/whoop-mcp-server-claude`)
- **Bug fix applied:** Added `state` parameter to OAuth URL generation in `src/mcp-server.ts` (upstream missing this, causes auth failure)
- **Known vuln:** 1 high severity issue in `axios` dependency. `npm audit fix` resolves the non-breaking ones; the remaining one requires `--force` (breaking change). Monitor for upstream fix.
- **Auth flow (each new session):**
  1. Ask Claude to call `whoop-get-authorization-url`
  2. Visit the URL in browser and authorise
  3. Copy the `code` param from the redirect URL and paste to Claude
  4. Ask Claude to call `whoop-exchange-code-for-token` with the code
  5. Ask Claude to call `whoop-set-access-token` with the returned token
- **Tools:** recovery, sleep, workouts, cycles, profile, body measurements

### Spoonacular ✅
Recipe discovery and ingredient-based search. Complements Paprika (saved recipes) — use for finding new recipes.

- **Package:** `spoonacular-mcp` via npx
- **Free tier:** 150 requests/day
- **Tools:** `search_recipes` (with vegetarian/cuisine/ingredient filters), `find_recipes_by_ingredients`, `get_recipe_information`, `analyze_nutrition`, `get_random_recipes`

### Weather ✅
Global forecasts using Open-Meteo (UK Met Office UKMO UKV model at 2km, updated hourly).

- **Package:** `@dgahagan/weather-mcp` via npx — no API key needed
- **Default locations:** Barnet (home) and Moorgate (work)

### Apple Events ⚠️ (build pending)
Native integration with Apple Reminders and Calendar via EventKit.

- **Built from:** `tools/apple-events-mcp/` (cloned from `github.com/fradser/mcp-server-apple-events`)
- **Status:** Built and working ✅
- **Config in `.mcp.json`:** `node tools/apple-events-mcp/bin/run.cjs`
- **If binary needs rebuilding** (e.g. after macOS update), run outside Nix shell — Nix injects old SDKROOT which breaks compilation:
  ```bash
  env -u SDKROOT -u DEVELOPER_DIR /usr/bin/swiftc \
    -sdk /Library/Developer/CommandLineTools/SDKs/MacOSX15.5.sdk \
    -o ~/src/github.com/milesbxf/life-admin/tools/apple-events-mcp/bin/EventKitCLI \
    ~/src/github.com/milesbxf/life-admin/tools/apple-events-mcp/src/swift/EventKitCLI.swift \
    -framework EventKit -framework Foundation \
    -Xlinker -sectcreate -Xlinker __TEXT -Xlinker __info_plist \
    -Xlinker ~/src/github.com/milesbxf/life-admin/tools/apple-events-mcp/src/swift/Info.plist
  ```
- **Capabilities:** Full CRUD on Reminders (priority, recurring, location triggers, subtasks, tags) + read/write Apple Calendar events

## Setup checklist

- [x] Cronometer credentials filled in
- [x] Paprika credentials filled in and working
- [x] WHOOP developer app registered, server built, credentials filled in
- [ ] Apple Events MCP: reinstall Xcode CLT, then build Swift binary (see above)

## Dev environment

- **Nix shell:** `shell.nix` provides `uv`, `pipx`, `nodejs`
- **direnv:** `.envrc` runs `use nix` — shell loads automatically on `cd`
- **Note:** Swift compilation must happen outside the Nix shell (Nix injects old SDKROOT that conflicts with system Swift compiler)

## Global MCPs also available

Configured globally and available in all sessions:

- **Perplexity** — web search and research (`perplexity_search`, `perplexity_ask`, `perplexity_research`, `perplexity_reason`)
- **Google Calendar** — via official Claude.ai connector
- **Notion** — via official Claude.ai connector (Miles recently started using this for work)
- **fetch** — raw HTTP fetching (`imageFetch`)
