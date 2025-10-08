---
description: Update project documentation and run linters
agent: docs
subtask: true
---

You are the @docs subagent. Perform a complete documentation review and update:

## STEP 1: Review Code Documentation
- Check ALL .go files for missing or outdated docblocks
- Update docblocks that need improvement
- Document both exported AND unexported items

## STEP 2: Review Markdown Files
- Read README.md, SPEC.md, AGENTS.md
- Identify sections that are outdated or need updates
- Update any incorrect or missing information
- Ensure consistency with the current codebase

## STEP 3: Run Linters
- For Go files: Run `go fmt` and `golangci-lint run`
- For Markdown: Run `pre-commit run markdownlint --files <filename>`
- Fix any issues found

## CRITICAL: Your response will be relayed to the user
Provide a complete, standalone report that the user can read directly.
Format it for maximum clarity.

## REQUIRED: Final Report Format

```markdown
## Documentation Update Summary

### Files Modified:
- **file.go** (lines X-Y): [description of changes]
- **file.md** (section Z): [description of changes]

### Linting Results:
- go fmt: [results]
- golangci-lint: [results]  
- markdownlint: [results]
- go test: [results]

### What Was Updated:
1. **Code documentation**: [summary of docblock changes]
2. **Markdown documentation**: [summary of markdown changes]

### Status: [COMPLETE/INCOMPLETE with reason]
```

Do NOT provide running commentary - work silently and provide ONE final comprehensive report.
