---
description: Generate grocery list from current meal plan and add to Apple Reminders "Grocery" list
---

Generate grocery list from `meal-planning/current-week.md`.

1. Read `meal-planning/current-week.md` — extract all recipes for the week

2. For each recipe that has a Paprika UID, call `read_recipe` to get the full ingredients list. For Spoonacular recipes, call `get_recipe_information`.

3. Consolidate all ingredients:
   - Combine duplicate ingredients (e.g. "3 onions" + "2 onions" = "5 onions")
   - Group by category: Produce, Dairy & Eggs, Grains & Pulses, Tins & Jars, Fridge, Freezer, Pantry, Other
   - Omit common pantry staples that Miles likely has (olive oil, salt, pepper, common spices)

4. Write to `meal-planning/grocery-list.md` using the format in `meal-planning/CLAUDE.md`.

5. Add items to Apple Reminders:
   - List name: "Grocery" (create if doesn't exist)
   - One reminder per item, uncompleted
   - Clear any existing items in the Grocery list first (to avoid duplicates from last week)

6. Confirm: "X items added to Grocery list in Reminders."
