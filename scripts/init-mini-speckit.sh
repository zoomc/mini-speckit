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
cp -R "$TEMPLATE_DIR/.mini-speckit" "$TARGET_DIR/.mini-speckit"
cp "$TEMPLATE_DIR/.github/copilot-instructions.md" "$TARGET_DIR/.github/copilot-instructions.md"

echo "mini-speckit initialized in: $TARGET_DIR"
echo "Next: read .mini-speckit/project-constraints.md before editing code."
