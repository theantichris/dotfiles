# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **chezmoi-powered dotfiles repository** for managing personal environment configurations across macOS, Windows, and Linux. It follows chezmoi's conventions with template files prefixed with `dot_` that get expanded to `.` on target machines.

## Common Commands

### Chezmoi Operations

- `chezmoi init <GITHUB_USERNAME> --ssh --apply` - Initialize and apply dotfiles from GitHub
- `chezmoi update` - Pull latest changes and apply
- `chezmoi diff` - Preview changes before applying
- `chezmoi apply -v` - Apply local changes with verbose output
- `chezmoi edit <FILE>` - Edit a tracked file in chezmoi source
- `chezmoi add <FILE>` - Start tracking a new file
- `chezmoi cd` - Change to chezmoi source directory

### Testing Changes

- Always use `chezmoi diff` before `chezmoi apply` to preview impacts
- Test configuration files locally before committing (e.g., validate TOML/YAML syntax)

## Architecture & Patterns

### File Naming Conventions

- **`dot_` prefix**: Files that become dotfiles on target (e.g., `dot_zshrc` → `~/.zshrc`)
- **`private_` prefix**: Files containing sensitive data, encrypted in the repository
- **Platform-specific**: Some configs are OS-specific (e.g., `dot_glzr/` for Windows, `dot_config/aerospace/` for macOS)

### Key Configuration Areas

1. **Window Managers**
   - macOS: AeroSpace (`dot_config/aerospace/aerospace.toml`) + Karabiner (`dot_config/private_karabiner/`)
   - Windows: GlazeWM (`dot_glzr/glazewm/config.yaml`) + Zebar (`dot_glzr/zebar/`)

2. **Shell Configurations**
   - Zsh: `dot_zshrc`, `dot_oh-my-zsh/`
   - PowerShell: `dot_profile.ps1`

3. **Development Tools**
   - Helix editor: `AppData/Roaming/helix/config.toml`
   - Git: `dot_gitconfig`, `dot_gitignore`
   - GitHub tools: `dot_config/gh/`, `dot_config/gh-dash/`

4. **Terminal Tools**
   - Superfile: `AppData/Local/superfile/`
   - Bat, Eza, Glow: configs in `dot_config/`

### Template System

- Chezmoi templates use Go templating
- Data values stored in `.chezmoidata.toml`
- Templates allow platform-specific configurations

### Security Notes

- Files with `private_` prefix contain encrypted sensitive data
- API keys and tokens should be stored in `.chezmoidata.toml` (encrypted)
- Never commit unencrypted secrets

## Development Workflow

1. Make changes in the chezmoi source directory (use `chezmoi cd`)
2. Test configurations locally before applying
3. Use `chezmoi diff` to review changes
4. Apply with `chezmoi apply -v`
5. Commit changes to git when satisfied
