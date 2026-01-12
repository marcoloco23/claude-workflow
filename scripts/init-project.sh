#!/bin/bash

# AI Workflow Framework - Project Initialization Script
#
# This script sets up the AI workflow framework in a new project.
# Works with Claude Code, Cursor, GitHub Copilot, Windsurf, and other AI tools.
#
# Usage:
#   ./init-project.sh /path/to/project "Project Name"
#
# Example:
#   ./init-project.sh ~/projects/myapp "My App"

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory (where the framework lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_DIR="$(dirname "$SCRIPT_DIR")"

# Parse arguments
TARGET_DIR="$1"
PROJECT_NAME="$2"

if [ -z "$TARGET_DIR" ]; then
    echo -e "${RED}Error: Target directory required${NC}"
    echo "Usage: ./init-project.sh /path/to/project \"Project Name\""
    exit 1
fi

if [ -z "$PROJECT_NAME" ]; then
    # Use directory name as project name if not provided
    PROJECT_NAME="$(basename "$TARGET_DIR")"
fi

# Resolve to absolute path
TARGET_DIR="$(cd "$TARGET_DIR" 2>/dev/null && pwd || echo "$TARGET_DIR")"

echo -e "${GREEN}AI Workflow Framework - Project Setup${NC}"
echo -e "${BLUE}Compatible with: Claude Code, Cursor, Copilot, Windsurf, aider${NC}"
echo ""
echo "Target: $TARGET_DIR"
echo "Project: $PROJECT_NAME"
echo ""

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}Creating directory: $TARGET_DIR${NC}"
    mkdir -p "$TARGET_DIR"
fi

# Function to copy and replace placeholders
copy_with_placeholders() {
    local src="$1"
    local dest="$2"

    if [ -f "$dest" ]; then
        echo -e "${YELLOW}  Skipping (exists): $dest${NC}"
        return
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"

    # Copy and replace placeholders
    sed -e "s|{{PROJECT_NAME}}|$PROJECT_NAME|g" \
        -e "s|{{PROJECT_PATH}}|$TARGET_DIR|g" \
        -e "s|{{WORKING_DIR}}|$TARGET_DIR|g" \
        "$src" > "$dest"

    echo -e "${GREEN}  Created: $dest${NC}"
}

# Function to copy file directly
copy_direct() {
    local src="$1"
    local dest="$2"

    if [ -f "$dest" ]; then
        echo -e "${YELLOW}  Skipping (exists): $dest${NC}"
        return
    fi

    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo -e "${GREEN}  Created: $dest${NC}"
}

# Create core AI context files (work with all tools)
echo "Creating AI context files..."
copy_with_placeholders "$FRAMEWORK_DIR/templates/AGENTS.md" "$TARGET_DIR/AGENTS.md"
copy_with_placeholders "$FRAMEWORK_DIR/templates/CONTINUITY.md" "$TARGET_DIR/CONTINUITY.md"
copy_with_placeholders "$FRAMEWORK_DIR/templates/PROGRESS.md" "$TARGET_DIR/PROGRESS.md"

# Create Claude-specific files
echo ""
echo "Setting up .claude/ directory (Claude Code specific)..."
mkdir -p "$TARGET_DIR/.claude/agents"
mkdir -p "$TARGET_DIR/.claude/skills/code-review"
mkdir -p "$TARGET_DIR/.claude/skills/deploy"

# Copy agent files
echo "Copying agent files..."
for file in README.md orchestrator.md planner.md implementer.md test-writer.md code-reviewer.md deployer.md; do
    copy_with_placeholders "$FRAMEWORK_DIR/.claude/agents/$file" "$TARGET_DIR/.claude/agents/$file"
done

# Copy skill files
echo "Copying skill files..."
copy_direct "$FRAMEWORK_DIR/.claude/skills/README.md" "$TARGET_DIR/.claude/skills/README.md"
copy_direct "$FRAMEWORK_DIR/.claude/skills/code-review/SKILL.md" "$TARGET_DIR/.claude/skills/code-review/SKILL.md"
copy_direct "$FRAMEWORK_DIR/.claude/skills/deploy/SKILL.md" "$TARGET_DIR/.claude/skills/deploy/SKILL.md"

# Copy config files
echo "Copying config files..."
copy_direct "$FRAMEWORK_DIR/.claude/settings.local.json" "$TARGET_DIR/.claude/settings.local.json"
copy_with_placeholders "$FRAMEWORK_DIR/.claude/ORCHESTRATOR_PROMPT.md" "$TARGET_DIR/.claude/ORCHESTRATOR_PROMPT.md"
copy_with_placeholders "$FRAMEWORK_DIR/templates/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"

# Set up .plans/ directory
echo ""
echo "Setting up .plans/ directory..."
mkdir -p "$TARGET_DIR/.plans"
copy_direct "$FRAMEWORK_DIR/.plans/README.md" "$TARGET_DIR/.plans/README.md"
copy_direct "$FRAMEWORK_DIR/.plans/_TEMPLATE.md" "$TARGET_DIR/.plans/_TEMPLATE.md"

# Optionally copy ROADMAP.md
if [ ! -f "$TARGET_DIR/ROADMAP.md" ]; then
    read -p "Create ROADMAP.md for long-term planning? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        copy_with_placeholders "$FRAMEWORK_DIR/templates/ROADMAP.md" "$TARGET_DIR/ROADMAP.md"
    fi
fi

echo ""
echo -e "${GREEN}Setup complete!${NC}"
echo ""
echo -e "${BLUE}Files created:${NC}"
echo "  AGENTS.md      - Industry-standard AI context (works with all tools)"
echo "  CONTINUITY.md  - Task queue and session state"
echo "  PROGRESS.md    - Session-by-session progress tracking"
echo "  CLAUDE.md      - Claude Code specific instructions"
echo "  .claude/       - Orchestrator and agent definitions"
echo "  .plans/        - Implementation plan templates"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Edit AGENTS.md to add your project context (commands, conventions)"
echo "2. Edit CONTINUITY.md to add your initial task queue"
echo "3. Start working with your preferred AI tool"
echo ""
echo -e "${BLUE}With Claude Code:${NC}"
echo "  cd \"$TARGET_DIR\""
echo "  claude --dangerously-skip-permissions"
echo "  # Type: start orchestrator"
echo ""
echo -e "${BLUE}With other tools:${NC}"
echo "  Open the project in Cursor, Copilot, or your preferred AI tool."
echo "  The AGENTS.md file will automatically provide context."
