# Hermes Project Context
# Working Directory: /Users/milesbryant/src/github.com/milesbxf/life-admin

# life-admin

Personal life admin OS for Miles. Orchestrates health tracking, meal planning, and task management via Hermes Agent (Discord + CLI) with MCP integrations. The repo is the ground truth; Discord is the interface.

## About Miles

London, UK (Barnet home / Moorgate work). Vegetarian. WHOOP for fitness tracking, Cronometer Gold for nutrition, Paprika 3 (305+ recipes) for meals.

## Capabilities (Hermes Skills)

| Skill | Description |
|-------|-------------|
| `life-admin-daily` | Morning dashboard: calendar, tasks, health stats, today's meals |
| `life-admin-capture` | Quick capture → routes to PARA files, commits to git |
| `life-admin-health` | Health dashboard: WHOOP recovery/sleep/HRV + Cronometer nutrition |
| `life-admin-meal-planner` | Weekly meal plan from Paprika recipes, meeting macro targets |
| `life-admin-paperless` | Paperless-ngx: search, inbox processing, topic gathering, tax docs |
| `life-admin-research` | Deep research via Perplexity sonar-pro |
| `chocolate-shake-recipe` | Daily chocolate shake recipe and logging |

## Automation (Cron Jobs)

| Schedule | Job | Delivery |
|----------|-----|----------|
| 07:00 daily | Morning Dashboard | Discord |
| 07:30 daily | WHOOP Journal (auto-logs yesterday's recovery/sleep to health.md) | Discord |
| 17:00 daily | Macro Audit (protein alert if >20g short) | Discord |
| 20:00 daily | PARA Inbox Check | Discord |
| Every 3h | Git auto-commit & push | Local |
| Every 4h | PARA Drift Check (overdue tasks, stale files) | Discord |
| Sun 18:00 | Weekly Review (health + projects + inbox + meal plan) | Discord |

## Directory structure

```
para/           PARA task & knowledge system (see para/AGENTS.md)
  inbox.md      Unprocessed captures
  projects/     Active projects with outcomes + deadlines
  areas/        Ongoing life domains (health, home, finances)
  resources/    Reference material
  archive/      Completed/inactive items
meal-planning/  Weekly meal plans and grocery lists (see meal-planning/AGENTS.md)
tools/          MCP server submodules (whoop-mcp)
DEV.md          Setup, dev environment, MCP server details
```

## MCP servers available (configured in ~/.hermes/config.yaml)

| Server | Purpose |
|--------|---------|
| cronometer | Food logs, macros, micros, biometrics, fasting |
| paprika | Recipe CRUD — list, search, read, create, update |
| whoop | Recovery, sleep, HRV, workouts, cycles |
| spoonacular | Recipe discovery (150 req/day free tier) |
| weather | Forecasts for Barnet & Moorgate |
| paperless | Paperless-ngx documents — search, upload, tag, retrieve content |

## Native integrations (Hermes skills, not MCP)

| Integration | Via |
|------------|-----|
| Apple Reminders | `remindctl` CLI (apple-reminders skill) |
| Google Calendar | google-workspace skill (OAuth2, venv at ~/.hermes/venv_google) |
| Perplexity research | delegate_task to perplexity/sonar-pro via OpenRouter |

## WHOOP OAuth Setup

1. Call `whoop-get-authorization-url` → visit URL → authorise
2. Copy `code` from redirect URL
3. Call `whoop-exchange-code-for-token` with the code
4. Call `whoop-set-access-token` with returned token
Token stored at: `~/.hermes/storage/tokens/whoop_token.json`

## Roadmap

- [ ] More PARA areas: career/work, relationships, personal development
- [ ] Journal command `/journal` for daily reflections
- [ ] Finance tracking integration
- [ ] Location-based reminders via Apple Reminders
- [ ] Habit tracking
