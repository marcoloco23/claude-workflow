# Architecture

Understanding the design and rationale of the claude-workflow framework.

## Core Problem

AI coding assistants like Claude Code have **context limits**. When the conversation gets too long, older content is summarized or removed ("context compaction"). This causes:

1. Loss of working memory
2. Loss of task progress
3. Repeated work
4. Inconsistent behavior

## Solution: Persistent State

The framework solves this by writing state to files that survive context resets:

```
┌─────────────────────────────────────────────────┐
│                 AI CONTEXT                       │
│  (Volatile - will be compacted)                  │
│                                                  │
│  ┌─────────────────────────────────────────┐    │
│  │ Working memory, reasoning, conversation │    │
│  └─────────────────────────────────────────┘    │
└─────────────────────────────────────────────────┘
                      │
                      │ Reads/Writes
                      ▼
┌─────────────────────────────────────────────────┐
│              FILE SYSTEM                         │
│  (Persistent - survives compaction)              │
│                                                  │
│  ┌──────────────┐  ┌──────────────┐             │
│  │ CONTINUITY.md│  │ .plans/*.md  │             │
│  │ - Task queue │  │ - Designs    │             │
│  │ - State      │  │ - Decisions  │             │
│  │ - History    │  │ - Steps      │             │
│  └──────────────┘  └──────────────┘             │
└─────────────────────────────────────────────────┘
```

## Component Overview

### CONTINUITY.md

**Purpose**: Central state persistence

**Contains**:
- Agent checkin (who's working, on what)
- Current state (version, recent changes)
- Task queue (what needs to happen)
- Session log (what happened, survives compaction)
- Lessons learned (institutional knowledge)

**Design rationale**: A single file is easier to read and update than scattered state. The markdown format is human-readable and AI-friendly.

### Plans Directory

**Purpose**: Design decisions that outlive sessions

**Why plans matter**: When context is compacted, your mental model of how to implement something is lost. A plan file preserves:
- The goal
- The approach (and alternatives considered)
- Implementation steps
- Files to modify

**When to plan**: Before creating any new file. The 🗺️ marker in the task queue enforces this.

### Orchestrator + Sub-Agents

**Purpose**: Parallel execution and clear responsibility

```
┌─────────────────┐
│  ORCHESTRATOR   │  The conductor
│  - Reads queue  │
│  - Spawns agents│
│  - Updates state│
└────────┬────────┘
         │
    ┌────┴────┬──────────┬──────────┐
    ▼         ▼          ▼          ▼
┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
│planner │ │implmtr │ │tester  │ │reviewer│
│        │ │        │ │        │ │        │
│ Plans  │ │ Codes  │ │ Tests  │ │ Reviews│
│ only   │ │ only   │ │ only   │ │ only   │
└────────┘ └────────┘ └────────┘ └────────┘
```

**Why separate agents?**
1. **Parallel execution**: Multiple agents work simultaneously
2. **Clear responsibility**: Each agent has one job
3. **Better results**: Specialized prompts produce better output
4. **Scalability**: Add more agents as needed

**Why orchestrator?**
1. **Coordination**: Someone needs to track overall progress
2. **State management**: One place updates CONTINUITY.md
3. **Decision making**: Decides what can run in parallel

### Skills

**Purpose**: Domain knowledge and checklists

**When to use**: For recurring patterns that need consistent handling (code review, deployment, domain-specific work).

**Skills vs Agents**:
- Skills = Knowledge/checklists loaded into context
- Agents = Separate execution with their own context

## Data Flow

```
1. User: "start orchestrator"
          │
          ▼
2. Orchestrator reads CONTINUITY.md
          │
          ▼
3. Identifies parallelizable tasks
          │
          ▼
4. Spawns sub-agents (Task tool, multiple in one message)
          │
          ├──────────────────┬──────────────────┐
          ▼                  ▼                  ▼
5a. Planner creates    5b. Implementer    5c. Test-writer
    plan in .plans/        codes              tests
          │                  │                  │
          └──────────────────┴──────────────────┘
                             │
                             ▼
6. Orchestrator collects results
          │
          ▼
7. Updates CONTINUITY.md
          │
          ▼
8. REPEAT from step 3 until queue empty
```

## Design Decisions

### Why Markdown?

- Human readable without tools
- AI can read and write it naturally
- Version control friendly
- No parsing libraries needed

### Why Single CONTINUITY.md?

- Easy to find (always root)
- Single source of truth
- Atomic updates
- Quick to scan

### Why 🗺️ Markers?

Early versions used "complex tasks require plans." But AI agents can't reliably judge complexity. Explicit markers remove ambiguity.

### Why No Auto-Updating by Sub-Agents?

Concurrent file updates cause conflicts. Having only the orchestrator update CONTINUITY.md ensures consistency.

### Why Parallel Spawning in ONE Message?

Claude Code's Task tool supports multiple calls per message. Separate messages serialize execution. One message with multiple Tasks = true parallelism.

## Failure Modes and Mitigations

| Failure | Mitigation |
|---------|------------|
| Context compacted mid-task | CONTINUITY.md preserves state |
| Plan lost | Plans are files, not memory |
| Sub-agent fails | Orchestrator retries or marks blocked |
| Conflicting updates | Only orchestrator writes state |
| Lost progress | Session log preserves history |

## Extending the Framework

### Add New Agent Types

1. Create `.claude/agents/new-agent.md`
2. Define role, responsibilities, response format
3. Reference in orchestrator prompts

### Add New Skills

1. Create `.claude/skills/skill-name/SKILL.md`
2. Define when to use, checklists, patterns
3. Skills auto-load when relevant

### Add New State

Extend CONTINUITY.md sections as needed:
- Add metrics tracking
- Add deployment history
- Add custom phases

## Performance Considerations

- **Spawn multiple agents**: Always use parallel Task calls
- **Keep CONTINUITY.md focused**: Move completed tasks to archive
- **Use appropriate agent types**: planner for planning, implementer for coding
- **Don't over-plan**: Simple edits don't need plans
