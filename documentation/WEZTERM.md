# WezTerm Configuration

## Overview

Modal terminal emulator with vim-style navigation. Features cyberpunk color scheme and cross-platform support.

### Visual Style

- **Cyberpunk Colors**: Magenta (#CA0174), cyan (#00F0FF), neon green (#00FF9C)
- **Dark Background**: #16161E with off-white text (#EAEAF2)
- **Cyan Cursor**: #00F0FF
- **Font**: Hack Nerd Font (10pt Linux, 14pt macOS)

## Modal System

WezTerm operates in four modes with visual indicators (bottom-right corner):

| Mode       | Indicator | Purpose                                 |
|------------|-----------|-----------------------------------------|
| **INSERT** | Green     | Normal terminal (all keys pass through) |
| **NORMAL** | Cyan      | Window/pane management                  |
| **RESIZE** | Yellow    | Resize panes                            |
| **MOVE**   | Magenta   | Move/rotate panes                       |

**Default**: Starts in NORMAL mode

## Mode Switching

| From        | Keys           | To     |
|-------------|----------------|--------|
| INSERT      | `Ctrl+Esc`     | NORMAL |
| NORMAL      | `i` or `Enter` | INSERT |
| NORMAL      | `r`            | RESIZE |
| NORMAL      | `m`            | MOVE   |
| RESIZE/MOVE | `Escape`       | NORMAL |

## Keybindings

### NORMAL Mode

**Navigation:**
- `h/j/k/l` - Move between panes (vim-style)
- `Tab` / `Shift+Tab` - Next/previous tab
- `1-9` - Switch to tab 1-9

**Pane Management:**
- `s` - Split horizontal (top/bottom)
- `v` - Split vertical (left/right)
- `x` - Close current pane (no confirmation)
- `f` - Toggle fullscreen/zoom

**Tabs/Windows:**
- `t` - New tab
- `n` - New window

**Scrolling:**
- `Ctrl+u` / `Ctrl+d` - Half page up/down
- `↑` / `↓` - Scroll one line up/down

**Other:**
- `[` - Copy mode (vim navigation, `v` select, `y` yank)
- `:` - Command palette

### RESIZE Mode

- `h/j/k/l` - Resize pane in direction (5 cells per press)
- `Escape` - Return to NORMAL

### MOVE Mode

- `h/k` - Rotate panes counter-clockwise
- `j/l` - Rotate panes clockwise
- `Escape` - Return to NORMAL

### INSERT Mode

All keys work normally - use for shell, editors, programs.

## Quick Workflow

```
Start → NORMAL (cyan)
  ↓ press 'i'
INSERT (green) → use shell/programs
  ↓ press 'Ctrl+Esc'
NORMAL → 's' to split, 'h/j/k/l' to navigate
  ↓ press 'r'
RESIZE (yellow) → 'h/j/k/l' to resize panes
  ↓ press 'Escape'
NORMAL → back to management
```

## Configuration

**File**: `~/.config/wezterm/wezterm.lua`

### Platform Detection

```lua
if is_linux then
  config.font_size = 10
elseif is_macos then
  config.font_size = 14
end
```

### Color Scheme

```lua
config.colors = {
  foreground = "#EAEAF2",
  background = "#16161E",
  cursor_bg = "#00F0FF",
  -- ANSI colors defined in config
}
```

## Platform-Specific

**Linux:**
- Wayland disabled for Hyprland compatibility
- Opacity controlled by compositor

**macOS:**
- Default shell: Fish from Homebrew

**Windows:**
- Default shell: PowerShell 7
- WSL Ubuntu domain configured

## Resources

- [WezTerm Documentation](https://wezfurlong.org/wezterm/)
- [Cyberpunk Palette](../color_palettes/cyberpunk/palette.html)
