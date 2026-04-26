<!-- PARA project file: Migrate life-admin from Claude Code to Hermes Agent -->
# Hermes Migration — life-admin

## Status
**Active** | Started: 2026-04-26 | Target: 2026-04-26 (single session)

## Outcome
Full migration of life-admin system from Claude Code to Hermes Agent, using native Hermes integrations wherever possible. Claude Code .claude/ directory removed at end.

## Plan

### Phase 1: Context Files
- [ ] Rename CLAUDE.md → AGENTS.md (strip Claude-specific bits, add Hermes workdir notes)
- [ ] Rename para/CLAUDE.md → para/AGENTS.md
- [ ] Rename meal-planning/CLAUDE.md → meal-planning/AGENTS.md
- [ ] Keep DEV.md as-is (reference doc, not agent context)

### Phase 2: MCP Servers → Hermes config.yaml
- [ ] Add cronometer to ~/.hermes/config.yaml mcp_servers (uvx, env vars from .env)
- [ ] Add paprika to config.yaml mcp_servers (pipx binary)
- [ ] Add spoonacular to config.yaml mcp_servers (npm)
- [ ] Add weather to config.yaml mcp_servers (npm)
- [ ] Add paperless to config.yaml mcp_servers (node, env vars)
- [ ] Add whoop to config.yaml mcp_servers (node, env vars)
- [ ] Drop apple-events MCP — replaced by remindctl + google-workspace
- [ ] Drop perplexity MCP — replaced by OpenRouter sonar-pro model
- [ ] Drop google-calendar MCP — replaced by google-workspace skill
- [ ] Drop notion MCP — replaced by native notion skill
- [ ] Verify all MCP servers connect: hermes mcp test <name>
- [ ] Copy required env vars from life-admin/.env to ~/.hermes/.env

### Phase 3: Skills (commands + agents → Hermes skills)
- [ ] Create skill: life-admin-daily (morning dashboard)
      Sources: .claude/commands/daily.md + .claude/agents/health-reporter.md
      MCP: whoop, cronometer, weather | Also: google-workspace (calendar), remindctl
      Reads: para/ files for due tasks, meal-planning/current-week.md
- [ ] Create skill: life-admin-capture (quick capture router)
      Sources: .claude/commands/capture.md + .claude/agents/task-router.md + .claude/agents/nutrition-tracker.md
      MCP: cronometer | Also: remindctl
      Writes: para/ files
- [ ] Create skill: life-admin-food-log (log food to Cronometer)
      Sources: .claude/commands/log.md + .claude/agents/nutrition-tracker.md
      MCP: cronometer
- [ ] Create skill: life-admin-health (health dashboard)
      Sources: .claude/commands/health.md + .claude/agents/health-reporter.md
      MCP: whoop, cronometer
- [ ] Create skill: life-admin-weekly-review (Sunday review)
      Sources: .claude/commands/review.md + .claude/agents/health-reporter.md
      MCP: whoop, cronometer | Also: google-workspace, remindctl
      Reads/writes: para/ files, meal-planning/
- [ ] Create skill: life-admin-meal-plan (weekly meal planning)
      Sources: .claude/commands/meal-plan.md + .claude/agents/meal-planner.md
      MCP: paprika, spoonacular, cronometer
      Writes: meal-planning/current-week.md
- [ ] Create skill: life-admin-grocery (grocery list from meal plan)
      Sources: .claude/commands/grocery.md
      Reads: meal-planning/current-week.md, meal-planning/grocery-list.md
      Also: remindctl (add to Apple Reminders "Grocery" list)
- [ ] Create skill: life-admin-research (deep research via Perplexity)
      Sources: .claude/commands/research.md + .claude/agents/researcher.md
      Uses: delegate_task with model perplexity/sonar-pro via OpenRouter
      No MCP needed
- [ ] Create skill: life-admin-paperless (search + inbox + topic + tax-docs)
      Sources: .claude/commands/find-docs.md, paperless-inbox.md, paperless-topic.md, tax-docs.md
              + .claude/agents/paperless-processor.md, paperless-summariser.md
      MCP: paperless
      Consolidate 4 commands + 2 agents into 1 skill with sections

### Phase 4: Cron Jobs
- [ ] Morning dashboard: 0 7 * * * → deliver to Discord
      Loads: life-admin-daily skill
      workdir: ~/src/github.com/milesbxf/life-admin
- [ ] Weekly review nudge: 0 18 * * 0 → deliver to Discord
      Loads: life-admin-weekly-review skill
      Prompt: "Run the weekly review"
- [ ] Inbox check: 0 20 * * * → deliver to Discord (only if items pending)
      Reads: para/inbox.md, counts unchecked items
      Script: small Python script to check inbox, skip if empty
- [ ] Meal plan reminder: 0 10 * * 0 → deliver to Discord
      Reads: meal-planning/current-week.md, checks if plan exists for upcoming week

### Phase 5: Hermes Memory
- [ ] Seed key facts: Miles profile, repo path, PARA conventions, nutrition targets
- [ ] Verify existing memory doesn't conflict

### Phase 6: Google Workspace Setup
- [ ] Run google-workspace OAuth setup (if not already done)
- [ ] Verify calendar access works

### Phase 7: WHOOP Token Persistence
- [ ] Investigate WHOOP OAuth refresh token lifetime
- [ ] Implement auto-refresh in MCP server or wrapper script
- [ ] Test that cron jobs can access WHOOP without manual re-auth
- [ ] If refresh token approach fails: add graceful degradation to daily skill

### Phase 8: Cleanup
- [ ] Delete .claude/ directory
- [ ] Delete .mcp.json (replaced by Hermes config.yaml)
- [ ] Update .gitignore if needed
- [ ] Commit: "migrate: Claude Code → Hermes Agent"

## Architecture Notes

### Perplexity Research (no MCP)
Instead of a Perplexity MCP server, use delegate_task with model override:
  model: perplexity/sonar-pro (or sonar-pro-search for agentic mode)
  provider: openrouter
This gives grounded, cited web research using the existing OpenRouter API key.

### Apple Events Replacement
The apple-events MCP handled both Reminders and Calendar:
  - Reminders → remindctl CLI (Hermes apple-reminders skill, brew install steipete/tap/remindctl)
  - Calendar → google-workspace skill (Miles uses Google Calendar primarily)
  Net effect: one MCP server replaced by two native integrations, no submodule to maintain.

### Skill Structure
Each skill contains the full prompt/instructions that were previously split across
a command file + an agent file in Claude Code. Hermes loads skills into context
automatically when relevant, or explicitly via /skill <name>.

### Cron Job Delivery
All cron outputs → Discord (home channel).
Jobs use workdir to auto-load AGENTS.md context.
Jobs that read repo files (meal plan, inbox) use script= for pre-checks where possible.

## Dependencies
- remindctl installed: brew install steipete/tap/remindctl
- google-workspace OAuth completed
- MCP servers verified connecting
- Env vars copied to ~/.hermes/.env
