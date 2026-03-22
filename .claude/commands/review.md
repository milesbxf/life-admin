---
description: Weekly review — health summary, project progress, inbox processing, and next week's meal plan
---

Weekly review for week ending !`date "+%-d %B %Y"`.

## Step 1 — Gather data (parallel)

Run these simultaneously:
1. Spawn `health-reporter` agent with scope "weekly" — get 7-day health summary
2. Read all files in `para/areas/` and `para/projects/` — note open tasks, status of each
3. Read `para/inbox.md` — list all unprocessed items

## Step 2 — Health summary

Show the health-reporter output. Note any significant patterns (e.g. low protein streak, poor sleep).

## Step 3 — Projects & areas review

For each active project in `para/projects/`, show:
- Status and deadline
- What was completed this week (tasks marked [x])
- Open tasks remaining
- Ask: any updates? blockers?

For each area in `para/areas/`, show open tasks. Ask if anything needs attention.

## Step 4 — Inbox processing

Show each item in `para/inbox.md` one at a time:
- Display the item
- Ask: which area or project? (or: someday / discard)
- Use `task-router` agent to move it to the chosen location
- Remove it from inbox.md once routed

## Step 5 — Meal planning

Ask: "Ready to plan next week's meals?"
If yes, proceed with the full `/meal-plan` flow.

## Step 6 — Wrap up

Summary:
- X tasks completed this week
- X new tasks captured
- Health trend: [brief note]
- Next week's focus: [ask Miles for one thing to prioritise]
