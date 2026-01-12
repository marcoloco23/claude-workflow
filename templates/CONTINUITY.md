# CONTINUITY LOG

---
## AGENT: READ THIS BLOCK FIRST. DO NOT SKIP.
---

### FIRST: SETUP (Run this before ANY work)

```bash
cd "{{PROJECT_PATH}}"

# Install dependencies (customize for your project)
# [your install command]

# Verify tests pass
# [your test command]
```

---

### AGENT MODE: ORCHESTRATOR

You are an ORCHESTRATOR. Your job is to:
1. Identify parallelizable tasks
2. Spawn sub-agents to do work in parallel (using Task tool)
3. Collect results and update this file
4. Keep going until ALL tasks are DONE

**Sub-agents available** (see .claude/agents/):
- `planner` - Creates plans for 🗺️ tasks
- `implementer` - Implements features
- `test-writer` - Writes tests
- `code-reviewer` - Reviews code
- `deployer` - Handles releases

**Spawn multiple agents in parallel** when tasks don't depend on each other!

Example:
```
[Spawn in parallel using multiple Task tool calls in ONE message:]
- planner → "Create plan for task #X"
- implementer → "Implement task #Y (plan already exists)"
- test-writer → "Write tests for module Z"
```

---

### WORKFLOW

```
AT SESSION START:
1. Read this ENTIRE file
2. Update AGENT CHECKIN below
3. Check task queue for PLAN REQUIRED markers

BEFORE IMPLEMENTING ANY NEW FILE:
⚠️ MANDATORY: Create plan in .plans/ folder FIRST
- Copy .plans/_TEMPLATE.md to .plans/YYYY-MM-DD_feature-name.md
- Fill out: Goal, Approach, Implementation Steps, Files to Modify
- THEN start coding

AS YOU WORK:
- Update SESSION LOG after each task (add numbered entry)
- Update TASK QUEUE when status changes
- KEEP GOING until task queue is empty or you hit a blocker

IMPORTANT: DO NOT STOP. KEEP WORKING.
- After finishing one milestone, START THE NEXT IMMEDIATELY
- Do NOT summarize and wait - just continue to the next task
- Only stop if: tests fail, you're genuinely blocked, or ALL tasks are DONE
```

### PLANNING RULES

**PLAN REQUIRED when**:
- Creating a new file
- Adding a new module or feature
- Task has 🗺️ marker in queue

**Plan NOT required when**:
- Editing existing files only
- Running tests/deploys
- Updating docs

**Why plan?** Plans survive context compaction. Your brilliant design in working memory doesn't.

---

## AGENT CHECKIN

- Agent read full file: YES/NO
- Current task understood: YES/NO
- Current task: [task name]
- Session started: [date/time]

---

## CURRENT STATE

**Date**: YYYY-MM-DD
**Version**: X.Y.Z
**Status**: [current status]

### What Just Happened
- [recent accomplishment]

### What Needs to Happen
- [next steps]

---

## TASK QUEUE

### Phase 1: [Phase Name]

| # | Task | Status | Notes |
|---|------|--------|-------|
| 1 | 🗺️ Plan feature X | PENDING | Plan required |
| 2 | Implement feature X | PENDING | Depends on #1 |
| 3 | Write tests for X | PENDING | |
| 4 | Deploy vX.Y.Z | PENDING | |

---

## SESSION LOG

Format: Use sequential numbers. Add new entries at the bottom.

### Session: YYYY-MM-DD

1. [First task completed]
2. [Second task completed]
3. ...

---

## LESSONS LEARNED

1. **Context compaction is real** - Always update CONTINUITY.md
2. **Plans survive, thoughts don't** - Create plans before implementing
3. **Verify claims** - Don't trust agent claims, verify actual state
4. **Use 🗺️ markers** - Workers can't judge complexity, mark explicitly

---
