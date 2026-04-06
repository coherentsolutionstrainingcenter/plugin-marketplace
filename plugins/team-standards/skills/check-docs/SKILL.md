---
name: check-docs
description: >
  Checks documentation completeness and quality. Use when the user asks to
  "check documentation", "verify docs", "review JSDoc", or when the
  standards-enforcer agent needs documentation compliance guidance.
---

# Documentation Standards

<!-- EDUCATIONAL NOTE:
     This skill shows another pattern: documentation-focused validation.
     Like check-standards, it works both standalone and as agent reference.
-->

## Target

Check documentation standards for: $ARGUMENTS

## Required Documentation

### 1. JSDoc on Exported Functions
Every exported function must have a JSDoc comment with:
- **Description** — what the function does (one line)
- **@param** — for each parameter, with type and description
- **@returns** — what the function returns
- **@throws** — if the function can throw, document when and what
- **@example** — at least one usage example for public API functions

```typescript
// GOOD
/**
 * Retrieves a user by their unique identifier.
 *
 * @param userId - The UUID of the user to retrieve
 * @returns The user object if found
 * @throws {NotFoundError} When no user exists with the given ID
 * @example
 * const user = await getUserById("550e8400-e29b-41d4-a716-446655440000");
 */
export async function getUserById(userId: string): Promise<User> {

// BAD — missing JSDoc on exported function
export async function getUserById(userId: string): Promise<User> {
```

### 2. README in Module Directories
Each module directory (feature folder) must contain a README.md with:
- **Purpose** — what this module does (1-2 sentences)
- **Exports** — key exports and their purpose
- **Dependencies** — what this module depends on
- **Usage** — how to use this module from other parts of the codebase

### 3. Inline Comments
- **DO** comment non-obvious business logic ("Users in trial can't exceed 5 projects")
- **DO** comment workarounds ("Safari doesn't support ResizeObserver in iframes")
- **DON'T** comment obvious code (`// increment counter` before `counter++`)
- **DON'T** use comments as code deodorant — if code needs heavy commenting, refactor it

### 4. CHANGELOG Entries
For any user-facing change:
- Add an entry under the correct section: Added, Changed, Fixed, Removed
- Include the ticket/issue reference
- Write from the user's perspective, not the developer's

```markdown
## [Unreleased]
### Added
- User profile page with avatar upload (#142)
### Fixed
- Login timeout on slow connections (#156)
```

## Output Format

```
### Documentation Report: [target]

| Requirement | Status | Location | Details |
|-------------|--------|----------|---------|
| JSDoc on exports | PASS/FAIL | [file:line] | [missing params, etc.] |
| Module README | PASS/FAIL | [directory] | [missing or incomplete] |
| Inline comments | PASS/FAIL | [file:line] | [over/under commented] |
| CHANGELOG | PASS/FAIL | CHANGELOG.md | [missing entries] |

### Missing Documentation
- [List of specific items that need docs added]
```
