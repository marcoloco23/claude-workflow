# Setup Guide

Detailed instructions for integrating the claude-workflow framework into your project.

## Prerequisites

- [Claude Code CLI](https://claude.ai/claude-code) installed
- A project directory (new or existing)

## Installation Methods

### Method 1: Init Script (Recommended)

```bash
# 1. Clone or download this framework
git clone https://github.com/yourusername/claude-workflow.git ~/tools/claude-workflow

# 2. Run init script
~/tools/claude-workflow/scripts/init-project.sh /path/to/your/project "Your Project"
```

The script will:
- Create `.claude/` directory with agents and skills
- Create `.plans/` directory with templates
- Create `CLAUDE.md` and `CONTINUITY.md` in your project root
- Replace `{{PROJECT_NAME}}` and `{{PROJECT_PATH}}` placeholders

### Method 2: Manual Setup

```bash
cd /path/to/your/project

# Copy directories
cp -r /path/to/claude-workflow/.claude .
cp -r /path/to/claude-workflow/.plans .

# Copy templates
cp /path/to/claude-workflow/templates/CLAUDE.md .
cp /path/to/claude-workflow/templates/CONTINUITY.md .

# Replace placeholders manually
sed -i '' 's/{{PROJECT_NAME}}/Your Project/g' CLAUDE.md CONTINUITY.md .claude/agents/*.md
sed -i '' 's|{{PROJECT_PATH}}|/path/to/your/project|g' CLAUDE.md CONTINUITY.md .claude/agents/*.md
```

## Post-Installation Configuration

### 1. Edit CLAUDE.md

Update these sections:

```markdown
## FIRST: Setup Verification
# Add your project's setup commands
pip install -e ".[dev]"  # or npm install, cargo build, etc.

## Project Overview
# Describe your project

## Commands
# Add your project's common commands

## Architecture
# Document your project structure
```

### 2. Edit CONTINUITY.md

Set up your initial task queue:

```markdown
## TASK QUEUE

### Phase 1: Initial Setup

| # | Task | Status | Notes |
|---|------|--------|-------|
| 1 | 🗺️ Design feature X | PENDING | |
| 2 | Implement feature X | PENDING | Depends on #1 |
| 3 | Write tests | PENDING | |
```

### 3. Add Project-Specific Skills (Optional)

Create custom skills for domain-specific knowledge:

```bash
mkdir -p .claude/skills/your-domain
cat > .claude/skills/your-domain/SKILL.md << 'EOF'
---
name: your-domain
description: Domain knowledge for your project
---

# Your Domain Skill

[Add domain-specific checklists and patterns here]
EOF
```

## Global Configuration

To apply base instructions to all projects:

```bash
cp /path/to/claude-workflow/global/CLAUDE.md ~/.claude/CLAUDE.md
```

## Running the Orchestrator

```bash
cd /path/to/your/project
claude --dangerously-skip-permissions
```

Then say: **"start orchestrator"**

The AI will:
1. Read `CONTINUITY.md`
2. Find pending tasks
3. Spawn sub-agents in parallel
4. Update state as work completes
5. Keep going until queue is empty

## Permissions

The `settings.local.json` file grants these tools:
- `Bash` - Run commands
- `Read`, `Edit`, `Write` - File operations
- `Task` - Spawn sub-agents
- `WebSearch`, `WebFetch` - Web access
- `Glob`, `Grep` - File search

Modify as needed for your security requirements.

## Troubleshooting

### "Permission denied" errors

Make sure you're running with `--dangerously-skip-permissions` or have approved the tools.

### Agents not updating CONTINUITY.md

Sub-agents are instructed NOT to update CONTINUITY.md. Only the orchestrator should.

### Context compaction losing state

This is expected. The framework is designed to survive this. Make sure agents are updating CONTINUITY.md regularly.

### Plans not being created

Tasks with 🗺️ markers require plans. The planner agent will create them in `.plans/`.
