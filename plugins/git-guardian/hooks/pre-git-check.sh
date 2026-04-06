#!/usr/bin/env bash
# =============================================================================
# Git Guardian — PreToolUse Hook: Destructive Git Operation Check
# =============================================================================
#
# EDUCATIONAL NOTES:
#
# This script runs BEFORE the Bash tool executes a command.
# It receives JSON on stdin with the tool input:
#   { "tool_name": "Bash", "tool_input": { "command": "git reset --hard" } }
#
# To BLOCK the command, output JSON with a "decision" field:
#   { "decision": "block", "reason": "Explanation shown to Claude" }
#
# To ALLOW the command, output empty JSON or nothing:
#   {}
#
# Key concepts demonstrated:
#   1. Reading tool input from stdin as JSON
#   2. Pattern matching against dangerous commands
#   3. Returning block/allow decisions as JSON
#   4. Using basic bash (no jq dependency) for portability
# =============================================================================

# Read the entire stdin into a variable
# The hook receives the full tool invocation context as JSON
INPUT=$(cat)

# Extract the command field from the JSON
# We use grep + sed instead of jq to avoid external dependencies
# In production, consider using Python or jq for robust JSON parsing
COMMAND=$(echo "$INPUT" | grep -o '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"command"[[:space:]]*:[[:space:]]*"//;s/"$//')

# If we couldn't extract a command, allow it (not a Bash tool call we care about)
if [ -z "$COMMAND" ]; then
  echo '{}'
  exit 0
fi

# Define destructive git patterns to block
# Each pattern is a common dangerous git operation
DANGEROUS_PATTERNS=(
  "git reset --hard"        # Discards all uncommitted changes permanently
  "git push --force "       # Overwrites remote history (can lose others' work)
  "git push -f "            # Short form of --force
  "git clean -f"            # Deletes untracked files permanently
  "git checkout \."         # Discards all working directory changes
  "git branch -D "          # Force-deletes a branch even if unmerged
  "git stash drop"          # Permanently deletes a stash entry
  "git rebase.*--force"     # Force rebase that may rewrite shared history
)

# Check the command against each dangerous pattern
for PATTERN in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qi "$PATTERN"; then
    # Output a block decision — Claude will see this reason
    # and can explain to the user why the operation was prevented
    cat << BLOCK_JSON
{
  "decision": "block",
  "reason": "Git Guardian BLOCKED a potentially destructive operation: '${COMMAND}'. This command can cause irreversible data loss. If you need to proceed, ask the user to run it manually with: ! ${COMMAND}"
}
BLOCK_JSON
    exit 0
  fi
done

# No dangerous patterns found — allow the command
echo '{}'
exit 0
