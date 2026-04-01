# life-admin

Personal life admin OS for Miles. Uses Claude slash commands to orchestrate health tracking, meal planning, and task management via MCP integrations. Primarily used via Claude Code on phone.

## About Miles

London, UK (Barnet home / Moorgate work). Vegetarian. WHOOP for fitness tracking, Cronometer Gold for nutrition, Paprika 3 (305+ recipes) for meals.

## Commands

| Command | Description |
|---------|-------------|
| `/daily` | Morning dashboard: calendar, tasks, health stats, today's meals. Option to process inbox. |
| `/capture` | Quick capture a task, idea, note, or food log. Smart-routes to right place. |
| `/log` | Log food to Cronometer with running daily totals. |
| `/health` | Health dashboard: WHOOP recovery/sleep/HRV + Cronometer nutrition + biometrics. |
| `/review` | Weekly review: health summary, project progress, inbox processing, meal planning. |
| `/meal-plan` | Plan next week's meals from Paprika recipes, meeting nutrition targets. |
| `/research` | Research any question via Perplexity — facts, local services, DIY, comparisons. |
| `/grocery` | Generate grocery list from meal plan → Apple Reminders "Grocery" list. |
| `/find-docs` | Search Paperless for documents matching a query and summarise findings. |
| `/paperless-inbox` | Process Paperless inbox — apply tags, correspondent, type, and clean titles. |
| `/paperless-topic` | Pull together all Paperless documents related to a topic. |
| `/tax-docs` | Find and summarise all tax-relevant documents for a given tax year. |

## Directory structure

```
para/           PARA task & knowledge system (see para/CLAUDE.md)
  inbox.md      Unprocessed captures
  projects/     Active projects with outcomes + deadlines
  areas/        Ongoing life domains (health, home, finances)
  resources/    Reference material
  archive/      Completed/inactive items
meal-planning/  Weekly meal plans and grocery lists (see meal-planning/CLAUDE.md)
.claude/
  commands/     Slash command definitions
  agents/       Subagent definitions (health-reporter, meal-planner, task-router, nutrition-tracker)
tools/          MCP server submodules (whoop-mcp, apple-events-mcp)
DEV.md          Setup, dev environment, MCP server details
```

## MCP servers available

| Server | Purpose |
|--------|---------|
| cronometer | Food logs, macros, micros, biometrics, fasting |
| paprika | Recipe CRUD — list, search, read, create, update |
| whoop | Recovery, sleep, HRV, workouts, cycles |
| apple-events | Apple Reminders CRUD + Calendar read/write |
| spoonacular | Recipe discovery (150 req/day free tier) |
| weather | Forecasts for Barnet & Moorgate |
| perplexity | Web search and research (global) |
| google-calendar | Google Calendar (global) |
| notion | Notion pages/databases — mainly work (global) |
| paperless | Paperless-ngx documents — search, upload, tag, retrieve content |

## WHOOP auth (required each new session)

1. Call `whoop-get-authorization-url` → visit URL → authorise
2. Copy `code` from redirect URL
3. Call `whoop-exchange-code-for-token` with the code
4. Call `whoop-set-access-token` with returned token

## Roadmap

- [ ] More PARA areas: career/work, relationships, personal development
- [ ] Journal command `/journal` for daily reflections
- [ ] Finance tracking integration
- [ ] Location-based reminders via Apple Reminders
- [ ] Habit tracking
