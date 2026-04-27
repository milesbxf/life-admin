# PARA Librarian Implementation Plan

> **For Hermes:** Use subagent-driven-development skill to implement this plan task-by-task.

**Goal:** Build an autonomous skill to route items from `inbox.md` to appropriate PARA files with atomic Git commits.

**Architecture:** 
1. Read `para/inbox.md`.
2. For each entry, use an LLM to classify destination: `Projects/`, `Areas/`, or `Resources/`.
3. If entry belongs to an existing file, use `patch` to append.
4. If entry is a new project/resource, create a new `.md` file with standard templates.
5. Execute one `git commit` per item moved.

**Tech Stack:** Python, Git, Hermes File Tools, LLM (Classification).

---

### Task 1: Create the Classification Logic
**Objective:** Write a script to take an inbox entry and suggest a PARA path.
**Files:** `scripts/para_classifier.py`

### Task 2: Create the Sorter Skill
**Objective:** Implement the `life-admin-para-sorter` skill that iterates through the inbox.
**Files:** `skills/life-admin-para-sorter/SKILL.md`

### Task 3: Add Atomic Git Support
**Objective:** Wrap moves in unique git commits with descriptive messages.
**Logic:** `git commit -m "para(auto): moved <item> to <path>"`

---
**Checkpoint Rule:** If planned changes > 10 items, stop and ask the user for permission.
