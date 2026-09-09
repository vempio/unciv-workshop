#!/bin/bash
# install-sdd-skills.sh
# Install the three spec-driven skills into the exercise-local .claude/skills
# directory, so /sdd.1-requirements, /sdd.2-plan, and /sdd.3-tasks are available
# to your agent when working inside this exercise.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$SCRIPT_DIR/sdd-skills"
SKILLS_DIR="$SCRIPT_DIR/.claude/skills"

mkdir -p "$SKILLS_DIR"
cp -R "$SRC_DIR"/sdd.* "$SKILLS_DIR"/

echo ""
echo "Spec-driven skills installed to $SKILLS_DIR"
echo "Available commands: /sdd.1-requirements, /sdd.2-plan, /sdd.3-tasks"
