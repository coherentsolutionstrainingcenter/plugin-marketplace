---
name: check-standards
description: >
  Checks code against team TypeScript/JavaScript coding standards. Use when
  the user asks to "check standards", "verify conventions", "check code style",
  or when the standards-enforcer agent needs coding convention guidance.
---

# Team Coding Standards

<!-- EDUCATIONAL NOTE:
     This skill is designed to be used BOTH:
     1. Directly by users: /team-standards:check-standards src/
     2. By the standards-enforcer agent as a reference

     This demonstrates how skills can serve dual purposes — standalone
     usage AND as knowledge bases for agents.
-->

## Target

Check coding standards for: $ARGUMENTS

## TypeScript / JavaScript Standards

### Type Safety
- **No `any` type** — use `unknown` for truly unknown types, then narrow with type guards
- **Explicit return types** on all exported functions — internal functions can use inference
- **Strict mode required** — `"strict": true` in tsconfig.json
- **No type assertions** (`as Type`) unless there's a comment explaining why it's safe
- **Prefer interfaces** over type aliases for object shapes (interfaces are extendable)

### Naming Conventions
- **Variables and functions:** camelCase (`getUserById`, `isActive`)
- **Classes and interfaces:** PascalCase (`UserService`, `ApiResponse`)
- **Constants:** UPPER_SNAKE_CASE (`MAX_RETRIES`, `API_BASE_URL`)
- **Files:** kebab-case for utilities (`string-utils.ts`), PascalCase for components (`UserProfile.tsx`)
- **Enums:** PascalCase name, PascalCase members (`UserRole.Admin`)
- **Boolean variables:** must use is/has/should/can prefix (`isActive`, `hasPermission`)

### Code Structure
- **Max function length:** 30 lines (configurable in settings.json)
- **Max file length:** 300 lines (configurable in settings.json)
- **Single responsibility:** one exported concept per file
- **No barrel exports** (`index.ts` re-exports) unless the module is a public API
- **Import order:** built-in > external > internal > relative, separated by blank lines

### Error Handling
- **Always catch specific errors** — no empty catch blocks
- **Custom error classes** for domain errors (extend Error with a `code` property)
- **Error messages must be actionable** — include what went wrong AND what to do about it
- **No swallowed errors** — log or rethrow, never silently ignore

### Functions
- **Max 4 parameters** — use an options object for more
- **No boolean parameters** — use two functions or an enum instead
- **Pure functions preferred** — minimize side effects
- **Early returns** — use guard clauses instead of deep nesting

## Output Format

For each file checked, report:

```
### [filename]
| Rule | Status | Line | Details |
|------|--------|------|---------|
| No `any` type | PASS/FAIL | [line] | [finding] |
| Explicit returns | PASS/FAIL | [line] | [finding] |
| Naming: [element] | PASS/FAIL | [line] | [finding] |
| Function length | PASS/FAIL | [line] | [X lines, max Y] |
```
