# WezTerm Configuration

## Overview

Minimal terminal emulator with cyberpunk color scheme and cross-platform support.

### Visual Style

- **Cyberpunk Colors**: Magenta (#CA0174), cyan (#00F0FF), neon green (#00FF9C)
- **Dark Background**: #16161E with off-white text (#EAEAF2)
- **Cyan Cursor**: #00F0FF
- **Font**: Hack Nerd Font (10pt Linux, 14pt macOS)

## Keybindings

| Keys | Action |
|------|--------|
| `Alt+[` | Copy mode (vim navigation, `v` select, `y` yank) |
| `Alt+Shift+:` | Command palette |
| `Ctrl+Shift+D` | Split pane below |
| `Ctrl+Shift+H/J/K/L` | Navigate panes (vim-style) |
| `Ctrl+Shift+R` | Enter resize mode |
| `Ctrl+Shift+M` | Enter move mode |
| `Ctrl+Shift+F` | Toggle pane fullscreen (zoom) |

### Resize Mode

Press `Ctrl+Shift+R` to enter, `Escape` to exit.

| Keys | Action |
|------|--------|
| `H/h` | Shrink pane left |
| `J/j` | Shrink pane down |
| `K/k` | Grow pane up |
| `L/l` | Grow pane right |

### Move Mode

Press `Ctrl+Shift+M` to enter, `Escape` to exit.

| Keys | Action |
|------|--------|
| `H/h` | Rotate panes counter-clockwise |
| `L/l` | Rotate panes clockwise |

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
- Opacity controlled by compositor

**macOS:**
- Default shell: Fish from Homebrew

**Windows:**
- Default shell: PowerShell 7
- WSL Ubuntu domain configured

## Resources

- [WezTerm Documentation](https://wezfurlong.org/wezterm/)
- [Cyberpunk Palette](../color_palettes/cyberpunk/palette.html)
