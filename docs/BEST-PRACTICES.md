# Best Practices for AI-Assisted Development

Collected wisdom from industry research and real-world experience with AI coding agents.

---

## Context Management

### The Core Problem

AI agents have limited context windows. When conversations get too long, older content is summarized or removed ("context compaction"). This causes:

- Loss of working memory
- Loss of task progress
- Repeated work
- Inconsistent behavior

### Solutions

**1. Persistent State Files**

Write important state to files that survive context resets:

| File | Purpose |
|------|---------|
| `CONTINUITY.md` | Task queue, session log, current state |
| `PROGRESS.md` | Detailed session-by-session progress |
| `.plans/*.md` | Design decisions and implementation steps |
| `AGENTS.md` | Project context for all AI tools |

**2. Strategic Context Packing**

Before asking an AI to code, provide:
- High-level goals and constraints
- Reference implementations or examples
- Warnings about approaches to avoid
- Relevant documentation

> "Don't force the AI to operate on incomplete information." — [Addy Osmani](https://addyosmani.com/blog/ai-coding-workflow/)

**3. Read Before Write**

Always have the AI read relevant files before making changes:
- Existing code in the area
- Related tests
- Documentation

---

## Workflow Patterns

### Plan → Code → Test → Commit

The most effective workflow pattern:

```
1. PLAN    - Create a plan before coding new features
2. CODE    - Implement in small, incremental steps
3. TEST    - Run tests after each change
4. COMMIT  - Commit after each working step
```

### Test-Driven Development (TDD)

TDD is especially powerful with AI agents:

1. Write tests based on expected input/output
2. Run tests to confirm they fail
3. Write code to pass the tests
4. Iterate until all tests pass

> "This tight feedback loop is something AI excels at as long as tests exist." — [Anthropic](https://www.anthropic.com/engineering/claude-code-best-practices)

### Incremental Changes

**Do**:
- Make small, focused changes
- Commit after each working step
- Keep PRs focused on one concern

**Don't**:
- Request monolithic implementations
- Make multiple unrelated changes
- Let uncommitted work pile up

---

## Quality Assurance

### Treat Output as Draft

Never blindly trust AI-generated code:

- Review all changes carefully
- Run tests and verify behavior
- Check for security issues
- Validate edge cases

> "The AI is an assistant, not an autonomously reliable coder. You remain accountable for quality." — [Addy Osmani](https://addyosmani.com/blog/ai-coding-workflow/)

### Use Git as Safety Net

Git provides recovery points:

```bash
# Commit frequently
git commit -m "Working: feature X step 1"

# Revert if something breaks
git revert HEAD

# Use branches for experiments
git checkout -b experiment/approach-a
```

### Multi-Agent Verification

Use multiple AI perspectives:
- Have one agent write code, another review it
- Try the same prompt on different models
- Use specialized agents (security reviewer, test writer)

---

## Parallel Execution

### Orchestrator Pattern

Use a central orchestrator to coordinate parallel work:

```
┌─────────────────┐
│  ORCHESTRATOR   │  Coordinates, tracks state
└────────┬────────┘
         │
    ┌────┴────┬──────────┐
    ▼         ▼          ▼
┌────────┐ ┌────────┐ ┌────────┐
│ Agent1 │ │ Agent2 │ │ Agent3 │
└────────┘ └────────┘ └────────┘
```

### Git Worktrees for Isolation

Run parallel AI sessions in isolated worktrees:

```bash
git worktree add ../project-feature-a feature-a
git worktree add ../project-feature-b feature-b
```

### Task Independence

Identify tasks that can run in parallel:
- Different features
- Tests while implementing
- Documentation while coding

---

## Project Organization

### AGENTS.md (Industry Standard)

The `AGENTS.md` file is the industry standard for AI agent instructions:

- Adopted by 60,000+ open-source projects
- Works with Claude, Cursor, Copilot, Windsurf, and more
- Contains project context, commands, and conventions

See [agents.md](https://agents.md/) for the specification.

### File Hierarchy

When multiple instruction files exist, closer files take precedence:

```
project/
├── AGENTS.md              # Project-wide instructions
├── CONTINUITY.md          # Task queue and state
└── src/
    └── module/
        └── AGENTS.md      # Module-specific overrides
```

### Separation of Concerns

| File | Audience | Content |
|------|----------|---------|
| `README.md` | Humans | Quick start, contributing |
| `AGENTS.md` | AI agents | Technical context, commands |
| `CONTINUITY.md` | AI agents | Task queue, session state |

---

## Session Management

### Session Startup Protocol

At the start of each session:

1. Read `CONTINUITY.md` for current state
2. Read `PROGRESS.md` for recent history
3. Check git log for recent commits
4. Run tests to verify working state
5. Update agent checkin

### Session Cleanup

Before ending a session:

1. Commit all working changes
2. Update `PROGRESS.md` with session notes
3. Update `CONTINUITY.md` task status
4. Note any blocking issues

### Handling Context Loss

If an agent loses context mid-task:

1. The agent reads `CONTINUITY.md` and `PROGRESS.md`
2. Checks git log for recent work
3. Runs tests to understand current state
4. Continues from documented position

---

## Common Pitfalls

### Over-Reliance on AI

- Don't let AI make architectural decisions without review
- Stay engaged with the code being generated
- Maintain your own understanding of the system

### Insufficient Context

- Don't assume the AI knows your conventions
- Provide explicit examples of preferred patterns
- Document domain-specific knowledge

### Ignoring Failures

- Don't skip failing tests
- Don't ignore linting errors
- Don't push broken code

### Context Bloat

- Use `/clear` or equivalent to reset between tasks
- Archive completed work to separate files
- Keep instruction files focused and current

---

## Tools Integration

### Multi-Tool Workflow

Different tools excel at different tasks:

| Tool | Best For |
|------|----------|
| Claude Code | Complex reasoning, planning |
| Cursor | Quick edits, completions |
| Copilot | Inline suggestions |
| aider | Git-integrated changes |

### Shared Configuration

Use files that work across tools:

- `AGENTS.md` - Recognized by most AI tools
- `.editorconfig` - Editor consistency
- `pyproject.toml` / `package.json` - Project config

---

## Sources

This document synthesizes best practices from:

- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices) — Anthropic
- [Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) — Anthropic
- [My LLM Coding Workflow Going Into 2026](https://addyosmani.com/blog/ai-coding-workflow/) — Addy Osmani
- [AGENTS.md Specification](https://agents.md/) — Community Standard

---

*Last updated: 2026-01-12*
