---
name: create-idea
description: Create a Jira Product Discovery idea from a PRD file. Use when the user wants to add a PRD to Jira or create a discovery idea.
argument-hint: [path-to-prd]
disable-model-invocation: true
allowed-tools: Read, Glob, mcp__atlassian__createJiraIssue, AskUserQuestion
---

# Create Jira Product Discovery Idea

## Workflow

1. Read the PRD file at `$ARGUMENTS`
2. Determine the discovery project from the file path:
   - `companycam/prds/machine_learning/` → MLD
   - `companycam/prds/data_engineering/` → DED
   - If unclear, ask the user which project
3. Extract the title from the PRD's H1 heading (remove "PRD: " prefix if present)
4. Show the user what will be created and ask for confirmation
5. Create a Jira Idea with:
   - **Summary**: The PRD title
   - **Description**: The full PRD content (not a summary)
   - **Project**: MLD or DED
   - **Issue type**: Idea
   - **Cloud ID**: companycam.atlassian.net
6. Return the link to the created issue

## Important

- Full PRD content goes in the description field, not just a summary
- Always show the user what will be created before creating it
- Always read the PRD file fresh before creating (user may have edited it)
