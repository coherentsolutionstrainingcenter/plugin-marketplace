# CCM Training Plugin Marketplace

A fully functional Claude Code plugin marketplace built for **educational purposes**. Contains four plugins that progressively demonstrate every plugin capability — skills, hooks, agents, and settings — from simple to comprehensive.

Use this marketplace to **learn**, **study**, and **practice** building Claude Code plugins, then use it as a template for your own team or company marketplace.

---

## What is a Plugin Marketplace?

A **plugin marketplace** is a Git repository that acts as a catalog of Claude Code plugins. Think of it like an app store for Claude Code extensions:

- **Plugins** add capabilities: skills (slash commands), hooks (automated guardrails), agents (sub-process specialists), and MCP servers (external tool integrations)
- **Marketplaces** bundle plugins together for easy discovery and installation
- **Teams and companies** create private marketplaces to share standardized workflows, coding conventions, safety guardrails, and tooling across all projects

```
┌─────────────────────────────────────────────────────────────┐
│                    Plugin Marketplace                        │
│                  (Git Repository)                            │
│                                                             │
│  marketplace.json ─── catalog of all available plugins      │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ Plugin A  │  │ Plugin B  │  │ Plugin C  │  │ Plugin D  │  │
│  │ (skills)  │  │ (hooks)   │  │ (agents)  │  │  (all)    │  │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
            claude plugin marketplace add <source>
            claude plugin install <name>@<marketplace>
                          │
                          ▼
              Plugins installed to ~/.claude/plugins/
              Available in every Claude Code session
```

## Why Teams Need Plugin Marketplaces

| Problem | Marketplace Solution |
|---------|---------------------|
| New hires don't know team conventions | Install the `team-standards` plugin — it enforces them automatically |
| Developers accidentally run destructive git commands | Install the `git-guardian` plugin — hooks block dangerous operations |
| Every project starts from scratch | Install the `project-bootstrap` plugin — consistent scaffolding |
| Best practices live in wikis nobody reads | Encode them as skills and hooks — they're active, not passive |
| Each developer configures tools differently | One marketplace, same plugins, consistent experience |

**The key insight:** A marketplace turns your team's knowledge from documentation people *might* read into automation that *actively works* in every coding session.

---

## Quick Start

### Option 1: Install from GitHub (Recommended)

```bash
# Add the marketplace (do this once)
claude plugin marketplace add YOUR_ORG/plugin-marketplace

# Install individual plugins
claude plugin install code-quality@ccm-training-marketplace
claude plugin install git-guardian@ccm-training-marketplace
claude plugin install team-standards@ccm-training-marketplace
claude plugin install project-bootstrap@ccm-training-marketplace
```

### Option 2: Install from Local Directory

```bash
# Clone the repository
git clone https://github.com/YOUR_ORG/plugin-marketplace.git

# Add as a local marketplace
claude plugin marketplace add ./plugin-marketplace

# Install plugins
claude plugin install code-quality@ccm-training-marketplace
```

### Option 3: Test a Single Plugin (Development)

```bash
# Test one plugin without registering the marketplace
claude --plugin-dir ./plugin-marketplace/plugins/code-quality
```

### Verify Installation

```bash
# List registered marketplaces
claude plugin marketplace list

# Check installed plugins (inside Claude Code)
/reload-plugins
```

---

## Available Plugins

| # | Plugin | Focus | Skills | Hooks | Agents | Settings |
|---|--------|-------|--------|-------|--------|----------|
| 1 | **[code-quality](plugins/code-quality/)** | Skills | 3 | - | - | - |
| 2 | **[git-guardian](plugins/git-guardian/)** | Hooks | 1 | 2 | - | - |
| 3 | **[team-standards](plugins/team-standards/)** | Agents | 2 | - | 1 | 1 |
| 4 | **[project-bootstrap](plugins/project-bootstrap/)** | All Combined | 2 | 1 | 1 | 1 |

---

## Learning Path

Study the plugins in this order — each one builds on concepts from the previous:

### 1. Start with Skills: `code-quality`

**What you'll learn:**
- SKILL.md file format with YAML frontmatter
- `$ARGUMENTS` for capturing user input
- Multiple skills in a single plugin
- Skills are namespaced: `/plugin-name:skill-name`

**Try it:**
```
/code-quality:code-review src/some-file.ts
/code-quality:refactor-suggest src/some-module/
/code-quality:naming-conventions typescript src/
```

**Key file to study:** `plugins/code-quality/skills/code-review/SKILL.md`

---

### 2. Add Hooks: `git-guardian`

**What you'll learn:**
- `hooks.json` format and hook types (PreToolUse, PostToolUse)
- `matcher` regex patterns for filtering tool events
- Blocking decisions (PreToolUse) vs system messages (PostToolUse)
- `${CLAUDE_PLUGIN_ROOT}` for portable script paths
- stdin/stdout JSON protocol for hook scripts
- How hooks and skills complement each other

**Try it:**
```
# The hooks activate automatically — try asking Claude to:
# "Run git reset --hard" → hook blocks it
# Write any file → hook logs it

# The skill is available on demand:
/git-guardian:git-safety
```

**Key file to study:** `plugins/git-guardian/hooks/hooks.json` and `hooks/pre-git-check.sh`

---

### 3. Add Agents: `team-standards`

**What you'll learn:**
- Agent `.md` file format with frontmatter (name, description, tools)
- Description with `<example>` blocks showing Claude when to invoke
- Tool restrictions (agents can only use listed tools)
- How agents reference skills as knowledge bases
- `settings.json` as plugin configuration
- Dual-purpose skills (standalone + agent reference)

**Try it:**
```
# Invoke skills directly:
/team-standards:check-standards src/
/team-standards:check-docs src/

# Or let Claude invoke the agent:
"Check if my code meets our team standards"
```

**Key file to study:** `plugins/team-standards/agents/standards-enforcer.md`

---

### 4. Combine Everything: `project-bootstrap`

**What you'll learn:**
- How skills, hooks, agents, and settings work together
- Agent-driven orchestration (wizard asks questions, creates files)
- Hook-based workflow chaining (scaffold → validate)
- Settings as centralized configuration for the entire flow

**Try it:**
```
# Direct scaffolding:
/project-bootstrap:scaffold-project node-api my-api

# Guided setup (agent):
"Help me set up a new React project"

# Validation:
/project-bootstrap:validate-structure ./my-api
```

**Key file to study:** `plugins/project-bootstrap/README.md` (workflow diagram)

---

## Plugin Anatomy

Every plugin follows this structure:

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json              # REQUIRED: Plugin manifest
│                                # { "name", "description", "version", "author" }
│
├── skills/                       # OPTIONAL: Slash command skills
│   └── my-skill/
│       └── SKILL.md             # Frontmatter (name, description) + instructions
│                                # Invoked as: /plugin-name:my-skill [args]
│
├── agents/                       # OPTIONAL: Sub-agent definitions
│   └── my-agent.md             # Frontmatter (name, description, tools) + prompt
│                                # Spawned as separate sub-process
│
├── hooks/                        # OPTIONAL: Event-driven automation
│   ├── hooks.json               # Hook definitions (PreToolUse, PostToolUse, etc.)
│   └── my-hook.sh               # Script that runs on hook events
│                                # Receives JSON stdin, outputs JSON stdout
│
├── settings.json                 # OPTIONAL: Default configuration
│                                # Read by skills/agents for customizable behavior
│
├── .mcp.json                     # OPTIONAL: MCP server configurations
│
└── README.md                     # Documentation
```

### File Formats at a Glance

**plugin.json** (required):
```json
{
  "name": "my-plugin",
  "description": "What this plugin does",
  "version": "1.0.0",
  "author": { "name": "Your Name" }
}
```

**SKILL.md**:
```markdown
---
name: my-skill
description: When to use this skill (Claude reads this to decide)
---

Instructions for Claude when this skill is invoked.
Use $ARGUMENTS to access user input after the skill name.
```

**Agent .md**:
```markdown
---
name: my-agent
description: |
  When to use this agent (with examples)
tools:
  - Read
  - Grep
---

System prompt defining the agent's behavior and workflow.
```

**hooks.json**:
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/my-hook.sh\""
      }]
    }]
  }
}
```

---

## How to Create Your Own Plugin

### Step 1: Create the Directory Structure

```bash
mkdir -p my-plugin/.claude-plugin my-plugin/skills/my-skill
```

### Step 2: Write the Manifest

Create `.claude-plugin/plugin.json`:
```json
{
  "name": "my-plugin",
  "description": "What your plugin does",
  "version": "1.0.0",
  "author": { "name": "Your Name" }
}
```

### Step 3: Add a Skill

Create `skills/my-skill/SKILL.md`:
```markdown
---
name: my-skill
description: Describe when Claude should use this skill
---

Your skill instructions here. Use $ARGUMENTS for user input.
```

### Step 4: Test Locally

```bash
claude --plugin-dir ./my-plugin
# Then in Claude Code:
/my-plugin:my-skill hello world
```

### Step 5: Validate

```bash
claude plugin validate ./my-plugin
```

### Step 6: Add to a Marketplace

Add your plugin to a marketplace's `marketplace.json`:
```json
{
  "plugins": [
    {
      "name": "my-plugin",
      "source": "./plugins/my-plugin",
      "description": "What it does"
    }
  ]
}
```

---

## How to Create Your Own Marketplace

### Step 1: Create the Repository

```bash
mkdir my-marketplace
cd my-marketplace
git init
mkdir -p .claude-plugin plugins
```

### Step 2: Write the Marketplace Manifest

Create `.claude-plugin/marketplace.json`:
```json
{
  "name": "my-company-marketplace",
  "owner": {
    "name": "My Company"
  },
  "plugins": [
    {
      "name": "my-plugin",
      "source": "./plugins/my-plugin",
      "description": "What it does"
    }
  ]
}
```

### Step 3: Add Plugins

Copy or create plugins in the `plugins/` directory.

### Step 4: Push to Git

```bash
git add -A
git commit -m "Initial marketplace with plugins"
git remote add origin https://github.com/your-org/my-marketplace.git
git push -u origin main
```

### Step 5: Share with Your Team

```bash
# Team members run:
claude plugin marketplace add your-org/my-marketplace
claude plugin install my-plugin@my-company-marketplace
```

### Step 6: Project-Level Auto-Install (Optional)

Add to your project's `.claude/settings.json` so plugins install automatically:
```json
{
  "extraKnownMarketplaces": {
    "my-company-marketplace": {
      "source": {
        "source": "github",
        "repo": "your-org/my-marketplace"
      }
    }
  },
  "enabledPlugins": {
    "my-plugin@my-company-marketplace": true
  }
}
```

---

## Command Reference

| Command | Description |
|---------|-------------|
| `claude plugin marketplace add <source>` | Register a marketplace |
| `claude plugin marketplace list` | List registered marketplaces |
| `claude plugin marketplace remove <name>` | Remove a marketplace |
| `claude plugin marketplace update [name]` | Update marketplace(s) |
| `claude plugin install <plugin>@<marketplace>` | Install a plugin |
| `claude plugin validate <path>` | Validate plugin structure |
| `claude --plugin-dir <path>` | Test a plugin locally |
| `/reload-plugins` | Reload plugins in active session |

---

## Marketplace Structure

```
plugin-marketplace/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace catalog
├── plugins/
│   ├── code-quality/             # Plugin 1: Skills
│   ├── git-guardian/             # Plugin 2: Hooks
│   ├── team-standards/           # Plugin 3: Agents
│   └── project-bootstrap/       # Plugin 4: Combined
├── README.md                     # This file
└── changelog.md                  # Version history
```

---

## License

MIT — use this as a template for your own team's marketplace.
