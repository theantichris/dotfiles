# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Type

Chezmoi-managed dotfiles repository with cross-platform configurations (Linux/macOS/Windows).

## Critical Workflow Rules

### Always Edit Source Files Through Chezmoi

**NEVER** edit applied files directly in `$HOME`:
```bash
# WRONG - changes will be lost on next apply
hx ~/.config/fish/config.fish

# RIGHT - edit through chezmoi
chezmoi edit ~/.config/fish/config.fish
```

All file modifications must go through chezmoi or they'll be overwritten.

### Essential Chezmoi Commands

```bash
# Edit tracked file (use this for all edits)
chezmoi edit <file>

# Preview changes before applying
chezmoi diff

# Apply configurations
chezmoi apply

# Test template syntax
chezmoi execute-template < file.tmpl

# Dry run to see what would change
chezmoi apply --dry-run --verbose
```

## Non-Obvious Behaviors

### Scripts Auto-Execute on Changes

Scripts in `.chezmoiscripts/run_onchange_before_*.sh.tmpl` automatically run when their content hash changes. No need to manually execute package installation scripts - just edit and run `chezmoi apply`.

### Template Processing Gotcha

Files with `.tmpl` suffix are processed as Go templates. `{{` and `}}` are template delimiters:

```go
{{- if eq .chezmoi.os "linux" -}}
# Linux-only config
{{- end }}

{{- if eq .chezmoi.os "darwin" -}}
# macOS-only config
{{- end }}
```

If you need literal `{{` in a template file, escape it: `\{\{`

## Adding New Configurations

1. Track file with: `chezmoi add <file>`
2. Use `.tmpl` suffix for files needing platform conditionals
3. Use `private_` prefix for sensitive files (gets 600 permissions)
4. Test with `chezmoi diff` before applying
5. Update `.chezmoiignore` if platform-exclusive
