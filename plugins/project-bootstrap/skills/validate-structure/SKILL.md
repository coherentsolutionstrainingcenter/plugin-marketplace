---
name: validate-structure
description: >
  Validates that a scaffolded project has all required files and correct
  structure. Use when the user asks to "validate project structure",
  "check project setup", "verify scaffolding", or after creating a project.
---

# Project Structure Validation

<!-- EDUCATIONAL NOTE:
     This skill demonstrates:
     1. Post-action validation — checking results of another operation
     2. Glob-based file detection — using file patterns to verify presence
     3. Skill chaining — often called after scaffold-project
-->

## Target

Validate project structure at: $ARGUMENTS

If no path is provided, validate the current working directory.

## Validation Checklist

Use Glob and Read to check for each item. Report presence and quality.

### Required Files (all project types)
- [ ] `README.md` — exists and has content (not just a title)
- [ ] `.gitignore` — exists and has language-appropriate patterns
- [ ] `LICENSE` — exists (MIT, Apache-2.0, or other)
- [ ] Source directory (`src/`) — exists with at least one source file
- [ ] Test directory (`tests/` or `test/`) — exists with at least one test file
- [ ] Package manifest (`package.json`, `pyproject.toml`, `pom.xml`, etc.)

### Recommended Files
- [ ] CI/CD configuration (`.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`)
- [ ] Linter configuration (`.eslintrc*`, `ruff.toml`, `.pylintrc`)
- [ ] Formatter configuration (`.prettierrc`, `pyproject.toml [tool.black]`)
- [ ] Docker support (`Dockerfile`, `docker-compose.yml`)
- [ ] Environment template (`.env.example`)

### Structure Quality Checks
- [ ] Source files are not in the root directory (should be in `src/`)
- [ ] Test files mirror source structure
- [ ] No secrets or credentials in tracked files
- [ ] Package manifest has a `test` script/command defined
- [ ] .gitignore covers environment files (`.env`), dependencies, and build output

## Output Format

```
## Project Validation: [project-name]

### Required Files
| File | Status | Notes |
|------|--------|-------|
| README.md | PRESENT/MISSING | [quality note] |
| .gitignore | PRESENT/MISSING | [patterns found] |
| LICENSE | PRESENT/MISSING | [license type] |
| src/ | PRESENT/MISSING | [file count] |
| tests/ | PRESENT/MISSING | [file count] |
| manifest | PRESENT/MISSING | [type: package.json, etc.] |

### Recommended Files
| File | Status |
|------|--------|
| CI/CD config | PRESENT/MISSING |
| Linter config | PRESENT/MISSING |
| Dockerfile | PRESENT/MISSING |

### Issues Found
- [List any problems detected]

### Score: X/Y required, Z/W recommended
```
