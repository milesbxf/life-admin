---
description: Morning planning dashboard — calendar, tasks, health stats, today's meals. Option to process inbox.
---

Good morning. Today is !`date "+%A, %-d %B %Y"`.

Run these in parallel:
1. Fetch WHOOP data directly: call `whoop-get-recovery-collection` (no args) and `whoop-get-sleep-collection` (no args) — take the most recent record from each
2. Fetch Cronometer nutrition: call `get_daily_nutrition` for yesterday's date
3. Read `para/inbox.md` to count unprocessed items
4. Read `meal-planning/current-week.md` for today's planned meals
5. Fetch today's events from Google Calendar only (do NOT use Apple Calendar)
6. Get today's weather forecast for Barnet using `get_forecast` with latitude=51.645, longitude=-0.2, days=1, source=openmeteo, granularity=hourly. Show 3-hourly slots (e.g. 06:00, 09:00, 12:00, 15:00, 18:00). Always use Celsius, never Fahrenheit.

Note: If WHOOP returns an auth error, show "WHOOP auth needed — run whoop-get-authorization-url" instead.

Once all data is ready, render a compact dashboard:

---

## Good morning, Miles! [Day, Date]

**Weather** _(Barnet)_
[3-hourly: 06:00 Xº · 09:00 Xº · 12:00 Xº · 15:00 Xº · 18:00 Xº — conditions summary. All temps in °C.]

**Today's calendar**
[List events with time. If none: "No events today."]

**Health** _(last night / yesterday)_
| | |
|---|---|
| Recovery | [score]% |
| HRV | [hrv_rmssd_milli rounded]ms |
| Resting HR | [resting_heart_rate]bpm |
| Sleep | [duration h/m] · [sleep_performance_percentage]% performance |

**Yesterday's nutrition**
| | |
|---|---|
| Calories | [Energy kcal] kcal |
| Protein | [Protein g]g |
| Carbs | [Carbs g]g |
| Fat | [Fat g]g |

**Today's meals**
[From current-week.md: Breakfast / Lunch / Dinner. If no plan: "No meal plan — run /meal-plan"]

**Due today**
[Tasks from para/ files that have @due matching today. If none: "Nothing due today."]

---

**Inbox:** [N] items pending

What would you like to do?
- **Process inbox** — go through captured items
- **All good** — nothing more needed
