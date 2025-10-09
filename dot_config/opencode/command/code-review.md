---
description: Review code for best practices and potential issues
agent: plan
subtask: true
---

You are the @plan agent. Orchestrate a comprehensive code review by delegating to the @review subagent:

## Your Task:
Invoke the @review subagent with the following instructions:

### Instructions for @review subagent:

#### STEP 1: Understand Project Standards
- Read AGENTS.md, SPEC.md, or README.md for project-specific coding standards
- Identify established patterns (error handling, testing style, naming conventions)

#### STEP 2: Review Code Quality
- **Language best practices**: Idiomatic patterns and conventions
- **Error handling**: Proper error types, wrapping, and propagation
- **Testing**: Clear test names, proper assertions, good coverage
- **Code organization**: File structure, separation of concerns, YAGNI
- **Performance**: Unnecessary allocations, resource leaks, efficiency
- **Security**: Input validation, secret exposure, injection risks
- **Documentation**: Missing or inadequate docblocks
- **Maintainability**: Code clarity, naming, complexity

#### STEP 3: Identify Issues
For each issue found, document:
- Priority level (critical/important/nice-to-have)
- File and line number (file:line format)
- Clear explanation of the issue
- Concrete suggestion for improvement

#### Required Report Format:

```markdown
## Code Review Summary

**Total Issues: [X critical, Y important, Z nice-to-have]**

### Critical Issues (Priority: High)
[For each critical issue:]
- **file:line** - Brief title
  - Issue: [What's wrong]
  - Impact: [Why it matters]
  - Fix: [How to fix it]

### Important Issues (Priority: Medium)
[Same format as critical]

### Nice-to-Have Improvements (Priority: Low)
[Same format but can be more concise]

### Positive Observations
- [What the code does well]

### Overall Assessment
- Code Quality: [X/10] - [summary]
- Test Coverage: [percentage/assessment]
- Documentation: [assessment]
- Security: [assessment]

### Recommendations
**Immediate Actions:**
1. [Critical fixes]

**Short-term:**
[Important improvements]

**Long-term:**
[Nice-to-have enhancements]
```

Do NOT make any code changes - only analyze and report.

## Your Final Report:
After the @review subagent completes its work, provide a complete, standalone report to the user with the results.
