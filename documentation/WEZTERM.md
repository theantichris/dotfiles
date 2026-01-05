# WezTerm Configuration

## Overview

A cyberpunk/netrunner themed terminal emulator setup featuring custom colors, vim style pane navigation, and cross platform support. Configured for keyboard driven workflow with split panes, tabs, and tmux like keybindings.

### Visual Style

- **Cyberpunk Colors**: Magenta (#CA0174), cyan (#00F0FF), neon green (#00FF9C)
- **Dark Background**: Base color (#16161E) with off-white text (#EAEAF2)
- **Cyan Cursor**: Bright cyan (#00F0FF) cursor for visibility
- **Nerd Font**: Hack Nerd Font with platform-specific sizing

## Getting Started

### Installation

1. Install WezTerm:
   - Linux: Download from [wezterm.org](https://wezfurlong.org/wezterm/installation.html)
   - macOS: `brew install --cask wezterm`
   - Windows: Download installer from website
2. Apply configuration: `chezmoi apply` or copy files
3. Launch WezTerm

### Platform-Specific Behavior

**Linux**:
- Font size: 10pt
- Wayland disabled for Hyprland compatibility
- Opacity controlled by Hyprland compositor

**macOS**:
- Font size: 14pt
- Default shell: Fish from Homebrew (`/opt/homebrew/bin/fish`)

**Windows**:
- Default shell: PowerShell 7
- Includes WSL Ubuntu domain configuration
- WSL home directory: `/home/chris`

## Key Features

### Multiplexer Mode

WezTerm includes built in tmux like multiplexing:
- Split panes horizontally/vertically
- Navigate between panes with vim keys
- Resize panes interactively
- Multiple tabs with quick switching

### Graphics Support

- **Kitty Graphics Protocol**: Enabled for displaying images in terminal
- Supports inline image rendering in supported applications

### Font Configuration

- **Primary**: Hack Nerd Font (includes icons and symbols)
- **Fallback**: System default monospace fonts
- Platform-specific sizing for optimal readability

## Keybindings

WezTerm uses modal keybindings** similar to tmux and vim. The terminal operates in two modes with a visual status indicator.

### Modes

| Mode | Indicator | Purpose |
|------|-----------|---------|
| **NORMAL** | Cyan | Window/pane navigation and management |
| **INSERT** | Green | Terminal passthrough - all keys work normally |

**Starting Mode**: NORMAL (cyan indicator at bottom-right)

### Mode Switching

| From Mode | Keys | To Mode |
|-----------|------|---------|
| NORMAL | `i` or `Enter` | INSERT |
| INSERT | `Ctrl+B` then `Esc` | NORMAL |
| INSERT | `Ctrl+B` then `d` | NORMAL |

**Important**: The `Ctrl+B` prefix (leader key) prevents conflicts with programs like Helix, vim, and emacs that use plain `Escape`.

### NORMAL Mode Keybindings

All single-key commands work only in NORMAL mode. Unbound keys are blocked to prevent accidental input.

#### Pane Navigation

| Key | Action |
|-----|--------|
| `h` | Move to left pane |
| `j` | Move to down pane |
| `k` | Move to up pane |
| `l` | Move to right pane |

#### Pane Management

| Key | Action |
|-----|--------|
| `s` | Split horizontal (top/bottom) |
| `v` | Split vertical (left/right) |
| `x` | Close current pane (with confirmation) |
| `f` | Fullscreen/zoom current pane (toggle) |

#### Tab Management

| Key | Action |
|-----|--------|
| `1` | Switch to tab 1 |
| `2` | Switch to tab 2 |
| `3` | Switch to tab 3 |
| `4` | Switch to tab 4 |
| `5` | Switch to tab 5 |
| `6` | Switch to tab 6 |
| `7` | Switch to tab 7 |
| `8` | Switch to tab 8 |
| `9` | Switch to tab 9 |

#### Scrolling

| Key | Action |
|-----|--------|
| `Ctrl+u` | Scroll up half page |
| `Ctrl+d` | Scroll down half page |

#### Other Commands

| Key | Action |
|-----|--------|
| `[` | Enter copy mode (vim-style navigation) |
| `:` | Open command palette |
| `i` | Enter INSERT mode |
| `Enter` | Enter INSERT mode |

### INSERT Mode

All keys pass through to the terminal normally. Use this mode for:
- Typing commands at the shell
- Using interactive programs (Helix, vim, nano, less, etc.)
- Any normal terminal operation

**To return to NORMAL mode**: Press `Ctrl+B`, release, then press `Esc` (or `d`)

### Quick Reference

**Common Workflow**:
1. Start WezTerm → NORMAL mode (cyan)
2. Press `i` → INSERT mode (green) → use shell/programs normally
3. Press `Ctrl+B` then `Esc` → back to NORMAL mode
4. Press `s` → split pane
5. Press `h/j/k/l` → navigate between panes
6. Press `i` → INSERT mode in focused pane

**If You Get Stuck**: The status indicator at bottom-right shows your current mode. Press `Ctrl+B` then `Esc` to return to NORMAL mode.

## Color Scheme

Cyberpunk palette matching the overall theme:

### Primary Colors

- **Foreground**: #EAEAF2 (off-white)
- **Background**: #16161E (dark base)
- **Cursor**: #00F0FF (cyan)
- **Selection Background**: #2A2A33 (muted dark)
- **Selection Foreground**: #EAEAF2 (off-white)

### ANSI Colors

**Normal**:
- Black: #16161E
- Red: #FF003C
- Green: #00FF9C
- Yellow: #FFD300
- Blue: #009CFF
- Magenta: #FF00FF
- Cyan: #00F0FF
- White: #EAEAF2

**Bright**:
- Bright Black: #8A86A0
- Bright Red: #FF3369
- Bright Green: #66FFBF
- Bright Yellow: #FFE766
- Bright Blue: #33CFFF
- Bright Magenta: #FF66FF
- Bright Cyan: #66F5FF
- Bright White: #FFFFFF

## Customization

### Changing Colors

Edit [`~/.config/wezterm/wezterm.lua`](../dot_config/wezterm/wezterm.lua.tmpl) and modify the `config.colors` table:

```lua
config.colors = {
  foreground = "#EAEAF2",
  background = "#16161E",
  cursor_bg = "#00F0FF",
  -- etc.
}
```

### Changing Font

Modify the font configuration:

```lua
config.font = wezterm.font('Your Font Name')
config.font_size = 12
```

### Adding Keybindings

Add new entries to the `config.keys` table:

```lua
{
  key = 'T',
  mods = 'CTRL|SHIFT',
  action = wezterm.action.SpawnTab('CurrentPaneDomain'),
}
```

Available actions: `SpawnTab`, `CloseCurrentPane`, `ActivateTab`, `ToggleFullScreen`, etc.

### Platform-Specific Customization

The config automatically detects the platform. Add custom settings:

```lua
if is_linux then
  config.font_size = 11
end

if is_macos then
  config.font_size = 15
end
```

### Changing Default Shell

**Linux/macOS**:
```lua
config.default_prog = { "/usr/bin/zsh", "-l" }
```

**Windows**:
```lua
config.default_prog = { "C:\\Windows\\System32\\cmd.exe" }
```

## Configuration File

All settings in [`~/.config/wezterm/wezterm.lua`](../dot_config/wezterm/wezterm.lua.tmpl)

The config uses chezmoi templating for platform-specific settings.

## Resources

- [WezTerm Documentation](https://wezfurlong.org/wezterm/) - Official docs
- [WezTerm GitHub](https://github.com/wez/wezterm) - Source code and issues
- [Cyberpunk Palette](../color_palettes/cyberpunk/palette.html) - Color reference
- [Hyprland Documentation](HYPRLAND.md) - Window manager (controls opacity)
