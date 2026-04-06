---
name: git-safety
description: >
  Provides guidelines for safe git usage. Use when the user asks about
  "git safety", "safe git practices", "git best practices", or before
  performing git operations that could be destructive.
---

# Git Safety Guidelines

<!-- EDUCATIONAL NOTE:
     This skill complements the hooks in this plugin:
     - The hooks ENFORCE safety by blocking dangerous commands
     - This skill EDUCATES by providing guidelines when asked
     Together they show how hooks and skills serve different purposes:
     hooks = automated guardrails, skills = on-demand guidance
-->

## Core Principles

### 1. Never Force-Push to Shared Branches
- `git push --force` overwrites remote history and can destroy teammates' work
- If you must force-push, use `--force-with-lease` which checks that no one else pushed
- Better yet: avoid rewriting history on branches others have pulled

### 2. Use Feature Branches
- Never commit directly to `main` or `master`
- Create descriptive branch names: `feature/add-user-auth`, `fix/login-timeout`
- Keep branches short-lived — merge frequently to avoid drift

### 3. Commit Atomically
- Each commit should represent one logical change
- Don't mix refactoring with feature work in the same commit
- Write commit messages that explain **why**, not just **what**

### 4. Review Before Destructive Operations
Before running any of these, verify you won't lose work:
- `git reset --hard` — check `git stash list` and `git status` first
- `git clean -f` — run `git clean -n` (dry run) first
- `git branch -D` — check if the branch has unmerged commits with `git log`
- `git checkout .` — check `git diff` to see what you'd lose

### 5. Use Stash Instead of Discard
- Instead of `git checkout .` to clear changes, use `git stash`
- Stashed changes can be recovered; discarded changes cannot
- Name your stashes: `git stash push -m "WIP: auth refactor"`

### 6. Commit Message Conventions
```
<type>(<scope>): <short description>

<body - explain WHY, not WHAT>

<footer - references, breaking changes>
```

Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`

Example:
```
feat(auth): add JWT token refresh endpoint

Users were getting logged out after 1 hour because tokens expired
with no refresh mechanism. This adds a /auth/refresh endpoint that
issues new tokens before expiry.

Closes #142
```

## Emergency Recovery

If something goes wrong:
1. **Lost commits:** `git reflog` shows all recent HEAD movements — you can recover from there
2. **Bad merge:** `git merge --abort` or `git reset --merge`
3. **Bad rebase:** `git rebase --abort` (during rebase) or `git reflog` (after)
4. **Accidentally deleted branch:** `git reflog` to find the commit, then `git branch <name> <sha>`
