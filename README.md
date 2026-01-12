# Claude Workflow Framework

A reusable framework for making AI assistants work continuously and effectively. Designed for Claude Code but adaptable to other AI coding assistants.

## The Problem

AI coding assistants lose their working memory through **context compaction**. When this happens:
- Your brilliant design ideas disappear
- Your task progress is lost
- The AI doesn't know what it was doing

## The Solution

This framework provides:
- **CONTINUITY.md** - Central state that survives context resets
- **Orchestrator + Sub-agents** - Parallel execution for throughput
- **Planning system** - Design documents that outlive sessions
- **Skills** - Domain knowledge and checklists

## Quick Start

### 1. Initialize in your project

```bash
# Clone or download this framework
git clone https://github.com/yourusername/claude-workflow.git

# Initialize in your project
./claude-workflow/scripts/init-project.sh /path/to/your/project "Your Project Name"
```

### 2. Customize for your project

Edit the generated files:
- `CLAUDE.md` - Add your project's commands and structure
- `CONTINUITY.md` - Add your task queue

### 3. Start working

```bash
cd /path/to/your/project
claude --dangerously-skip-permissions
```

Then type: **"start orchestrator"**

The AI will read `CONTINUITY.md`, find tasks, and start spawning sub-agents to work in parallel.

## How It Works

```
┌─────────────────┐
│  ORCHESTRATOR   │  Reads queue, spawns agents, updates CONTINUITY.md
└────────┬────────┘
         │
    ┌────┴────┬──────────┬──────────┐
    ▼         ▼          ▼          ▼
┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
│planner │ │implmtr │ │tester  │ │deployer│
└────────┘ └────────┘ └────────┘ └────────┘
```

1. **Orchestrator** reads the task queue in `CONTINUITY.md`
2. Identifies tasks that can run **in parallel**
3. **Spawns sub-agents** using the Task tool
4. **Updates CONTINUITY.md** with results
5. **Repeats** until queue is empty

## Framework Structure

```
your-project/
├── CLAUDE.md              # Entry point for AI - project overview, commands
├── CONTINUITY.md          # Task queue, session log, state tracking
├── ROADMAP.md             # (optional) Long-term vision
├── .claude/
│   ├── agents/            # Sub-agent definitions
│   │   ├── orchestrator.md
│   │   ├── planner.md
│   │   ├── implementer.md
│   │   ├── test-writer.md
│   │   ├── code-reviewer.md
│   │   └── deployer.md
│   ├── skills/            # Domain-specific knowledge
│   │   ├── code-review/
│   │   └── deploy/
│   └── settings.local.json
└── .plans/                # Implementation plans
    ├── README.md
    └── _TEMPLATE.md
```

## Key Concepts

### CONTINUITY.md

The lifeline. Contains:
- **Agent checkin** - Where to start
- **Current state** - What just happened
- **Task queue** - What needs to happen
- **Session log** - History that survives compaction

### Plans

Before creating new files, **write a plan**. Plans survive context compaction; your working memory doesn't.

```bash
cp .plans/_TEMPLATE.md .plans/2026-01-12_my-feature.md
```

### Task Markers

Use 🗺️ to mark tasks that require planning:

```markdown
| # | Task | Status | Notes |
|---|------|--------|-------|
| 1 | 🗺️ Design new API | PENDING | Plan required |
```

### Parallel Execution

The orchestrator spawns multiple agents in ONE message:

```
Task 1: planner → "Create plan for feature X"
Task 2: implementer → "Implement feature Y (plan exists)"
Task 3: test-writer → "Write tests for feature Y"
```

## Documentation

- [SETUP.md](docs/SETUP.md) - Detailed integration guide
- [CUSTOMIZATION.md](docs/CUSTOMIZATION.md) - How to customize for your project
- [ARCHITECTURE.md](docs/ARCHITECTURE.md) - System design explanation

## Origin

This framework was extracted from the [dimtensor](https://github.com/yourusername/dimtensor) project, where it was developed to manage continuous AI development across 4.x versions with 200+ tasks completed.

## License

MIT
