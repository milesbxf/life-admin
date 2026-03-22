---
description: Quick capture a task, idea, note, or food log
argument-hint: What to capture (e.g. "call plumber monday", "idea: learn pottery", "had a banana")
---

Capture: $ARGUMENTS

Determine the type of this capture:

**If it's food/drink** (e.g. "had a bowl of oats", "just ate a banana", "coffee with oat milk"):
- Spawn the `nutrition-tracker` agent to search and log it in Cronometer
- Show the one-line result (food logged + daily totals)

**Otherwise** (task, idea, note):
- Spawn the `task-router` agent with the full capture text
- Show the one-line result from that agent

Keep your response to 1-3 lines maximum. This is a quick-capture command — be fast and minimal.
