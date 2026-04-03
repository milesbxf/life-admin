# DEV — Setup and development environment

Reference for repo maintenance and new machine setup. Not needed for daily use.

## Dev environment

- **Nix shell:** `shell.nix` provides `uv`, `pipx`, `nodejs`
- **direnv:** `.envrc` runs `use nix` + `dotenv` — shell and credentials load automatically on `cd`
- **Secrets:** stored in `.env` (gitignored). Copy `.env.example` and fill in.
- **Submodules:** after cloning, run `git submodule update --init`
- **npm deps:** run `npm ci` to install Spoonacular/Weather MCP packages from lockfile

## MCP server details

### Cronometer
- Package: `cronometer-mcp==2.0.3` (Python, via `uvx`)
- Caveat: Uses internal GWT-RPC protocol. May break on Cronometer web updates — GWT permutation hash in package needs updating if auth fails.

### Paprika
- Not on PyPI. Installed via pipx from GitHub: `sandordaroczi/paprika-mcp-python-server`
- Pinned commit: `f34e3c0af625853ffae6cefde8330651dd7af52e`
- To reinstall: `pipx install "git+https://github.com/sandordaroczi/paprika-mcp-python-server.git@f34e3c0af625853ffae6cefde8330651dd7af52e"`
- Binary: `/Users/milesbryant/.local/bin/paprika-mcp`

### WHOOP
- Submodule: `tools/whoop-mcp/` → `github.com/milesbxf/whoop-mcp-server-claude` branch `milesbxf-main`
- Includes: upstream PRs #5 (state param fix) and #6 (auto token refresh, security hardening, 71 tests)

### Apple Events
- Submodule: `tools/apple-events-mcp/` → upstream `github.com/FradSer/mcp-server-apple-events` v1.4.0
- **Rebuilding Swift binary** (run outside Nix shell — Nix SDKROOT conflicts):
  ```bash
  env -u SDKROOT -u DEVELOPER_DIR /usr/bin/swiftc \
    -sdk /Library/Developer/CommandLineTools/SDKs/MacOSX15.5.sdk \
    -o ~/src/github.com/milesbxf/life-admin/tools/apple-events-mcp/bin/EventKitCLI \
    ~/src/github.com/milesbxf/life-admin/tools/apple-events-mcp/src/swift/EventKitCLI.swift \
    -framework EventKit -framework Foundation \
    -Xlinker -sectcreate -Xlinker __TEXT -Xlinker __info_plist \
    -Xlinker ~/src/github.com/milesbxf/life-admin/tools/apple-events-mcp/src/swift/Info.plist
  ```

### Paperless-ngx
- Submodule: `tools/paperless-mcp/` → `github.com/milesbxf/paperless-mcp-server` branch `milesbxf-main`
- Fork of `heimerle/paperless-mcp-server` — 41 tools covering full Paperless API
- Auth: Token-based — generate from Paperless web UI → My Profile → API Token
- Env vars: `PAPERLESS_URL` (your https:// domain), `PAPERLESS_TOKEN`
- Patch: `getDocumentContent` uses `/api/documents/{id}/` instead of `/content/` endpoint (which redirects to login with token auth in Paperless-ngx ≥2.19)
- To rebuild: `cd tools/paperless-mcp && npm install && npm run build`

### Excalidraw
- Package: `excalidraw-mcp-server@2.0.0` (npm)
- No API key needed. Runs in standalone mode (no canvas server required).
- Tools: create/update/delete/query elements, batch create, group/align/distribute, export scene, create from Mermaid

### Spoonacular
- Package: `spoonacular-mcp@1.0.0` (npm, SHA512-pinned)
- Free tier: 150 requests/day

### Weather
- Package: `@dangahagan/weather-mcp@1.6.1` (npm, SHA512-pinned)
- No API key needed. Uses Open-Meteo / UK Met Office UKMO UKV model (2km, hourly updates)

## Setup checklist

- [x] Cronometer credentials in `.env`
- [x] Paprika credentials in `.env`
- [x] WHOOP developer app registered, submodule built, credentials in `.env`
- [x] Apple Events MCP Swift binary built
- [x] Spoonacular API key in `.env`
- [ ] Paperless-ngx URL and API token in `.env`
- [x] All credentials via `${VAR}` in `.mcp.json` — never committed
- [x] npm deps SHA512-pinned via `package-lock.json`
