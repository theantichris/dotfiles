---
description: Create a Jira Product Discovery idea from a PRD file
allowed-tools: Read, Glob, mcp__atlassian__createJiraIssue, AskUserQuestion
---

Create a Jira Product Discovery idea from a PRD file.

## Usage

```
/create-idea [path-to-prd]
```

If no path provided, prompt the user to specify which PRD to use.

## Workflow

1. Read the PRD file
2. Determine the discovery project:
   - PRDs in `companycam/prds/machine_learning/` → MLD
   - PRDs in `companycam/prds/data_engineering/` → DED
   - If unclear, ask the user
3. Extract the title from the PRD's H1 heading (remove "PRD: " prefix if present)
4. Create a Jira Idea with:
   - **Summary**: The PRD title
   - **Description**: The full PRD content (not a summary)
   - **Project**: MLD or DED
   - **Issue type**: Idea
   - **Cloud ID**: companycam.atlassian.net
5. Return the link to the created issue

## Important

- Full PRD content goes in the description, not just a summary
- Show the user what will be created before creating it
