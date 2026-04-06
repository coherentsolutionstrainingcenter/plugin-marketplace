# Team Standards Plugin

> **Learning Focus:** Agents — how to create custom sub-agents that delegate complex reviews, backed by skills as knowledge bases and settings as configuration.

## What This Plugin Teaches

This plugin demonstrates **agents**, the most powerful orchestration mechanism in Claude Code plugins. Agents are spawned sub-processes with their own context, tool access, and behavior — they delegate complex multi-step workflows.

| Concept | Where to Look |
|---------|--------------|
| Agent .md frontmatter | `agents/standards-enforcer.md` — name, description, tools |
| Description with examples | `agents/standards-enforcer.md` — shows Claude WHEN to invoke |
| Tool restrictions | `agents/standards-enforcer.md` — `tools: [Read, Grep, Glob]` |
| Agent + skill composition | Agent references `check-standards` and `check-docs` skills |
| settings.json configuration | `settings.json` — team-customizable rules |
| Dual-purpose skills | Skills work standalone AND as agent knowledge bases |

## How Agents Work

```
User: "Check if my code meets our standards"
  │
  ▼
Claude recognizes the intent matches
the standards-enforcer agent description
  │
  ▼
┌─────────────────────────────────────┐
│ Standards Enforcer Agent spawned    │
│                                     │
│ Has access to: Read, Grep, Glob    │
│ (cannot Write, Edit, or Bash)      │
│                                     │
│ 1. Reads settings.json for config  │
│ 2. Applies check-standards rules   │
│ 3. Applies check-docs rules        │
│ 4. Produces compliance report      │
└─────────────────────────────────────┘
  │
  ▼
Report returned to main Claude session
and presented to the user
```

## Agents vs Skills

| Aspect | Skills | Agents |
|--------|--------|--------|
| Execution | Injected as context into main session | Spawned as separate sub-process |
| Context | Shares main session context | Has its own isolated context |
| Complexity | Single-shot guidance | Multi-step workflows |
| Tool access | Uses main session's tools | Restricted to declared tools only |
| Best for | Templates, checklists, guidelines | Reviews, analysis, orchestration |

## Skills Included

### `/team-standards:check-standards [target]`
TypeScript/JavaScript coding conventions: type safety, naming, structure, error handling.

### `/team-standards:check-docs [target]`
Documentation requirements: JSDoc, module READMEs, inline comments, CHANGELOG.

Both skills work standalone via slash commands AND as knowledge bases for the agent.

## Customizing for Your Team

Fork this plugin and edit `settings.json` to match your team's conventions:

```json
{
  "team_name": "Your Team Name",
  "code_rules": {
    "max_function_length": 50,
    "forbid_any_type": false
  }
}
```

## Plugin Structure

```
team-standards/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── agents/
│   └── standards-enforcer.md    # Custom sub-agent definition
├── skills/
│   ├── check-standards/
│   │   └── SKILL.md             # Coding convention rules
│   └── check-docs/
│       └── SKILL.md             # Documentation requirements
├── settings.json                # Configurable team rules
└── README.md                    # This file
```

## Key Takeaways

1. **Agents are .md files** in the `agents/` directory with YAML frontmatter
2. **Description examples** tell Claude exactly when to invoke the agent
3. **Tool restrictions** limit what the agent can do (security + focus)
4. **Agents reference skills** as knowledge bases for their domain
5. **settings.json** makes plugins configurable without modifying skill logic
6. **Skills serve dual purposes** — direct user access AND agent reference material
