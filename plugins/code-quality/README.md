# Code Quality Plugin

> **Learning Focus:** Skills — how to create multiple skills in a single plugin, use `$ARGUMENTS` for user input, and write structured skill instructions.

## What This Plugin Teaches

This plugin contains **three skills** that demonstrate the core building block of Claude Code plugins: the **SKILL.md** file.

| Concept | Where to Look |
|---------|--------------|
| SKILL.md frontmatter format | Any `SKILL.md` — the YAML block between `---` markers |
| `$ARGUMENTS` for user input | `code-review/SKILL.md` — captures file paths from user |
| Multi-argument parsing | `naming-conventions/SKILL.md` — parses language + path |
| Structured output format | `refactor-suggest/SKILL.md` — before/after template |
| Educational comments | All skills use `<!-- -->` HTML comments for teaching |

## Skills Included

### `/code-quality:code-review [target]`
Performs a structured code review with severity ratings (CRITICAL/WARNING/INFO) across five categories: correctness, security, performance, maintainability, and error handling.

```
/code-quality:code-review src/auth/login.ts
```

### `/code-quality:refactor-suggest [target]`
Identifies code smells and suggests refactoring patterns with before/after examples. Analysis-only — doesn't make changes.

```
/code-quality:refactor-suggest src/services/UserService.ts
```

### `/code-quality:naming-conventions [language] [target]`
Checks naming conventions against language-specific rules. Auto-detects language or accepts it as the first argument.

```
/code-quality:naming-conventions typescript src/
/code-quality:naming-conventions src/utils/    # auto-detects language
```

## Plugin Structure

```
code-quality/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (name, version, author)
├── skills/
│   ├── code-review/
│   │   └── SKILL.md         # Skill 1: structured code review
│   ├── refactor-suggest/
│   │   └── SKILL.md         # Skill 2: refactoring suggestions
│   └── naming-conventions/
│       └── SKILL.md         # Skill 3: naming convention checks
└── README.md                # This file
```

## Key Takeaways

1. **Skills are Markdown files** — SKILL.md with YAML frontmatter
2. **`$ARGUMENTS`** is replaced with whatever the user types after the skill name
3. **Description field** in frontmatter tells Claude WHEN to invoke the skill
4. **Multiple skills** in one plugin are namespaced: `/plugin-name:skill-name`
5. **Skills guide Claude's behavior** — they are injected as instructions, not executed as code
