# Customization Guide

How to customize the claude-workflow framework for your project.

## Customizing Agents

### Modify Agent Behavior

Edit files in `.claude/agents/` to change agent behavior.

**Example: Add project-specific patterns to implementer**

```markdown
# In .claude/agents/implementer.md

## Code Patterns

Follow these project patterns:
- Use dependency injection for services
- All API endpoints must validate input
- Use repository pattern for data access
```

### Add New Agent Types

Create new agent files for specialized roles:

```bash
cat > .claude/agents/security-reviewer.md << 'EOF'
---
name: security-reviewer
description: Reviews code for security vulnerabilities
model: sonnet
---

# Security Reviewer Agent

You review code for security vulnerabilities.

## Your Job

1. Check for OWASP Top 10 vulnerabilities
2. Verify input validation
3. Check authentication/authorization
4. Review secrets handling

## Response Format

When done, respond with:
SECURITY REVIEW COMPLETE
File: [path]
Status: PASSED / VULNERABILITIES FOUND
Findings: [list]
EOF
```

Then reference it in the orchestrator or spawn it directly.

## Customizing Skills

### Add Domain-Specific Skills

Create skills for your project's domain knowledge:

```bash
mkdir -p .claude/skills/api-design
cat > .claude/skills/api-design/SKILL.md << 'EOF'
---
name: api-design
description: Design RESTful APIs following project conventions
---

# API Design Skill

## Conventions

- Use kebab-case for URLs
- Use plural nouns for collections
- Version APIs with /v1/, /v2/
- Return 201 for creation, 204 for deletion

## Checklist

- [ ] URL follows conventions
- [ ] HTTP methods are appropriate
- [ ] Request/response schemas defined
- [ ] Error responses documented
EOF
```

### Modify Existing Skills

Edit skill files to add project-specific checks:

```markdown
# In .claude/skills/code-review/SKILL.md

## Project-Specific Checks

- [ ] All database queries use parameterized statements
- [ ] Logging uses structured format
- [ ] Feature flags wrap new functionality
```

## Customizing the Task Queue

### Task Status Values

Standard statuses:
- `PENDING` - Not started
- `IN_PROGRESS` - Being worked on
- `DONE` - Completed
- `BLOCKED` - Waiting on something

Add custom statuses if needed:
- `REVIEW` - Awaiting code review
- `DEPLOYED` - Released to production

### Task Markers

The 🗺️ marker indicates a task needs planning. Add your own:

- 🔒 Security review required
- 🧪 Experimental feature
- 📱 Mobile-specific
- 🌐 Affects public API

### Phases and Milestones

Organize tasks into logical phases:

```markdown
## TASK QUEUE

### Phase 1: Foundation
[Core infrastructure tasks]

### Phase 2: Features
[Feature development tasks]

### Phase 3: Polish
[Testing, documentation, optimization]
```

## Customizing Plans

### Add Sections to Plan Template

Edit `.plans/_TEMPLATE.md`:

```markdown
## Security Considerations

- [ ] Authentication requirements
- [ ] Authorization model
- [ ] Data validation
- [ ] Sensitive data handling

## Performance Considerations

- [ ] Expected load
- [ ] Caching strategy
- [ ] Database indexes needed
```

### Plan Naming Conventions

Default: `YYYY-MM-DD_feature-name.md`

Alternatives:
- `sprint-42_feature-name.md` - Sprint-based
- `epic-auth_feature-name.md` - Epic-based
- `001_feature-name.md` - Sequential

## Environment-Specific Configuration

### Development vs Production

Create environment-specific instructions in `CLAUDE.md`:

```markdown
## Environment Setup

### Development
pip install -e ".[dev]"
export ENV=development

### Production
pip install .
export ENV=production
```

### CI/CD Integration

Add CI-specific tasks:

```markdown
## TASK QUEUE

### CI/CD

| # | Task | Status | Notes |
|---|------|--------|-------|
| 1 | Add GitHub Actions workflow | PENDING | |
| 2 | Configure deployment | PENDING | |
```

## Multi-Project Configuration

### Shared Framework

Keep the framework in a central location:

```
~/tools/claude-workflow/    # Shared framework
~/projects/
  ├── project-a/            # Uses framework
  └── project-b/            # Uses framework
```

### Project-Specific Overrides

Each project can override or extend:
- Add custom agents
- Add custom skills
- Modify templates

The `settings.local.json` in each project overrides global settings.
