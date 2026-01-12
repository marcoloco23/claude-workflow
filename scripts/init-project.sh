#!/bin/bash

# Claude Workflow Framework - Project Initialization Script
#
# This script sets up the claude-workflow framework in a new project.
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

echo -e "${GREEN}Claude Workflow Framework - Project Setup${NC}"
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

echo "Setting up .claude/ directory..."
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

# Set up .plans/ directory
echo "Setting up .plans/ directory..."
mkdir -p "$TARGET_DIR/.plans"
copy_direct "$FRAMEWORK_DIR/.plans/README.md" "$TARGET_DIR/.plans/README.md"
copy_direct "$FRAMEWORK_DIR/.plans/_TEMPLATE.md" "$TARGET_DIR/.plans/_TEMPLATE.md"

# Copy template files to root
echo "Creating root config files..."
copy_with_placeholders "$FRAMEWORK_DIR/templates/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
copy_with_placeholders "$FRAMEWORK_DIR/templates/CONTINUITY.md" "$TARGET_DIR/CONTINUITY.md"

# Optionally copy ROADMAP.md
if [ ! -f "$TARGET_DIR/ROADMAP.md" ]; then
    read -p "Create ROADMAP.md? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        copy_with_placeholders "$FRAMEWORK_DIR/templates/ROADMAP.md" "$TARGET_DIR/ROADMAP.md"
    fi
fi

echo ""
echo -e "${GREEN}Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Edit CLAUDE.md to add your project-specific commands and structure"
echo "2. Edit CONTINUITY.md to add your initial task queue"
echo "3. Run 'claude' in your project directory to start working"
echo ""
echo "To start the orchestrator:"
echo "  claude --dangerously-skip-permissions"
echo "  Then type: start orchestrator"
