# Documentation Guidelines

These are global instructions for Claude Code when working with documentation across all projects.

## General Documentation Principles

### Writing Style
- Use clear, concise language - avoid unnecessary verbosity
- Write in active voice when possible
- Use present tense for descriptions of current behavior
- Include practical examples for complex concepts
- Avoid marketing language or superlatives

### Markdown Formatting
- Use ATX-style headers (# not underlines)
- Prefer fenced code blocks with language hints over indented blocks
- Use tables for structured data when it improves readability
- Keep line lengths reasonable (80-100 chars) for better diffs
- Add blank lines between sections for readability

## README.md Standards

When updating or creating README files:

### Required Sections (in order)
1. **Project Title & Badges** - Name and status badges
2. **Description** - One paragraph explaining what and why
3. **Features** - Bullet points of key capabilities (if applicable)
4. **Installation** - Clear steps to get started
5. **Usage** - Basic usage examples
6. **Development** - Setup for contributors
7. **Contributing** - How to contribute (if open source)
8. **License** - License information

### Best Practices
- Start with a clear value proposition
- Include prerequisites explicitly
- Provide copy-pasteable commands
- Test all installation instructions
- Include troubleshooting section for common issues
- Keep examples simple but realistic

## SPEC.md Standards

When updating SPEC.md files (project specifications):

### Purpose
- Define the project's goals, requirements, and constraints
- Serve as the source of truth for what the project should do
- Guide development decisions and feature prioritization

### Structure
1. **Overview** - Project purpose and high-level goals
2. **Goals** - Specific, measurable objectives
3. **Non-Goals** - Explicitly what the project won't do
4. **Requirements** - Functional and non-functional requirements
5. **Technical Design** - Architecture and implementation approach
6. **API/Interface Design** - Public interfaces (if applicable)
7. **Data Model** - Data structures and storage (if applicable)
8. **Security Considerations** - Security requirements and concerns
9. **Performance Requirements** - Performance targets and constraints
10. **Future Considerations** - Potential future enhancements

### Guidelines
- Be specific and measurable where possible
- Include acceptance criteria for requirements
- Document trade-offs and decisions
- Keep it updated as requirements evolve
- Use RFC 2119 keywords (MUST, SHOULD, MAY) for requirements
- Include diagrams for complex architectures

## CLAUDE.md Standards

When updating CLAUDE.md files (AI assistant instructions):

### Structure
1. **Project Overview** - Brief context
2. **Common Commands** - Frequently used commands
3. **Architecture** - System design and structure
4. **Key Dependencies** - Important libraries and tools
5. **Development Notes** - Important context and gotchas

### Guidelines
- Focus on actionable information
- Include commands that should be run regularly (tests, linting)
- Document non-obvious architectural decisions
- Highlight any project-specific conventions
- Keep it concise - this is a reference, not a tutorial

## Code Documentation

### Go Projects
- Write idiomatic Go doc comments (start with the name being declared)
- Don't duplicate information obvious from signatures
- Focus on behavior, not implementation
- Include examples for complex functions
- Document all exported types and functions

### Comments
- Explain why, not what
- Update comments when code changes
- Remove outdated TODOs
- Use consistent comment style within a project

## Documentation Updates

When asked to "update documentation":

1. **Check existing style** - Match the project's current documentation style
2. **Update all relevant files** - Usually README.md, SPEC.md, and CLAUDE.md
3. **Keep consistency** - Ensure all docs tell the same story
4. **Add examples** - Include practical examples for new features
5. **Update version references** - If versions or requirements change
6. **Check links** - Ensure all links still work
7. **Run spellcheck** - Use codespell or similar tools

## Pre-commit and CI Documentation

When adding development tools:
- Document both installation and usage
- Include the purpose/benefit of each tool
- Provide troubleshooting steps
- Show example output when helpful
- Document any configuration files added

## Version Documentation

- Use semantic versioning in examples
- Keep version requirements up to date
- Document breaking changes clearly
- Include migration guides for major changes

## Language and Tone

- Be respectful and inclusive
- Avoid jargon without explanation
- Define acronyms on first use
- Use "you" for instructions (second person)
- Use "we" for project decisions (first person plural)

## What NOT to Do

- Don't create documentation files unless explicitly requested
- Don't add README files to subdirectories unless necessary
- Don't duplicate information available elsewhere
- Don't include implementation details in user-facing docs
- Don't use emoji unless the project already does
- Don't make assumptions about the user's environment

## Quick Reference

Common tasks and how to handle them:
- **New feature added**: Update README usage section, SPEC.md requirements, CLAUDE.md commands
- **Dependency added**: Update README installation, CLAUDE.md dependencies
- **Tool configured**: Update both README and CLAUDE.md with commands
- **Breaking change**: Update README with migration guide, SPEC.md with new requirements
- **Bug fixed**: Usually no doc updates needed unless behavior changed
- **Architecture change**: Update SPEC.md technical design, CLAUDE.md architecture section