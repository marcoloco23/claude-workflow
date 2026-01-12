# AI Workflow Framework

A reusable framework for making AI coding assistants work continuously and effectively. Works with Claude Code, Cursor, GitHub Copilot, Windsurf, aider, and other AI tools.

## The Problem

AI coding assistants lose their working memory through **context compaction**. When this happens:
- Your brilliant design ideas disappear
- Your task progress is lost
- The AI doesn't know what it was doing

## The Solution

This framework provides:
- **AGENTS.md** - Industry-standard project context for AI tools ([60,000+ repos](https://agents.md/))
- **CONTINUITY.md** - Central state that survives context resets
- **Orchestrator + Sub-agents** - Parallel execution for throughput
- **Planning system** - Design documents that outlive sessions
- **Progress tracking** - Session-by-session history

## Quick Start

### 1. Initialize in your project

```bash
# Clone this framework
git clone https://github.com/marcoloco23/claude-workflow.git

# Initialize in your project
./claude-workflow/scripts/init-project.sh /path/to/your/project "Your Project Name"
```

### 2. Customize for your project

Edit the generated files:
- `AGENTS.md` - Project context for AI tools (industry standard)
- `CONTINUITY.md` - Task queue and session state
- `CLAUDE.md` - Claude-specific instructions (optional)

### 3. Start working

**With Claude Code:**
```bash
cd /path/to/your/project
claude --dangerously-skip-permissions
# Type: "start orchestrator"
```

**With other tools:** Open your project in Cursor, Copilot, or your preferred AI tool. The `AGENTS.md` file will automatically provide context.

## How It Works

```
┌─────────────────┐
│  ORCHESTRATOR   │  Reads queue, spawns agents, updates state
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
3. **Spawns sub-agents** for different roles
4. **Updates CONTINUITY.md** with results
5. **Repeats** until queue is empty

## Framework Structure

```
your-project/
├── AGENTS.md              # Industry-standard AI context (works with all tools)
├── CONTINUITY.md          # Task queue, session log, state tracking
├── PROGRESS.md            # Session-by-session progress history
├── CLAUDE.md              # Claude-specific instructions (optional)
├── .claude/
│   ├── agents/            # Sub-agent definitions
│   │   ├── orchestrator.md
│   │   ├── planner.md
│   │   ├── implementer.md
│   │   ├── test-writer.md
│   │   ├── code-reviewer.md
│   │   └── deployer.md
│   └── skills/            # Domain-specific knowledge
└── .plans/                # Implementation plans
    ├── README.md
    └── _TEMPLATE.md
```

## Key Files

| File | Purpose | Compatibility |
|------|---------|---------------|
| `AGENTS.md` | Project context for AI | All AI tools |
| `CONTINUITY.md` | Task queue and state | All AI tools |
| `PROGRESS.md` | Session history | All AI tools |
| `CLAUDE.md` | Claude-specific setup | Claude Code |
| `.claude/agents/` | Orchestrator system | Claude Code |

## Core Concepts

### AGENTS.md (Industry Standard)

The `AGENTS.md` file provides context to AI tools:
- Project overview and architecture
- Build/test commands
- Code style guidelines
- PR conventions

Works with 25+ AI coding tools. See [agents.md](https://agents.md/) for the specification.

### CONTINUITY.md

The lifeline that survives context resets:
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

## Best Practices

Key insights from industry research:

1. **Read before writing** - Always read existing code first
2. **Plan before coding** - Design decisions should be documented
3. **Test-driven development** - Write tests, then code to pass them
4. **Incremental changes** - Small commits, frequent testing
5. **Treat output as draft** - Always review AI-generated code

See [BEST-PRACTICES.md](docs/BEST-PRACTICES.md) for the full guide.

## Documentation

- [SETUP.md](docs/SETUP.md) - Detailed integration guide
- [CUSTOMIZATION.md](docs/CUSTOMIZATION.md) - How to customize for your project
- [ARCHITECTURE.md](docs/ARCHITECTURE.md) - System design explanation
- [BEST-PRACTICES.md](docs/BEST-PRACTICES.md) - Collected wisdom for AI-assisted development

## Sources

This framework synthesizes best practices from:

- [AGENTS.md Specification](https://agents.md/) — Industry standard for AI context
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices) — Anthropic
- [Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) — Anthropic
- [My LLM Coding Workflow Going Into 2026](https://addyosmani.com/blog/ai-coding-workflow/) — Addy Osmani

## Origin

Extracted from the [dimtensor](https://github.com/marcoloco23/dimtensor) project, where it managed continuous AI development across 4.x versions with 200+ tasks completed.

## License

MIT
