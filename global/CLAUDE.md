# Global Claude Code Instructions

## Philosophy

- **Read before writing.** Understand existing code before suggesting modifications.
- **Simplicity over cleverness.** The right amount of complexity is the minimum needed for the current task.
- **Facts over assumptions.** When uncertain, investigate rather than guess. Mark uncertainty as `UNCONFIRMED`.
- **Continuity matters.** For long-running tasks, maintain state that survives context compaction.

## Working Style

- Keep responses concise and actionable
- Use TodoWrite for multi-step execution tracking
- For large tasks, use the project's task management system if one exists
- Prefer editing existing files over creating new ones
- Run linters and tests frequently

## Installation

Copy this file to `~/.claude/CLAUDE.md` to apply globally to all projects.
