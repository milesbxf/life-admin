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
- [x] All credentials via `${VAR}` in `.mcp.json` — never committed
- [x] npm deps SHA512-pinned via `package-lock.json`
