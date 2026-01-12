# Skills

Specialized knowledge and checklists for working on your project.

## Available Skills

| Skill | Description |
|-------|-------------|
| `code-review` | Review code for correctness and patterns |
| `deploy` | Deploy/release the project |

## How Skills Work

Skills are **automatically detected** by Claude based on your request. When you say something that matches a skill's description, Claude will load the skill's instructions.

Examples:
- "Review the new module" → loads `code-review` skill
- "Deploy v1.2.0" → loads `deploy` skill

## Skills vs Agents vs Plans

| Mechanism | Purpose | When to Use |
|-----------|---------|-------------|
| **Skills** | Knowledge/guidance | "How do I do X?" |
| **Plans** | Document decisions | Before creating new files |
| **Agents** | Separate execution | Complex isolated tasks |
| **CONTINUITY.md** | Track state | Always (main workflow) |

## Creating New Skills

1. Create folder: `.claude/skills/skill-name/`
2. Create `SKILL.md` with frontmatter:
   ```yaml
   ---
   name: skill-name
   description: When to use this skill (max 1024 chars)
   allowed-tools: Read, Write, Edit  # optional
   ---
   ```
3. Add instructions in markdown

## Example: Domain-Specific Skill

If your project has domain-specific knowledge (e.g., unit systems, API patterns, database schemas), create a skill for it:

```
.claude/skills/your-domain/
└── SKILL.md
```

This lets Claude load that domain knowledge when relevant.
