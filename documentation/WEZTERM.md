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

All keybindings use `CTRL + SHIFT` modifier to avoid conflicts with terminal applications.

### Pane Management

| Shortcut           | Action                        |
|--------------------|-------------------------------|
| `CTRL + SHIFT + R` | Split pane right (horizontal) |
| `CTRL + SHIFT + D` | Split pane down (vertical)    |
| `CTRL + SHIFT + H` | Move to left pane             |
| `CTRL + SHIFT + J` | Move to down pane             |
| `CTRL + SHIFT + K` | Move to up pane               |
| `CTRL + SHIFT + L` | Move to right pane            |

### Pane Resizing

| Shortcut           | Action            |
|--------------------|-------------------|
| `CTRL + SHIFT + ←` | Resize pane left  |
| `CTRL + SHIFT + ↓` | Resize pane down  |
| `CTRL + SHIFT + ↑` | Resize pane up    |
| `CTRL + SHIFT + →` | Resize pane right |

Resizes in 5-column/row increments per press.

### Tab Management

| Shortcut           | Action          |
|--------------------|-----------------|
| `CTRL + SHIFT + 1` | Switch to tab 1 |
| `CTRL + SHIFT + 2` | Switch to tab 2 |
| `CTRL + SHIFT + 3` | Switch to tab 3 |

### Scrolling

| Shortcut   | Action               |
|------------|----------------------|
| `CTRL + ↑` | Scroll up one line   |
| `CTRL + ↓` | Scroll down one line |

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
