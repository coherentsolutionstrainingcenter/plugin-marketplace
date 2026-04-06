---
name: scaffold-project
description: >
  Creates a new project from templates. Use when the user asks to "create a
  new project", "scaffold a project", "bootstrap a project", "initialize a
  project", or "set up a new app".
---

# Project Scaffolding

<!-- EDUCATIONAL NOTE:
     This skill demonstrates:
     1. Complex $ARGUMENTS parsing — project-type + project-name
     2. Template-based file generation — structured project creation
     3. Settings.json integration — reads defaults from plugin config
     4. Used both standalone AND by the setup-wizard agent
-->

## Target

Create project: $ARGUMENTS

<!-- Argument parsing:
     /project-bootstrap:scaffold-project node-api my-awesome-api
     First argument = project type, second = project name
     If only one argument, treat as project name and ask for type.
-->

Parse $ARGUMENTS:
- If two arguments: first = project type, second = project name
- If one argument: treat as project name, ask for project type
- If no arguments: ask for both

## Available Project Types

Read `settings.json` for default tooling per project type.

### node-api — Node.js REST API

Create this structure:
```
{project-name}/
├── src/
│   ├── index.ts              # Entry point with server setup
│   ├── routes/
│   │   └── health.ts         # Health check endpoint
│   ├── middleware/
│   │   └── error-handler.ts  # Global error handler
│   └── types/
│       └── index.ts          # Shared type definitions
├── tests/
│   └── health.test.ts        # Example test
├── .github/
│   └── workflows/
│       └── ci.yml            # CI pipeline
├── package.json              # Dependencies and scripts
├── tsconfig.json             # TypeScript configuration
├── .eslintrc.json            # Linter config
├── .prettierrc               # Formatter config
├── .gitignore                # Git ignores
├── Dockerfile                # Container build
├── README.md                 # Project documentation
└── LICENSE                   # MIT license
```

### react-app — React Frontend

Create this structure:
```
{project-name}/
├── src/
│   ├── main.tsx              # Entry point
│   ├── App.tsx               # Root component
│   ├── components/           # Shared components
│   ├── pages/                # Route pages
│   ├── hooks/                # Custom hooks
│   └── types/                # Type definitions
├── tests/
│   └── App.test.tsx          # Example test
├── public/
│   └── index.html            # HTML template
├── package.json
├── tsconfig.json
├── vite.config.ts
├── .gitignore
├── README.md
└── LICENSE
```

### python-cli — Python CLI Tool

Create this structure:
```
{project-name}/
├── src/
│   └── {project_name}/       # Package directory (underscores)
│       ├── __init__.py
│       ├── __main__.py       # CLI entry point
│       ├── cli.py            # Click/Typer command definitions
│       └── core.py           # Business logic
├── tests/
│   ├── __init__.py
│   └── test_core.py          # Example test
├── pyproject.toml            # Project metadata and dependencies
├── .github/
│   └── workflows/
│       └── ci.yml            # CI pipeline
├── .gitignore
├── README.md
└── LICENSE
```

## File Content Templates

For each file, generate appropriate starter content:
- **package.json / pyproject.toml**: name, version 0.1.0, scripts, dependencies
- **README.md**: project name, description placeholder, setup instructions, usage
- **.gitignore**: language-appropriate ignores (node_modules, __pycache__, .env, etc.)
- **CI workflow**: install, lint, test steps
- **Source files**: minimal working code with one example endpoint/command
- **Test files**: one passing test that validates the example

## After Scaffolding
Inform the user of next steps (install dependencies, run tests, start development).
