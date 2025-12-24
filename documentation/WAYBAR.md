# Waybar Configuration

## Overview

A cyberpunk/netrunner themed status bar for Hyprland featuring system monitoring, workspace indicators, and interactive widgets. Displays network bandwidth, GPU temperature, storage, weather, and media controls with a dark, neon-accented aesthetic.

### Visual Style

- **Cyberpunk Colors**: Magenta (#CA0174) and cyan (#00F0FF) accents
- **Dark Background**: Panel background (#1F1F28) on transparent base
- **Rounded Corners**: 10px border radius for modern look
- **Monospace Font**: KogniGear and Hack Nerd Font
- **State Colors**: Green (normal), yellow (warning), red (critical)

## Getting Started

### Installation

1. Install required packages:
   - [Waybar](https://github.com/Alexays/Waybar) - Status bar
   - [outside](https://github.com/BaconIsAVeg/outside) - Weather widget
   - [bandwhich](https://github.com/imsnif/bandwhich) - Network monitor
   - [bluetui](https://github.com/pythops/bluetui) - Bluetooth TUI
   - [btop](https://github.com/aristocratos/btop) - System monitor
   - [gdu](https://github.com/dundee/gdu) - Disk usage analyzer
   - [ikhal](https://github.com/pimutils/khal) - Calendar
   - [pwvucontrol](https://github.com/saivert/pwvucontrol) - Volume control

2. Apply configuration: `chezmoi apply` or copy the files
3. Waybar auto-starts with Hyprland
4. Reload config: `SUPER + O`

### Module Overview

**Left side**: Time/date, weather, media player
**Center**: Workspace indicators
**Right side**: Mode indicator (move/resize), system stats, network, Bluetooth, volume, notifications, power menu

## Module Features

### Clock & Calendar

- **Format**: 12-hour time with date (e.g., "3:45 PM  Mon 24 Dec")
- **Interactive**: Click to open ikhal calendar
- **Scroll**: Navigate months in calendar tooltip
- **Colors**: Cyan for month, magenta for today

### Weather (outside)

- **Updates**: Every 10 minutes
- **Click**: Opens detailed weather view in outside
- **States**:
  - Hot weather shows red
  - Cold weather shows blue
  - Rain/snow/fog blinks for visibility

### Media Player

- **Shows**: Currently playing track/artist
- **Max length**: 40 characters
- **Updates**: Real-time via playerctl

### Workspaces

- **Persistent**: Always shows workspaces 1-10
- **Active**: Highlighted in magenta
- **Click**: Switch to workspace

### Submap Indicator

- **Shows**: Active Hyprland mode (move/resize)
- **Color**: Magenta when active
- **Hidden**: When in normal mode

### System Monitoring

**Storage**:
- Shows available disk space
- Click to open gdu disk analyzer
- Warning at 20GB free, critical at 10GB

**Memory**:
- Shows RAM usage percentage
- Click to open btop
- Warning at 70%, critical at 90%

**CPU**:
- Shows CPU usage percentage
- Updates every second
- Click to open btop
- Warning at 70%, critical at 90%

**Temperature**:
- Shows CPU temperature
- Dynamic icon based on heat level
- Warning at 70°C, critical at 85°C

**GPU** (NVIDIA):
- Shows GPU temperature
- Click to open nvtop GPU monitor
- Warning at 70°C, critical at 85°C
- Displays "GPU N/A" if no NVIDIA card detected

### Network

- **WiFi**: Shows signal strength icon and download speed
- **Ethernet**: Shows wired icon and download speed
- **Tooltip**: SSID, IP, up/down bandwidth
- **Click**: Opens bandwhich network monitor
- **Right-click**: Opens nmtui network manager

### Bluetooth

- **Icons**:
  - Disabled: Gray
  - On: Blue
  - Connected: Shows device count
  - Battery: Shows device battery percentage
- **Click**: Opens bluetui Bluetooth manager

### System Tray

- **Shows**: Background application icons (network managers, volume controls, etc.)
- **Icon size**: 15px
- **Click**: Application-specific actions (varies by app)

### Volume (Wireplumber)

- **Shows**: Volume percentage with icon
- **Muted**: Shows muted icon
- **Click**: Opens pwvucontrol
- **Right-click**: Opens hyprpwcenter

### Notifications (SwayNC)

- **Icons**:
  - No notifications: Bell icon
  - Has notifications: Bell with indicator (magenta)
  - Do Not Disturb: Different bell icon
- **Click**: Toggle notification center (opens/closes)
- **Right-click**: Toggle Do Not Disturb mode

### Power Menu

- **Icon**: Power symbol
- **Click**: Opens wlogout menu (shutdown/reboot/logout)

## Control Shortcuts

| Action                 | Method                  |
|------------------------|-------------------------|
| Reload Waybar          | `SUPER + O`             |
| Toggle Waybar          | `SUPER + P`             |
| Open network monitor   | Click network module    |
| Open system monitor    | Click CPU/memory/temp   |
| Open GPU monitor       | Click GPU module        |
| Open disk analyzer     | Click storage module    |
| Open calendar          | Click clock             |
| Open volume control    | Click volume icon       |
| Open Bluetooth manager | Click Bluetooth icon    |
| Toggle notifications   | Click notification icon |

## Customization

### Changing Colors

Edit [`~/.config/waybar/style.css`](../dot_config/waybar/style.css) to modify the color scheme:

- `@define-color accent-primary` - Main accent (magenta)
- `@define-color accent-secondary` - Secondary accent (cyan)
- `@define-color bg-panel` - Module background
- `@define-color text-primary` - Main text color
- `@define-color text-muted` - Inactive text

Use the cyberpunk palette at [`color_palettes/cyberpunk/palette.html`](../color_palettes/cyberpunk/palette.html) for reference.

### Adding Modules

Edit [`~/.config/waybar/config.jsonc`](../dot_config/waybar/config.jsonc):

1. Add module name to `modules-left`, `modules-center`, or `modules-right`
2. Add module configuration block
3. Reload Waybar: `SUPER + O`

### Adjusting Module Order

Rearrange module names in the `modules-left`, `modules-center`, and `modules-right` arrays in [`config.jsonc`](../dot_config/waybar/config.jsonc).

### Threshold Values

Modify warning/critical thresholds in [`config.jsonc`](../dot_config/waybar/config.jsonc):

- CPU/Memory: `warning: 70`, `critical: 90`
- Temperature: `warning: 70`, `critical: 85`
- GPU: Edit [`~/.config/waybar/modules/gpu.sh`](../dot_config/waybar/modules/gpu.sh)
- Storage: Edit [`~/.config/waybar/modules/storage.sh`](../dot_config/waybar/modules/storage.sh)

### Module Spacing

Edit [`config.jsonc`](../dot_config/waybar/config.jsonc):
- `spacing` - Gap between modules
- `margin-left` / `margin-right` - Bar margins from screen edges
- `margin-bottom` - Gap from top of screen

### Font Settings

Edit [`style.css`](../dot_config/waybar/style.css):
- `font-family` - Font names
- `font-size` - Module text size
- `font-weight` - Text weight (bold/normal)

## Custom Scripts

### Storage Monitor

Location: [`~/.config/waybar/modules/storage.sh`](../dot_config/waybar/modules/storage.sh)

Monitors root filesystem `/` and returns available space. Shows warning when under 20GB, critical when under 10GB.

### GPU Monitor

Location: [`~/.config/waybar/modules/gpu.sh`](../dot_config/waybar/modules/gpu.sh)

Monitors NVIDIA GPU temperature using `nvidia-smi`. Shows warning at 70°C, critical at 85°C. Displays "GPU N/A" if no GPU detected.

## Configuration Files

All settings in `~/.config/waybar/`:

- `config.jsonc` - Module configuration and layout
- `style.css` - Colors, fonts, spacing
- `modules/` - Custom scripts
  - `storage.sh` - Disk space monitor
  - `gpu.sh` - GPU temperature monitor
  - `cpu_temp.sh` - CPU temperature
  - `mail.py` - Email notifications

## Resources

- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki) - Official documentation
- [Waybar GitHub](https://github.com/Alexays/Waybar) - Source code and issues
- [Cyberpunk Palette](../color_palettes/cyberpunk/palette.html) - Color reference
- [Hyprland Documentation](HYPRLAND.md) - Window manager setup
