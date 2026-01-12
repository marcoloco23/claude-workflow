# Progress Log

Session-by-session progress tracking for AI agents. This file helps agents quickly understand what happened in previous sessions.

---

## Current Status

**Last Updated**: YYYY-MM-DD HH:MM
**Current Phase**: [phase name]
**Blocking Issues**: [none / list issues]

---

## Active Work

### In Progress
- [ ] [Task currently being worked on]

### Next Up
- [ ] [Next task to start]
- [ ] [Following task]

---

## Recent Sessions

### Session: YYYY-MM-DD HH:MM

**Agent**: [agent type or name]
**Duration**: [approximate duration]
**Focus**: [what was being worked on]

**Completed**:
- [x] Task 1 completed
- [x] Task 2 completed

**Started but not finished**:
- [ ] Task 3 (partial - needs X to complete)

**Decisions Made**:
- Decision: [what was decided]
  - Reason: [why]
  - Alternatives considered: [other options]

**Issues Encountered**:
- Issue: [description]
  - Status: [resolved/open]
  - Resolution: [if resolved, how]

**Notes for Next Session**:
- [Important context for continuation]

---

### Session: YYYY-MM-DD HH:MM

[Previous session entries...]

---

## Feature Tracking

Track feature completion status:

```json
{
  "features": [
    {
      "name": "Feature Name",
      "status": "complete|in_progress|pending|blocked",
      "tests_pass": true,
      "notes": "Optional notes"
    }
  ]
}
```

---

## Recovery Notes

If context is lost or agent needs to resume:

1. **Read this file first** - understand recent progress
2. **Check CONTINUITY.md** - for full task queue
3. **Check git log** - for recent commits
4. **Run tests** - verify current state works

---

*This progress log helps AI agents maintain continuity across sessions.*
