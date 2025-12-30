# Agent Guide for Dotfiles Repository

## Repository Overview

This is a **chezmoi-managed dotfiles repository** for a cyberpunk/netrunner themed desktop environment. It contains configuration files for Linux (Hyprland), macOS (AeroSpace), and cross-platform development tools. The repository uses chezmoi templating for platform-specific configurations.

### Key Characteristics

- **Type**: Personal dotfiles managed with chezmoi
- **Theme**: Cyberpunk/netrunner aesthetic with magenta (#CA0174) and cyan (#00F0FF) color scheme
- **Platform**: Multi-platform (Linux primary, macOS secondary, Windows support)
- **Primary WM**: Hyprland (Linux) / AeroSpace (macOS)
- **Shell**: Fish with custom prompt
- **Editor**: Helix with LSP integration
- **Terminal**: WezTerm

## Repository Structure

### Chezmoi Conventions

Chezmoi uses special file naming conventions:

- `dot_` prefix → `.` (hidden files)
  - Example: `dot_gitconfig` → `~/.gitconfig`
- `dot_config/` → `~/.config/`
- `.tmpl` suffix → Templates processed by chezmoi
  - Contains Go template syntax: `{{ if eq .chezmoi.os "linux" }}`
- `private_` prefix → Files with stricter permissions (600)
- `.chezmoiscripts/` → Scripts run during chezmoi apply
  - `run_onchange_before_*.sh.tmpl` → Run before apply when changed

### Directory Layout

```
.
├── .chezmoignore              # Platform-specific ignore patterns
├── .chezmoiscripts/           # Install scripts per platform
├── documentation/             # Tool-specific docs (HELIX.md, FISH.md, etc.)
├── color_palettes/            # Color scheme reference (palette.html)
├── dot_config/                # ~/.config/ contents
│   ├── hypr/                  # Hyprland config (Linux)
│   ├── waybar/                # Status bar (Linux)
│   ├── fish/                  # Fish shell config
│   ├── helix/                 # Helix editor config
│   ├── wezterm/               # WezTerm terminal config
│   ├── aerospace/             # AeroSpace WM (macOS)
│   └── private_karabiner/     # Karabiner keyboard (macOS)
├── dot_gitconfig.tmpl         # Git configuration
└── README.md                  # User documentation
```

## Code Patterns and Conventions

### Chezmoi Templates

Templates use Go template syntax:

```go
{{- if eq .chezmoi.os "linux" -}}
# Linux-specific config
{{- end }}

{{- if eq .chezmoi.os "darwin" -}}
# macOS-specific config
{{- end }}

{{- if eq .chezmoi.os "windows" -}}
# Windows-specific config
{{- end }}
```

## Important Gotchas

### Chezmoi-Specific

1. **Edit Source, Not Target**: Always edit files in the chezmoi source directory (`chezmoi edit <file>`), not the applied files in `$HOME`
2. **Template Syntax**: `.tmpl` files are processed - be careful with `{{` and `}}` in configs
3. **Platform Filtering**: `.chezmoiignore` prevents cross-platform file pollution
4. **Script Execution**: Scripts in `.chezmoiscripts/` only run on changes (hash-based)

### File Naming

1. **Dot Prefix**: When adding files, use `dot_` for hidden files: `chezmoi add ~/.config/foo` creates `dot_config/foo`
2. **Private Files**: Use `private_` prefix for sensitive files (600 permissions)
3. **Template Detection**: Add `.tmpl` suffix to enable template processing

### Configuration Changes

1. **Hyprland**: Changes to `theme.conf` require reload: `hyprctl reload`
2. **Waybar**: Module changes require restart, style changes auto-reload
3. **Fish**: New files in `conf.d/` auto-load on shell restart
4. **Helix**: Config changes apply immediately, theme changes need `:reload`

### Git Configuration

1. **GPG Signing**: Commits are signed by default (`commit.gpgsign = true`)
2. **Editor**: Set to Helix (`core.editor = helix`)
3. **Delta**: Using git-delta for diffs (pager configured)
4. **Line Endings**: Forced to LF (`core.eol = lf`, `core.autocrlf = input`)

### Platform Detection

Template conditionals check `chezmoi.os`:
- `"linux"` - Linux systems
- `"darwin"` - macOS
- `"windows"` - Windows

Example from `dot_config/fish/functions/upgrade.fish.tmpl`:
```fish
{{- if eq .chezmoi.os "darwin" }}
brew update
brew upgrade
{{- end }}
```

## Testing and Validation

### Chezmoi Validation

```bash
# Check for template errors
chezmoi execute-template < templatefile.tmpl

# Dry run (show what would change)
chezmoi apply --dry-run --verbose

# Diff specific file
chezmoi diff ~/.config/helix/config.toml
```

## Documentation Standards

### Location

Tool-specific docs in `documentation/`:
- `HYPRLAND.md` - Window manager keybinds, configuration
- `WAYBAR.md` - Status bar modules, styling
- `FISH.md` - Shell aliases, functions, prompt
- `HELIX.md` - Editor features, LSP setup
- `WEZTERM.md` - Terminal configuration, multiplexing
- `AEROSPACE.md` - macOS window manager
- `KARABINER.md` - macOS keyboard customization

### Style

- Clear headings and sections
- Code examples with syntax highlighting
- File paths use chezmoi source paths (not `~` paths)
- Link to related config files
- Include installation instructions
- Document keybindings and shortcuts

## Security Considerations

### Sensitive Data

- **Never commit**: API keys, passwords, tokens
- **Use private_ prefix**: For files with sensitive data (karabiner config)
- **Git config**: User email, signing key already in repo (public info)
- **SSH keys**: Not managed by chezmoi, set up separately
- **GPG keys**: Not managed by chezmoi, import separately

### Private Files

Files with `private_` prefix get 600 permissions:
- `dot_config/private_gtk-3.0/` - GTK bookmarks may contain paths
- `dot_config/private_karabiner/` - Keyboard config
- `dot_config/aerc/private_accounts.conf` - Email accounts

## Agent Best Practices

### When Working in This Repo

1. **Always use chezmoi commands** for file management
2. **Test templates** before applying (use `chezmoi execute-template`)
3. **Check platform context** - don't add Linux-only configs to macOS sections
4. **Follow color scheme** - use cyberpunk palette colors
5. **Update documentation** when changing configs
6. **Use modular configs** - don't create monolithic config files
7. **Test on target platform** if possible before committing

### Editing Configs

```bash
# WRONG - editing applied file
hx ~/.config/fish/config.fish

# RIGHT - editing source through chezmoi
chezmoi edit ~/.config/fish/config.fish
# or
chezmoi cd && hx dot_config/fish/config.fish.tmpl
```

### Adding Features

1. Check existing patterns in similar configs
2. Follow the modular organization (separate files per concern)
3. Use established aliases/naming conventions
4. Add to relevant documentation
5. Test with `chezmoi diff` before applying

## Reference Links

- [Chezmoi Documentation](https://www.chezmoi.io/user-guide/command-overview/)
- [Helix Documentation](https://docs.helix-editor.com/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Fish Shell Documentation](https://fishshell.com/docs/current/)
- [WezTerm Documentation](https://wezfurlong.org/wezterm/)

## Quick Reference

### File Path Translation

| Chezmoi Source | Applied Location |
|---------------|------------------|
| `dot_config/fish/config.fish.tmpl` | `~/.config/fish/config.fish` |
| `dot_gitconfig.tmpl` | `~/.gitconfig` |
| `dot_local/bin/executable_script` | `~/.local/bin/script` (755) |
| `private_dot_ssh/config` | `~/.ssh/config` (600) |

### Common File Locations

| Tool | Config Location (chezmoi source) |
|------|----------------------------------|
| Fish | `dot_config/fish/` |
| Helix | `dot_config/helix/` |
| Hyprland | `dot_config/hypr/` |
| WezTerm | `dot_config/wezterm/` |
| Git | `dot_gitconfig.tmpl` |
| Waybar | `dot_config/waybar/` |

### Keybinding Reference

See documentation files for complete keybindings:
- Hyprland: `documentation/HYPRLAND.md`
- Helix: `documentation/HELIX.md`
- WezTerm: `documentation/WEZTERM.md`
