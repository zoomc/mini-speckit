#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /absolute/path/to/target-project" >&2
  exit 1
fi

TARGET_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Target directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

mkdir -p "$TARGET_DIR/.github"
cp -R "$TEMPLATE_DIR/.mini-spec-kit" "$TARGET_DIR/.mini-spec-kit"
cp "$TEMPLATE_DIR/.github/copilot-instructions.md" "$TARGET_DIR/.github/copilot-instructions.md"

# Generate CLAUDE.md from template (project name from directory basename)
PROJECT_NAME="$(basename "$TARGET_DIR")"
if [ ! -f "$TARGET_DIR/CLAUDE.md" ]; then
  sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TEMPLATE_DIR/templates/CLAUDE.md" > "$TARGET_DIR/CLAUDE.md"
  echo "Created CLAUDE.md with project name: $PROJECT_NAME"
else
  echo "CLAUDE.md already exists, skipping."
fi

# Copy Claude slash commands
if [ -d "$TEMPLATE_DIR/.claude/commands" ]; then
  mkdir -p "$TARGET_DIR/.claude/commands"
  cp "$TEMPLATE_DIR/.claude/commands/"*.md "$TARGET_DIR/.claude/commands/"
  echo "Copied Claude slash commands to .claude/commands/"
fi

# Copy Codex skills
if [ -d "$TEMPLATE_DIR/.agents/skills" ]; then
  mkdir -p "$TARGET_DIR/.agents/skills"
  cp -R "$TEMPLATE_DIR/.agents/skills/"* "$TARGET_DIR/.agents/skills/"
  echo "Copied Codex skills to .agents/skills/"
fi

# Generate AGENTS.md from template (for Codex)
if [ ! -f "$TARGET_DIR/AGENTS.md" ]; then
  sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$TEMPLATE_DIR/templates/AGENTS.md" > "$TARGET_DIR/AGENTS.md"
  echo "Created AGENTS.md with project name: $PROJECT_NAME"
else
  echo "AGENTS.md already exists, skipping."
fi

echo "mini-spec-kit initialized in: $TARGET_DIR"
echo "Next: read .mini-spec-kit/project-constraints.md before editing code."
