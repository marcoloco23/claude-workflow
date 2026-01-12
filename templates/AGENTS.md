# AGENTS.md

> A README for AI coding agents. This file provides context and instructions to help AI assistants work effectively on this project.

**Compatibility**: Claude Code, Cursor, GitHub Copilot, Windsurf, Cline, aider, and [60,000+ other projects](https://agents.md/)

---

## Project Overview

**{{PROJECT_NAME}}** is [brief description of your project].

**Tech Stack**: [languages, frameworks, key dependencies]

**Architecture**: [high-level architecture description]

---

## Dev Environment

### Setup

```bash
cd "{{PROJECT_PATH}}"

# Install dependencies
[your install command]

# Verify setup
[your test command]
```

### Common Commands

| Command | Purpose |
|---------|---------|
| `[test command]` | Run tests |
| `[lint command]` | Run linter |
| `[build command]` | Build project |
| `[dev command]` | Start dev server |

---

## Code Style

### Conventions

- [Your naming conventions]
- [Your file organization rules]
- [Your import ordering preferences]

### Patterns to Follow

```
[Example of preferred code pattern]
```

### Patterns to Avoid

```
[Example of anti-pattern to avoid]
```

---

## Testing

### Running Tests

```bash
# Run all tests
[test command]

# Run specific test file
[specific test command]

# Run with coverage
[coverage command]
```

### Test Guidelines

- [Your testing philosophy]
- [What to test]
- [Test file naming conventions]

---

## Making Changes

### Before Starting

1. Read relevant existing code first
2. Check if a plan exists in `.plans/`
3. Understand the change's scope

### During Development

1. Make small, incremental changes
2. Run tests frequently
3. Commit after each working step

### Before Committing

- [ ] Tests pass
- [ ] Linting passes
- [ ] No debug code left
- [ ] Changes are focused (one concern per commit)

---

## PR Guidelines

### Commit Messages

```
type(scope): brief description

- Detail 1
- Detail 2
```

Types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`

### PR Checklist

- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] CHANGELOG updated (if applicable)
- [ ] No breaking changes (or documented)

---

## Project-Specific Notes

### Key Files

| File | Purpose |
|------|---------|
| `[path]` | [description] |

### Known Issues

- [Any gotchas or workarounds]

### Domain Knowledge

- [Project-specific concepts agents should understand]

---

## AI Workflow Integration

This project uses the [claude-workflow](https://github.com/marcoloco23/claude-workflow) framework:

- **CONTINUITY.md** - Task queue and session state (read this for current context)
- **.plans/** - Implementation plans for complex features
- **.claude/agents/** - Sub-agent definitions for parallel work

### Starting Work

1. Read `CONTINUITY.md` to understand current state
2. Check task queue for next pending item
3. Read any existing plan in `.plans/` for context
4. Make changes incrementally, committing often

---

*This file follows the [AGENTS.md specification](https://agents.md/)*
