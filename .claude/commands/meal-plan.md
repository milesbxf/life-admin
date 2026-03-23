---
description: Plan next week's vegetarian meals from Paprika recipes, balanced to nutrition targets
---

Today is !`date "+%A, %-d %B %Y"`.

Spawn the `meal-planner` agent to plan meals for Monday–Friday.

The agent will:
1. Check your Cronometer nutrition targets
2. Browse your Paprika recipes (and Spoonacular for new ideas)
3. Propose a batch-cooking-first Mon–Fri plan (lunch + dinner only)
4. Ask for your approval before saving

Once saved to `meal-planning/current-week.md`, ask: "Generate grocery list now?" If yes, proceed with the /grocery flow.
