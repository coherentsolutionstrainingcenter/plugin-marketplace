---
name: naming-conventions
description: >
  Validates naming conventions across a codebase. Use when the user asks to
  "check naming", "review variable names", "enforce naming conventions",
  "fix naming", or discusses naming standards.
---

# Naming Convention Check

<!-- EDUCATIONAL NOTE:
     This skill demonstrates:
     1. Multi-argument parsing — $ARGUMENTS can contain multiple values
     2. Language-aware behavior — skill adapts based on detected/specified language
     3. Grep-based analysis — uses codebase search to find violations
-->

## Target

Check naming conventions for: $ARGUMENTS

<!-- Multi-argument example:
     /code-quality:naming-conventions typescript src/services/
     $ARGUMENTS becomes: "typescript src/services/"
     Parse the first word as language hint, rest as target path.
     If only one argument, treat it as the target and auto-detect language.
-->

Parse $ARGUMENTS:
- If two arguments: first = language, second = file/directory path
- If one argument: treat as path, detect language from file extensions
- If no arguments: ask the user for a target

## Language-Specific Rules

### JavaScript / TypeScript
| Element | Convention | Example |
|---------|-----------|---------|
| Variables | camelCase | `userName`, `isActive` |
| Functions | camelCase | `getUserById`, `validateInput` |
| Classes | PascalCase | `UserService`, `HttpClient` |
| Interfaces | PascalCase (no I prefix) | `UserProfile`, `ApiResponse` |
| Type aliases | PascalCase | `UserId`, `ConfigOptions` |
| Enums | PascalCase | `UserRole`, `HttpStatus` |
| Enum members | PascalCase | `UserRole.Admin`, `HttpStatus.NotFound` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRIES`, `API_BASE_URL` |
| Files (components) | PascalCase | `UserProfile.tsx` |
| Files (utilities) | kebab-case | `string-utils.ts` |
| Private fields | prefix with `_` or `#` | `_cache`, `#internal` |

### Python
| Element | Convention | Example |
|---------|-----------|---------|
| Variables | snake_case | `user_name`, `is_active` |
| Functions | snake_case | `get_user_by_id`, `validate_input` |
| Classes | PascalCase | `UserService`, `HttpClient` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRIES`, `API_BASE_URL` |
| Modules | snake_case | `user_service.py` |
| Private | prefix with `_` | `_internal_cache` |
| Dunder | double underscore | `__init__`, `__repr__` |

### Java
| Element | Convention | Example |
|---------|-----------|---------|
| Variables | camelCase | `userName`, `isActive` |
| Methods | camelCase | `getUserById`, `validateInput` |
| Classes | PascalCase | `UserService`, `HttpClient` |
| Interfaces | PascalCase | `Serializable`, `Comparable` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRIES`, `API_BASE_URL` |
| Packages | lowercase | `com.example.userservice` |
| Enums | PascalCase | `UserRole` |
| Enum values | UPPER_SNAKE_CASE | `ADMIN`, `READ_ONLY` |

## Universal Rules (All Languages)
- No single-letter names except loop iterators (`i`, `j`, `k`)
- No abbreviations unless universally known (`id`, `url`, `api`, `http`)
- Boolean variables/functions should use `is`, `has`, `should`, `can` prefix
- Collection variables should be plural (`users`, `items`, `responses`)
- Functions should start with a verb (`get`, `set`, `create`, `delete`, `validate`)
- Avoid generic names (`data`, `info`, `temp`, `stuff`, `result`)

## Output Format

```
## Naming Convention Report: [target]

**Language:** [detected or specified]
**Files scanned:** [count]

### Violations

| Location | Current Name | Issue | Suggested Name |
|----------|-------------|-------|---------------|
| file:line | badName | [rule violated] | goodName |

### Summary
- X violations found across Y files
- Most common issue: [pattern]
```
