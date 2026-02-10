---
name: create-prd
description: Create a Product Requirements Document for a CompanyCam project. Use when the user wants to write a PRD or document requirements for a new feature.
argument-hint: [topic]
disable-model-invocation: true
allowed-tools: Read, Write, Glob, Bash(nb *), AskUserQuestion, Skill(create-idea)
---

# Create Product Requirements Document

## Workflow

1. **Gather requirements** - Ask clarifying questions one at a time:
   - What problem are we solving?
   - What's the proposed solution approach?
   - What are the success criteria?
   - What team owns this? (ML or Data Engineering)

2. **Determine file location** based on team:
   - Machine Learning → `companycam/prds/machine_learning/`
   - Data Engineering → `companycam/prds/data_engineering/`

3. **Create the PRD** using the template at [template.md](template.md):
   - Fill in sections based on gathered information
   - Leave placeholder text for sections that need more detail
   - Use lowercase_with_underscores for filename

4. **Create the file** using the Write tool, then commit via nb:
   ```bash
   nb git add companycam/prds/<team>/<filename>.md
   nb git commit -m "[nb] Add: companycam/prds/<team>/<filename>.md"
   ```

5. **Offer Jira integration** - Ask if user wants to add to the discovery board:
   - If yes, use the `create-idea` skill with the PRD path

## Guidelines

- Ask clarifying questions one at a time so the user can give complete answers
- Include unfilled template sections for future completion
- Always read the PRD file before creating Jira issue (user may copy-edit)
- PRDs should be concise - cut the fat
- Read an existing PRD in the target folder first to match conventions (Jira link format, section style)
