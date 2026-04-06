#!/usr/bin/env bash
# =============================================================================
# Git Guardian — PostToolUse Hook: File Change Logger
# =============================================================================
#
# EDUCATIONAL NOTES:
#
# This script runs AFTER the Write or Edit tool completes.
# It receives JSON on stdin with the tool result:
#   {
#     "tool_name": "Write",
#     "tool_input": { "file_path": "/path/to/file.ts", "content": "..." },
#     "tool_output": "File created successfully..."
#   }
#
# PostToolUse hooks can output a "systemMessage" — a note injected into
# Claude's context that the user doesn't see but influences Claude's behavior:
#   { "systemMessage": "Reminder: commit related changes together" }
#
# Key concepts demonstrated:
#   1. PostToolUse hooks run after tool completion
#   2. systemMessage influences Claude without interrupting the user
#   3. Extracting file paths from tool input JSON
#   4. Lightweight logging pattern
# =============================================================================

# Read stdin
INPUT=$(cat)

# Extract the file path from tool_input
# Works for both Write (file_path) and Edit (file_path) tools
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//')

# If no file path found, skip silently
if [ -z "$FILE_PATH" ]; then
  echo '{}'
  exit 0
fi

# Extract just the filename for a cleaner message
FILENAME=$(basename "$FILE_PATH")

# Extract the tool name to differentiate Write vs Edit
TOOL_NAME=$(echo "$INPUT" | grep -o '"tool_name"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"tool_name"[[:space:]]*:[[:space:]]*"//;s/"$//')

# Output a system message that Claude will see
# This reminds Claude to group related changes for commits
cat << LOG_JSON
{
  "systemMessage": "Git Guardian: ${TOOL_NAME} operation on '${FILENAME}'. Remember to commit related file changes together and write descriptive commit messages."
}
LOG_JSON

exit 0
