# GlazeWM Config – Hyper Deck Setup (Windows)

This is my personal GlazeWM configuration for a **cyberpunk, keyboard-first workflow** that mirrors my macOS AeroSpace setup. **Hyper** is defined as `Ctrl+Alt+Shift+~` (Windows `oem_tilde`).

---

## ✨ Features

- **Hyper + WASD / Arrows** for directional focus movement
- **Move Mode** (Hyper+M) – move windows with bare WASD/Arrows until Esc/Enter
- **Resize Mode** (Hyper+R) – resize with WASD/Arrows (50px), **Shift** for fine (10px)
- **Workspaces** on Hyper+1/2/3 for quick context switching
- **Fullscreen toggle** (Hyper+F)
- **Reset workspace** (Hyper+0) – return to tiling + redraw
- **Float toggle** (Hyper+;) for the focused window
- **Tiling direction**: Hyper+H → horizontal, Hyper+V → vertical
- **Gaps**: inner 10px; outer top 50px, others 10px
- **Zebar** autostarts on WM launch and shuts down on WM exit
- **Cursor jump** to the focused monitor; **focus-follows-cursor** disabled
- **Ignore rules** for Zebar, PiP windows, some PowerToys/Lively/Office sub-windows

---

## 🎹 Chord Map (Quick Reference)

| Mode / Action   | Key(s)            | Result                                      |
| --------------- | ----------------- | ------------------------------------------- |
| **Main Mode**   | **Hyper + W / ↑** | Focus up                                    |
|                 | **Hyper + A / ←** | Focus left                                  |
|                 | **Hyper + S / ↓** | Focus down                                  |
|                 | **Hyper + D / →** | Focus right                                 |
|                 | **Hyper + 1/2/3** | Switch workspaces                           |
|                 | **Hyper + H / V** | Set tiling direction: horizontal / vertical |
|                 | **Hyper + F**     | Toggle fullscreen                           |
|                 | **Hyper + 0**     | Reset layout (tiling + redraw)              |
|                 | **Hyper + ;**     | Toggle float ↔ tile                         |
|                 | **Hyper + M**     | Enter **Move Mode**                         |
|                 | **Hyper + R**     | Enter **Resize Mode**                       |
|                 | **Hyper + Enter** | Launch Warp                                 |
| **Move Mode**   | W/A/S/D or Arrows | Move focused window                         |
|                 | Esc / Enter       | Exit Move Mode                              |
| **Resize Mode** | W/A/S/D or Arrows | Resize ±50px                                |
|                 | Shift + W/A/S/D   | Fine resize ±10px                           |
|                 | Esc / Enter       | Exit Resize Mode                            |

---

## 🔑 Keybindings

- `Hyper + W/A/S/D` (or `↑/←/↓/→`) → `focus --direction ...`
- `Hyper + 1/2/3` → `focus --workspace 1/2/3`
- `Hyper + H` → `set-tiling-direction horizontal`
- `Hyper + V` → `set-tiling-direction vertical`
- `Hyper + F` → `toggle-fullscreen`
- `Hyper + 0` → `set-tiling`, then `wm-redraw` (reset layout)
- `Hyper + ;` → `toggle-floating`
- `Hyper + M` → `wm-enable-binding-mode --name move`
- `Hyper + R` → `wm-enable-binding-mode --name resize`
- `Hyper + Enter` → `shell-exec .../Warp.exe`

### Binding modes

- **Move Mode**
  - `W/A/S/D` or `↑/←/↓/→` → `move --direction ...`
  - `Esc` / `Enter` → `wm-disable-binding-mode --name move`
- **Resize Mode**
  - `W/A/S/D` or `↑/←/↓/→` → `resize --height/--width ±50px`
  - `Shift + W/A/S/D` → `resize ... ±10px`
  - `Esc` / `Enter` → `wm-disable-binding-mode --name resize`

---

## 🧠 Behavior & Effects (high-level)

- **Initial state:** tiling (floating is centered & on top; fullscreen on top)
- **Focused border:** `#8dbcff`; **other windows border:** `#a1a1a1`
- **Hide method on workspace switch:** cloak
- **Taskbar:** do not show all windows

---

## 📂 Files

- `glazewm/config.yaml` — the config file (tracked in dotfiles; applied via chezmoi)

---

## 📖 Notes

- “Hyper” here is a Windows chord: `Ctrl+Alt+Shift+~` (oem_tilde).
- Zebar is started with `startup_commands` and terminated with `shutdown_commands`.
