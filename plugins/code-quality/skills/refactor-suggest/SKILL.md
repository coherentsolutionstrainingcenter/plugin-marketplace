---
name: refactor-suggest
description: >
  Analyzes code for refactoring opportunities. Use when the user asks to
  "suggest refactoring", "improve this code", "simplify this function",
  "reduce complexity", or mentions code smells.
---

# Refactoring Suggestions

<!-- EDUCATIONAL NOTE:
     This skill demonstrates:
     1. Analysis-only skills — it suggests changes but doesn't make them
     2. Pattern-based guidance — teaches Claude to recognize code smells
     3. Before/after examples — shows how to guide output format
-->

## Target

Analyze for refactoring opportunities: $ARGUMENTS

If no specific target is provided, ask the user what code they'd like analyzed.

## Analysis Process

Read the target code and identify these code smells:

### Code Smell Detection

1. **Long Methods** (>30 lines) — Extract smaller, focused functions
2. **Deep Nesting** (>3 levels) — Use early returns, guard clauses, or extract logic
3. **Duplicate Code** — Extract shared logic into a reusable function
4. **Large Classes/Modules** (>300 lines) — Split by responsibility
5. **Feature Envy** — A function that uses another module's data more than its own
6. **Primitive Obsession** — Using raw strings/numbers where a typed object fits better
7. **Long Parameter Lists** (>4 params) — Introduce a parameter object or builder
8. **Boolean Parameters** — Replace with two clearly-named functions or an enum
9. **Dead Code** — Unreachable code, unused imports, commented-out blocks

## Suggested Refactoring Patterns

For each smell found, suggest one of these patterns:

| Smell | Pattern | Description |
|-------|---------|-------------|
| Long Method | **Extract Method** | Pull a block into a named function |
| Deep Nesting | **Guard Clause** | Flip conditions to return early |
| Duplicate Code | **Extract Function** | Shared logic in one place |
| Large Class | **Extract Class/Module** | Split by single responsibility |
| Feature Envy | **Move Method** | Move logic to the module that owns the data |
| Primitive Obsession | **Value Object** | Wrap primitives in a descriptive type |
| Long Params | **Parameter Object** | Group related params into one typed object |
| Boolean Params | **Split Function** | Two clear functions instead of one with a flag |

## Output Format

For each finding, show a before/after comparison:

```
## Refactoring Opportunities: [file/module name]

### 1. [Smell Name] — [location]
**Smell:** [Brief description of the problem]
**Pattern:** [Suggested refactoring pattern]

Before:
[Current code snippet]

After:
[Refactored code snippet]

**Why:** [1 sentence explaining the improvement]
```

Prioritize suggestions by impact: correctness > readability > consistency.
Do NOT make the changes — only suggest them. The user decides what to apply.
