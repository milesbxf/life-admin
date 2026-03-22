# Meal planning system

Weekly meal plans sourced from Paprika recipes. Nutrition targets from Cronometer. All meals vegetarian.

## Files
- `current-week.md` — active meal plan for the current week
- `grocery-list.md` — consolidated ingredient list (also synced to Apple Reminders "Grocery")

## Meal plan format

```markdown
# Meal Plan: Week of YYYY-MM-DD

## Targets
Calories: ~XXXX | Protein: XXXg | Carbs: XXXg | Fat: XXg

## Monday YYYY-MM-DD
- **Breakfast:** Recipe name (Paprika: recipe-uid or Spoonacular: spoonacular-id)
- **Lunch:** Recipe name
- **Dinner:** Recipe name
...
```

## Grocery list format

```markdown
# Grocery List: Week of YYYY-MM-DD
Generated: YYYY-MM-DD

## Produce
- [ ] 2x courgettes
## Dairy & Eggs
- [ ] 6 eggs
...
```
