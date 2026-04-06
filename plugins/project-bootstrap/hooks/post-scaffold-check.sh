#!/usr/bin/env bash
# =============================================================================
# Project Bootstrap — PostToolUse Hook: Scaffold Completion Reminder
# =============================================================================
#
# EDUCATIONAL NOTES:
#
# This hook demonstrates a lightweight PostToolUse pattern:
# it watches for project manifest files being created (package.json,
# pyproject.toml) and reminds Claude to run validation afterward.
#
# This shows how hooks can create workflow connections — when one action
# (scaffolding) completes, the hook nudges toward the next action
# (validation), creating an automated workflow chain.
#
# Key concepts:
#   1. File-type detection in PostToolUse hooks
#   2. systemMessage as workflow glue between skills
#   3. Lightweight pattern — just a reminder, not enforcement
# =============================================================================

# Read stdin (PostToolUse JSON)
INPUT=$(cat)

# Extract the file path
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//')

# If no file path, skip
if [ -z "$FILE_PATH" ]; then
  echo '{}'
  exit 0
fi

# Extract the filename
FILENAME=$(basename "$FILE_PATH")

# Check if this is a project manifest file (indicates project scaffolding)
case "$FILENAME" in
  package.json|pyproject.toml|pom.xml|build.gradle|Cargo.toml|go.mod)
    # This looks like a project was just scaffolded — remind to validate
    cat << REMIND_JSON
{
  "systemMessage": "Project Bootstrap: A project manifest (${FILENAME}) was just created. Consider running the validate-structure skill to verify the project has all required files: /project-bootstrap:validate-structure $(dirname "$FILE_PATH")"
}
REMIND_JSON
    ;;
  *)
    # Not a manifest file — no action needed
    echo '{}'
    ;;
esac

exit 0
