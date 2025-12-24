# Fish Shell Configuration

## Overview

A cyberpunk/netrunner themed Fish shell setup featuring a custom two line prompt with git integration, language version detection, and comprehensive aliases for common tools. Emphasizes visual feedback with color-coded status indicators and project context awareness.

### Visual Style

- **Cyberpunk Colors**: Magenta (#CA0174) and cyan (#00F0FF) prompt indicators
- **Two line Prompt**: Status and context on first line, command entry on second
- **Git Integration**: Branch, status indicators, and ahead/behind counts
- **Language Detection**: Auto-displays Node.js and Go versions when in projects
- **Right Prompt**: Timestamp display

## Getting Started

### Installation

1. Install Fish shell:
   - Linux: `sudo pacman -S fish` or `sudo apt install fish`
   - macOS: `brew install fish`
2. Set as default shell: `chsh -s $(which fish)`
3. Apply configuration: `chezmoi apply`
4. Restart terminal

### First Launch

Fish will display fastfetch on startup, showing system info with the pentagram logo.

## Prompt Features

### Two-Line Layout

**Line 1**: Status indicator, user/host (SSH only), virtual env, language versions, current path, git status
**Line 2**: Triple-arrow command prompt

### Status Indicators

- **Exit Status**: Shows red ✗ and error code if last command failed
- **User/Host**: Displayed when connected via SSH or running as non-default user
- **Virtual Environment**: Python venv name in parentheses (magenta)
- **Language Versions**:
  - Node.js version in green when `package.json` present
  - Go version in cyan when `go.mod` present

### Git Information

- **Branch Name**: Current branch or commit hash (cyan)
- **Status Symbols**:
  - Yellow ● - Unstaged changes
  - Green ● - Staged changes
  - Red ● - Untracked files
- **Sync Status**:
  - ⇣ number - Commits behind upstream (green)
  - ⇡ number - Commits ahead of upstream (magenta)

### Right Prompt

Current time in HH:MM:SS format (gray)

## Aliases

Comprehensive aliases organized by tool in [`~/.config/fish/conf.d/`](../dot_config/fish/conf.d/):

- [`git.fish`](../dot_config/fish/conf.d/git.fish) - Git and GitHub CLI shortcuts
- [`eza.fish`](../dot_config/fish/conf.d/eza.fish) - File listing aliases
- [`bat.fish`](../dot_config/fish/conf.d/bat.fish) - File viewer shortcuts
- [`helix.fish`](../dot_config/fish/conf.d/helix.fish.tmpl) - Editor shortcuts
- [`go.fish`](../dot_config/fish/conf.d/go.fish) - Go development aliases
- [`wezterm.fish`](../dot_config/fish/conf.d/wezterm.fish) - Terminal shortcuts
- [`hyprland.fish`](../dot_config/fish/conf.d/hyprland.fish) - Hyprland shortcuts
- Plus others for aerc, chezmoi, digitalocean, markdownlint, nom, rg, toot, and screensaver

## Functions

### `upgrade`

Updates all package managers and tools:
- Go global packages (`go-global-update`)
- Python tools (`uv tool upgrade --all`)
- Rust crates (`cargo install-update -a`)
- Homebrew (macOS only)

Usage: `upgrade`

### `fish_greeting`

Displays fastfetch system info on shell startup. Customize by editing [`config.fish`](../dot_config/fish/config.fish.tmpl).

## Environment Variables

Configured in [`environment.fish`](../dot_config/fish/environment.fish):

- **Browser**: `BROWSER=google-chrome-stable`
- **SSH Agent**: `SSH_AUTH_SOCK` configured for auto-loading GitHub key
- **Man Pages**: Uses bat for syntax-highlighted man pages

## Path Management

Automatically adds directories to PATH if they exist (configured in [`path.fish`](../dot_config/fish/path.fish)):

- `~/.cargo/bin` - Rust binaries
- `~/.local/bin` - Local user binaries
- `~/go/bin` - Go binaries

## Customization

### Changing Prompt Colors

Edit [`fish_prompt.fish`](../dot_config/fish/functions/fish_prompt.fish) and modify the color variables:

```fish
set -g cyberpunk_primary CA0174      # Main accent
set -g cyberpunk_secondary 00F0FF    # Cyan accent
set -g cyberpunk_success 00FF9C      # Success/green
set -g cyberpunk_warning FFD300      # Warning/yellow
set -g cyberpunk_error FF003C        # Error/red
```

### Adding Aliases

Create a new file in [`conf.d/`](../dot_config/fish/conf.d/) or add to existing ones:

```fish
# ~/.config/fish/conf.d/custom.fish
alias myalias='command'
```

### Creating Functions

Add functions to [`functions/`](../dot_config/fish/functions/):

```fish
# ~/.config/fish/functions/myfunction.fish
function myfunction --description 'Description here'
    # Your code
end
```

### Disabling Fastfetch Greeting

Edit [`config.fish`](../dot_config/fish/config.fish.tmpl):

```fish
function fish_greeting
    # Leave empty or add your own greeting
end
```

### Changing Default User

The prompt hides username when you're the default user. To change it, edit [`fish_prompt.fish`](../dot_config/fish/functions/fish_prompt.fish):

```fish
function __cyberpunk_user_host
    set -l default_user your_username  # Change this
```

## Configuration Files

All settings in [`~/.config/fish/`](../dot_config/fish/):

- [`config.fish`](../dot_config/fish/config.fish.tmpl) - Main configuration
- [`environment.fish`](../dot_config/fish/environment.fish) - Environment variables
- [`path.fish`](../dot_config/fish/path.fish) - PATH management
- [`conf.d/`](../dot_config/fish/conf.d/) - Auto-loaded alias files
- [`functions/`](../dot_config/fish/functions/) - Custom functions

## Resources

- [Fish Documentation](https://fishshell.com/docs/current/) - Official docs
- [Fish GitHub](https://github.com/fish-shell/fish-shell) - Source code
- [Cyberpunk Palette](../color_palettes/cyberpunk/palette.html) - Color reference
