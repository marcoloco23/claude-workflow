# Examples

This directory contains examples of how to use the claude-workflow framework.

## Example: Simple Web App

Here's how a typical `CONTINUITY.md` might look for a simple web application:

```markdown
# CONTINUITY LOG

## AGENT CHECKIN

- Agent read full file: YES
- Current task understood: YES
- Current task: Implement user authentication
- Session started: 2026-01-12

## CURRENT STATE

**Date**: 2026-01-12
**Version**: 0.1.0
**Status**: Building MVP

### What Just Happened
- Project initialized with Flask
- Database models created

### What Needs to Happen
- Implement user authentication
- Create API endpoints
- Add frontend

## TASK QUEUE

### Phase 1: Foundation

| # | Task | Status | Notes |
|---|------|--------|-------|
| 1 | 🗺️ Design database schema | DONE | |
| 2 | Create models | DONE | |
| 3 | 🗺️ Design API endpoints | PENDING | |
| 4 | Implement auth endpoints | PENDING | Depends on #3 |
| 5 | Write auth tests | PENDING | |

### Phase 2: Features

| # | Task | Status | Notes |
|---|------|--------|-------|
| 6 | 🗺️ Design user dashboard | PENDING | |
| 7 | Implement dashboard | PENDING | |
| 8 | Add data visualization | PENDING | |

## SESSION LOG

### Session: 2026-01-12

1. Initialized Flask project with SQLAlchemy
2. Created User, Post, Comment models
3. Added alembic for migrations
4. Context compacted - resumed from CONTINUITY.md
5. Starting API design phase
```

## Example: CLI Tool

For a command-line tool project:

```markdown
## TASK QUEUE

### Phase 1: Core CLI

| # | Task | Status | Notes |
|---|------|--------|-------|
| 1 | 🗺️ Design command structure | DONE | |
| 2 | Implement `init` command | DONE | |
| 3 | Implement `run` command | IN_PROGRESS | |
| 4 | Implement `config` command | PENDING | |
| 5 | Add tests for all commands | PENDING | |

### Phase 2: Advanced Features

| # | Task | Status | Notes |
|---|------|--------|-------|
| 6 | 🗺️ Design plugin system | PENDING | |
| 7 | Implement plugin loader | PENDING | |
| 8 | Create example plugins | PENDING | |
```

## Example: Multi-Agent Session

Here's what a typical orchestrator session looks like:

```
User: start orchestrator

Orchestrator: Reading CONTINUITY.md...

Found pending tasks:
- #3: Design API endpoints (🗺️)
- #4: Implement auth endpoints
- #5: Write auth tests

Spawning parallel agents:
[Task 1] planner → "Create plan for API endpoints (#3)"
[Task 2] test-writer → "Write tests for existing models"

[Waiting for results...]

Planner complete: .plans/2026-01-12_api-endpoints.md
Test-writer complete: tests/test_models.py (12 tests, all pass)

Updating CONTINUITY.md:
- #3: DONE
- Added 12 tests

Spawning next batch:
[Task 1] implementer → "Implement auth endpoints per plan"
[Task 2] planner → "Create plan for user dashboard (#6)"

[Continues until queue empty...]
```

## Tips for Effective Task Queues

1. **Use 🗺️ markers** for tasks that need design decisions
2. **Note dependencies** in the Notes column
3. **Keep tasks atomic** - each should be completable in one session
4. **Update frequently** - don't let the queue get stale
5. **Archive completed phases** - move to bottom or separate file
