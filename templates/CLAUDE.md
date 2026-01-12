# CLAUDE.md

Guidance for Claude Code when working with this repository.

---

## FIRST: Setup Verification

**Before ANY work, run this setup:**

```bash
cd "{{PROJECT_PATH}}"

# Install dependencies (customize for your project)
# pip install -e ".[dev]"
# npm install
# cargo build

# Run tests to verify setup
# pytest
# npm test
# cargo test
```

---

## "Start Orchestrator" Command

**If the user says "start orchestrator", "orchestrate", or "run orchestrator":**

You become the ORCHESTRATOR. Do this IMMEDIATELY:

1. Read `CONTINUITY.md` to find pending tasks
2. Read `.claude/agents/README.md` for sub-agent instructions
3. Spawn sub-agents in PARALLEL using Task tool:
   - `planner` for 🗺️ tasks
   - `implementer` for feature work
   - `test-writer` for tests
   - `deployer` for releases
4. Update CONTINUITY.md with results
5. KEEP GOING until all tasks are DONE

**Spawn multiple sub-agents in ONE message for parallelism!**

Example spawn:
```
Task tool call 1: "You are a PLANNER. Read .claude/agents/planner.md. Create plan for task #X"
Task tool call 2: "You are an IMPLEMENTER. Read .claude/agents/implementer.md. Implement task #Y"
```

---

## Quick Start

1. **Read CONTINUITY.md first** - Contains current task queue and workflow
2. **Read .claude/agents/README.md** - Contains detailed agent instructions
3. **Work through the TASK QUEUE** - Don't stop to ask for approval

---

## Project Overview

**{{PROJECT_NAME}}** is [brief description of your project].

Key features:
- Feature 1
- Feature 2
- Feature 3

---

## Commands

```bash
# Install
[your install command]

# Test (REQUIRED before commits)
[your test command]

# Type check (if applicable)
[your type check command]

# Lint (if applicable)
[your lint command]

# Build
[your build command]
```

---

## Architecture

```
src/
├── [your project structure]
```

---

## Key Files

| File | Purpose |
|------|---------|
| CONTINUITY.md | **Task queue and session log** - Read first |
| .claude/agents/ | Agent instructions |
| .plans/ | Planning documents for complex tasks |

---

## Workflow

See CONTINUITY.md for the current task queue.

```
1. Read CONTINUITY.md
2. Update AGENT CHECKIN
3. Work through TASK QUEUE
4. Update CONTINUITY.md after each task
5. KEEP GOING until queue empty or blocked
```
