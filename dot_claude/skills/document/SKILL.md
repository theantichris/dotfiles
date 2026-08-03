---
name: document
description: Comprehensively update project documentation after code changes. Use when asked to update docs, refresh the README, or document new features.
allowed-tools: Read, Glob, Grep, Edit, Write, Bash
---

# Update Project Documentation

Style and structure rules live in [documentation.md](documentation.md) — read it before writing. It covers README, SPEC.md, CLAUDE.md, and code-comment conventions.

## Workflow

1. **Analyze recent changes**
   - Review recent code modifications
   - Identify new features, commands, or configuration
   - Check for new dependencies or requirements

2. **Update core documentation**
   - `README.md` — installation, usage, features sections
   - `SPEC.md` — requirements, design, or API if functionality changed
   - `CLAUDE.md` / `AGENTS.md` — new commands, updated architecture notes

3. **Code documentation**
   - Add or update doc comments for exported functions and types
   - Ensure examples are current and working
   - Add inline comments for complex logic

4. **Validate**
   - Confirm commands in the docs actually work
   - Check version numbers are current
   - Verify links resolve
   - Run spellcheck if available (`codespell`, `typos`)

5. **Consistency check**
   - Ensure README, SPEC, and the agent context file tell the same story
   - Verify examples match the actual implementation
   - Check prerequisites and dependencies agree across files

## Scope

Only touch documentation that already exists, or that Christopher asked for. Do not create new doc files — including subdirectory READMEs — unless explicitly requested.

Focus on clarity and completeness while avoiding redundancy.
