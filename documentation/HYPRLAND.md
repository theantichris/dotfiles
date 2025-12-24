# Hyprland Configuration

## Overview

A cyberpunk/netrunner themed Hyprland setup featuring transparent windows with frosted glass blur, smooth animations, and a magenta/cyan color scheme. Designed for keyboard-driven workflow with vim-style navigation.

### Visual Style

- **HUD Aesthetic**: Semi-transparent windows (85%/75% opacity) with blur effects
- **Cyberpunk Colors**: Magenta (#CA0174) and cyan (#00F0FF) gradient borders
- **Smooth Animations**: Fast popin/slide transitions for windows and workspaces
- **Clean Layout**: 5px gaps, 12px rounded corners, 2px borders

## Installation

1. Install required packages:
   - [Hyprland](https://hyprland.org) - Window manager
   - [Waybar](https://github.com/Alexays/Waybar) - Status bar
   - [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) - Notifications
   - [hyprlauncher](https://github.com/blacwulf/hyprlauncher) - App launcher
   - [wlogout](https://github.com/ArtsyMacaw/wlogout) - Logout menu
   - [hyprlock](https://github.com/hyprwm/hyprlock) - Screen locker
   - [hypridle](https://github.com/hyprwm/hypridle) - Auto-lock manager
   - [hyprpaper](https://github.com/hyprwm/hyprpaper) - Wallpaper
2. Apply configuration with [chezmoi](https://www.chezmoi.io/) or manual move the files
3. Log out and select Hyprland from login screen
4. Press `SUPER + RETURN` to open terminal

## Essential Shortcuts

### Applications

| Shortcut          | Action              |
|-------------------|---------------------|
| `SUPER + RETURN`  | Terminal            |
| `SUPER + SPACE`   | App launcher        |
| `SUPER + E`       | File manager        |
| `SUPER + N`       | Notification center |

### Window Control

| Shortcut          | Action                          |
|-------------------|---------------------------------|
| `SUPER + Q`       | Close window                    |
| `SUPER + ;`       | Float/tile toggle               |
| `SUPER + F`       | Fullscreen toggle               |
| `SUPER + H/J/K/L` | Move focus (left/down/up/right) |

**Move window mode** - Press `SUPER + M` then:
- `H/J/K/L` - Move window in direction
- `ESC` - Exit move mode

**Resize window mode** - Press `SUPER + R` then:
- `H/L` - Resize horizontally (left/right)
- `K/J` - Resize vertically (up/down)
- `ESC` - Exit resize mode

### Workspaces

| Shortcut              | Action                   |
|-----------------------|--------------------------|
| `SUPER + 1-0`         | Switch to workspace 1-10 |
| `SUPER + SHIFT + 1-0` | Move window to workspace |

### Screenshots

| Shortcut        | Action                      |
|-----------------|-----------------------------|
| `PRINT`         | Screenshot (select region)  |
| `SUPER + PRINT` | Screenshot (current window) |

### Waybar Control

| Shortcut    | Action           |
|-------------|------------------|
| `SUPER + O` | Hide/show Waybar |
| `SUPER + P` | Reload Waybar    |

## Customization

### Changing Colors

The color scheme is defined in [`~/.config/hypr/theme.conf`](../dot_config/hypr/theme.conf).

### Changing Animations

In [`~/.config/hypr/theme.conf`](../dot_config/hypr/theme.conf), adjust the speed values (lower = faster). The second number in each animation line controls speed.

### Adjusting Transparency

Open [`~/.config/hypr/theme.conf`](../dot_config/hypr/theme.conf) and modify:
- `active_opacity` - Focused window transparency (0.0 = invisible, 1.0 = solid)
- `inactive_opacity` - Unfocused window transparency

### Blur Settings

Modify blur in [`~/.config/hypr/theme.conf`](../dot_config/hypr/theme.conf):
- `size` - How much blur (higher = more blurred)
- `passes` - Quality (higher = smoother but slower)
- `noise` - Film grain effect intensity

### Window Rules

Add custom rules in [`~/.config/hypr/windowrules.conf`](../dot_config/hypr/windowrules.conf) to control specific apps (floating, opacity, fullscreen, etc.).

Find an app's name with: `hyprctl clients`

### Custom Shortcuts

Edit [`~/.config/hypr/keybinds.conf`](../dot_config/hypr/keybinds.conf) to add or change keyboard shortcuts.

## Integrated Features

### Status Bar (Waybar)

- Network monitor with bandwidth
- GPU usage and temperature
- Storage space
- Weather widget
- System tray

Configuration: [`~/.config/waybar/`](../dot_config/waybar/)

### Notifications (SwayNC)

Terminal-style notification center with cyberpunk theme. Toggle with `SUPER + N`.

Configuration: [`~/.config/swaync/`](../dot_config/swaync/)

### App Launcher (hyprlauncher)

Fast, keyboard-driven app launcher. Press `SUPER + SPACE` to open.

### Logout Menu (wlogout)

Transparent menu for logout/shutdown/reboot. Semi-transparent to show desktop behind.

Configuration: [`~/.config/wlogout/`](../dot_config/wlogout/)

## Configuration Files

All settings are in `~/.config/hypr/`:

- `hyprland.conf` - Main file (imports all others)
- `theme.conf` - Colors, blur, shadows, animations
- `keybinds.conf` - Keyboard shortcuts
- `windowrules.conf` - Per-app rules
- `monitor.conf` - Display setup
- `input.conf` - Keyboard and mouse
- `environment.conf` - System variables
- `autostart.conf` - Apps that launch on startup

## Resources

- [Hyprland Wiki](https://wiki.hyprland.org) - Official documentation
- [Hyprland GitHub](https://github.com/hyprwm/Hyprland) - Source code and issues
- [Cyberpunk Palette](../color_palettes/cyberpunk/palette.html) - Color reference
