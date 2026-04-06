# Project Bootstrap Plugin

> **Learning Focus:** Combined — how skills, hooks, agents, and settings work together as a unified workflow. This is the "capstone" plugin.

## What This Plugin Teaches

This plugin combines **all four plugin capabilities** into a single cohesive workflow, demonstrating how the pieces fit together to create powerful automated experiences.

| Capability | Component | Purpose |
|-----------|-----------|---------|
| **Agent** | `setup-wizard` | Interactive project configuration |
| **Skill** | `scaffold-project` | Template-based file generation |
| **Skill** | `validate-structure` | Post-creation verification |
| **Hook** | PostToolUse on Write | Workflow connection (scaffold → validate) |
| **Settings** | `settings.json` | Default templates and configuration |

## The Workflow

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│  User: "Help me create a new Node.js API"               │
│                                                         │
│  ┌─────────────────────────────────┐                    │
│  │ 1. AGENT: setup-wizard          │                    │
│  │    Asks questions, gathers      │                    │
│  │    requirements interactively   │                    │
│  │                                 │                    │
│  │    Reads SETTINGS for defaults  │──── settings.json  │
│  │                                 │                    │
│  │    Uses SKILL: scaffold-project │                    │
│  │    to create files              │                    │
│  └────────────┬────────────────────┘                    │
│               │                                         │
│               ▼                                         │
│  ┌─────────────────────────────────┐                    │
│  │ 2. HOOK: PostToolUse            │                    │
│  │    Detects package.json created │                    │
│  │    Injects systemMessage:       │                    │
│  │    "Run validate-structure"     │                    │
│  └────────────┬────────────────────┘                    │
│               │                                         │
│               ▼                                         │
│  ┌─────────────────────────────────┐                    │
│  │ 3. SKILL: validate-structure    │                    │
│  │    Checks all required files    │                    │
│  │    Reports completeness score   │                    │
│  └─────────────────────────────────┘                    │
│                                                         │
│  Result: Complete, validated project                    │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## How Each Piece Connects

1. **Agent starts the flow** — The setup-wizard handles the interactive Q&A, reading settings.json for defaults. It has Write + Bash tools so it can actually create files.

2. **Agent uses skill** — The agent references the scaffold-project skill for template definitions, ensuring consistent project structures.

3. **Hook bridges the gap** — When the Write tool creates package.json (or pyproject.toml), the PostToolUse hook fires and injects a systemMessage reminding Claude to validate.

4. **Second skill finishes** — The validate-structure skill runs to verify everything was created correctly, producing a completeness report.

5. **Settings configure everything** — Default templates, tooling choices, and file lists all come from settings.json, making the whole flow customizable.

## Skills Included

### `/project-bootstrap:scaffold-project [type] [name]`
Creates a new project from templates. Supports node-api, react-app, and python-cli.

```
/project-bootstrap:scaffold-project node-api my-api
/project-bootstrap:scaffold-project react-app my-frontend
/project-bootstrap:scaffold-project python-cli my-tool
```

### `/project-bootstrap:validate-structure [path]`
Validates that a project directory has all required and recommended files.

```
/project-bootstrap:validate-structure ./my-api
```

## Plugin Structure

```
project-bootstrap/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── agents/
│   └── setup-wizard.md          # Interactive setup agent
├── skills/
│   ├── scaffold-project/
│   │   └── SKILL.md             # Project creation templates
│   └── validate-structure/
│       └── SKILL.md             # Post-creation validation
├── hooks/
│   ├── hooks.json               # PostToolUse hook definition
│   └── post-scaffold-check.sh   # Detects manifest creation
├── settings.json                # Default templates and config
└── README.md                    # This file
```

## Key Takeaways

1. **Agents orchestrate** — they drive multi-step workflows interactively
2. **Skills provide knowledge** — templates, rules, and checklists that agents reference
3. **Hooks automate transitions** — they bridge gaps between steps without manual intervention
4. **Settings centralize configuration** — one file to customize the entire workflow
5. **The combination is greater than the parts** — individually each feature is useful, together they create a seamless experience
