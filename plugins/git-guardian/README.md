# Git Guardian Plugin

> **Learning Focus:** Hooks — how to use `hooks.json` to intercept tool execution, block dangerous operations, and inject system messages.

## What This Plugin Teaches

This plugin demonstrates **hooks**, the most powerful automated mechanism in Claude Code plugins. Hooks run shell commands in response to tool events — they can block operations, log activity, and inject context.

| Concept | Where to Look |
|---------|--------------|
| hooks.json structure | `hooks/hooks.json` — defines when hooks fire |
| PreToolUse (blocking) | `hooks/pre-git-check.sh` — blocks destructive git commands |
| PostToolUse (logging) | `hooks/post-file-logger.sh` — logs file changes |
| `matcher` patterns | `hooks.json` — regex matching tool names |
| `${CLAUDE_PLUGIN_ROOT}` | `hooks.json` — portable path to plugin directory |
| stdin/stdout protocol | Both `.sh` files — JSON in, JSON out |
| Hooks + skills together | `skills/git-safety/` — complementary guidance skill |

## Hook Execution Flow

```
User asks Claude to run "git reset --hard"
  │
  ▼
Claude calls Bash tool with command
  │
  ▼
┌─────────────────────────────────┐
│ PreToolUse Hook fires           │
│ (matcher: "Bash")               │
│                                 │
│ pre-git-check.sh receives JSON: │
│ { "tool_input": {               │
│     "command": "git reset..."   │
│   }                             │
│ }                               │
│                                 │
│ Script checks for dangerous     │
│ patterns and outputs:           │
│ { "decision": "block",          │
│   "reason": "..." }             │
└─────────────────────────────────┘
  │
  ▼
Command is BLOCKED — Claude sees the reason
and explains to the user why it was prevented
```

```
Claude writes a file with Write tool
  │
  ▼
File is written successfully
  │
  ▼
┌─────────────────────────────────┐
│ PostToolUse Hook fires          │
│ (matcher: "Write|Edit")         │
│                                 │
│ post-file-logger.sh outputs:    │
│ { "systemMessage": "Git         │
│    Guardian: Write operation..." │
│ }                               │
└─────────────────────────────────┘
  │
  ▼
Claude sees the systemMessage
(user doesn't see it) and is
reminded to commit related changes
```

## Hook JSON Protocol

### PreToolUse Input (stdin)
```json
{
  "tool_name": "Bash",
  "tool_input": {
    "command": "git push --force origin main"
  }
}
```

### PreToolUse Output (stdout) — to block
```json
{
  "decision": "block",
  "reason": "Human-readable explanation of why this was blocked"
}
```

### PreToolUse Output (stdout) — to allow
```json
{}
```

### PostToolUse Input (stdin)
```json
{
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.ts",
    "content": "..."
  },
  "tool_output": "File created successfully..."
}
```

### PostToolUse Output (stdout) — system message
```json
{
  "systemMessage": "A note injected into Claude's context"
}
```

## Skills Included

### `/git-guardian:git-safety`
A complementary skill that provides git safety guidelines on demand. Demonstrates how hooks (automated enforcement) and skills (on-demand guidance) serve different purposes in the same plugin.

## Plugin Structure

```
git-guardian/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── hooks/
│   ├── hooks.json           # Hook definitions (PreToolUse + PostToolUse)
│   ├── pre-git-check.sh     # Blocks destructive git commands
│   └── post-file-logger.sh  # Logs file modifications
├── skills/
│   └── git-safety/
│       └── SKILL.md         # Git best practices guide
└── README.md                # This file
```

## Key Takeaways

1. **hooks.json** defines WHEN hooks fire (tool events + matcher patterns)
2. **PreToolUse** hooks can **block** operations by outputting `{"decision": "block"}`
3. **PostToolUse** hooks can inject **systemMessage** notes into Claude's context
4. **`matcher`** uses regex — `"Write|Edit"` matches either tool name
5. **`${CLAUDE_PLUGIN_ROOT}`** resolves to the plugin's installed location
6. **Scripts receive JSON on stdin** and output JSON on stdout
7. **Hooks and skills complement each other** — hooks automate, skills educate
