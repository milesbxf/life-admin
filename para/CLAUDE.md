# PARA — Personal knowledge and task system

Uses the PARA method (Projects, Areas, Resources, Archive). Plain markdown, git-tracked. Apple Reminders only for time/location alerts.

## File format

```markdown
<!-- PARA [type] file: one-line description -->
# Title

## Goals          (areas only)
## Status         (projects only: active | on-hold | complete, outcome, deadline)
## Tasks
- [ ] Task description @due(YYYY-MM-DD) @reminder
- [x] Completed task
## Notes
```

## Conventions
- `@due(YYYY-MM-DD)` — due date on a task
- `@reminder` — task also exists in Apple Reminders (with due date/time)
- Tasks without @due go in markdown only; tasks with time-based alerts get @reminder
- Completed projects move to `archive/` — don't delete, just move
- `inbox.md` holds unprocessed captures awaiting review
