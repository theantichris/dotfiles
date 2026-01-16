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
