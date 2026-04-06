---
name: code-review
description: >
  Performs a structured code review. Use when the user asks to "review code",
  "check code quality", "find code issues", "audit this code", or requests
  a code review of any file, function, or module.
---

# Code Review

<!-- EDUCATIONAL NOTE:
     This skill demonstrates several key concepts:
     1. $ARGUMENTS — captures everything the user types after the skill name
     2. Structured output — guides Claude to produce consistent, scannable results
     3. Multi-category analysis — shows how to create comprehensive skill instructions
-->

## Target

Review the following: $ARGUMENTS

<!-- $ARGUMENTS captures user input after the skill name.
     Example: /code-quality:code-review src/auth/login.ts
     $ARGUMENTS becomes: "src/auth/login.ts"
-->

If no specific file or function is provided, ask the user what they'd like reviewed.

## Review Process

Read the target code, then analyze it against each category below. For each finding, assign a severity:

- **CRITICAL** — Bugs, security vulnerabilities, data loss risks
- **WARNING** — Performance issues, maintainability concerns, missing error handling
- **INFO** — Style suggestions, minor improvements, best practice recommendations

## Review Categories

### 1. Correctness
- Are there logic errors or off-by-one bugs?
- Are edge cases handled (null, empty, boundary values)?
- Do functions return the correct types?
- Are promises properly awaited?

### 2. Security
- Input validation: is user input sanitized before use?
- Injection risks: SQL injection, XSS, command injection?
- Authentication/authorization: are checks in place?
- Secrets: are API keys, passwords, or tokens hardcoded?

### 3. Performance
- N+1 query patterns in database access?
- Unnecessary allocations in loops?
- Missing pagination for list endpoints?
- Expensive operations that could be cached?

### 4. Maintainability
- Single Responsibility: does each function do one thing?
- DRY: is there duplicated logic that should be extracted?
- Naming: are variables and functions clearly named?
- Complexity: are there deeply nested conditionals (>3 levels)?

### 5. Error Handling
- Are errors caught and handled appropriately?
- Are error messages descriptive and actionable?
- Is there proper cleanup in error paths (finally blocks, resource disposal)?

## Output Format

Present findings as a structured report:

```
## Code Review: [file/function name]

### Summary
[1-2 sentence overview of code quality]

### Findings

#### CRITICAL
- [Finding with file:line reference and explanation]

#### WARNING
- [Finding with file:line reference and explanation]

#### INFO
- [Finding with file:line reference and explanation]

### Recommendations
[Top 3 prioritized action items]
```

If no issues are found in a category, skip it. Always end with actionable recommendations.
