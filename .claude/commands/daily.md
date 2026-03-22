---
description: Morning planning dashboard — calendar, tasks, health stats, today's meals. Option to process inbox.
---

Good morning. Today is !`date "+%A, %-d %B %Y"`.

Run these in parallel:
1. Spawn the `health-reporter` agent (daily scope) for yesterday's recovery and nutrition
2. Read `para/inbox.md` to count unprocessed items
3. Read `meal-planning/current-week.md` for today's planned meals
4. Fetch today's events from Apple Calendar (use `calendar_events` tool for today's date range) and Google Calendar

Once all data is ready, render a compact dashboard:

---

## Good morning, Miles! [Day, Date]

**Today's calendar**
[List events with time. If none: "No events today."]

**Health**
[Insert health-reporter output — recovery, yesterday nutrition]

**Today's meals**
[From current-week.md: Breakfast / Lunch / Dinner. If no plan: "No meal plan — run /meal-plan"]

**Due today**
[Tasks from para/ files that have @due matching today. If none: "Nothing due today."]

---

**Inbox:** [N] items pending

What would you like to do?
- **Process inbox** — go through captured items
- **All good** — nothing more needed
