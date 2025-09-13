# AeroSpace Config – Hyper Deck Setup

This is my personal [AeroSpace](https://nikitabobko.github.io/AeroSpace/) configuration for macOS, tuned for a **cyberpunk, keyboard-first workflow** using a Hyper key (Caps Lock mapped to `⌃⌥⌘⇧`).

---

## ✨ Features

- **Hyper + WASD / Arrow keys** for directional focus movement
- **Move Mode** (Hyper+M) – move windows with bare WASD/Arrows until Esc
- **Resize Mode** (Hyper+R) – resize windows with bare WASD/Arrows, with fine-grained Shift steps
- **Workspaces** on Hyper+1/2/3 for quick context switching
- **Fullscreen toggle** (Hyper+F)
- **Reset workspace** (Hyper+0) – flatten, balance, and reset layout to tiles+horizontal
- **Float toggle** (Hyper+;) for the focused window
- **Auto-floating rules** for common apps like Finder, Calendar, Mail, Slack, Zoom, etc.
- **Gaps** of 10px for an industrial, grid-like aesthetic
- **Nested layouts**: split a vertical column horizontally (or vice versa) for flexible tiling

---

## 🎹 Chord Map (Quick Reference)

| Mode / Action   | Key(s)            | Result                              |
| --------------- | ----------------- | ----------------------------------- |
| **Main Mode**   | Hyper + W / ↑     | Focus up                            |
|                 | Hyper + A / ←     | Focus left                          |
|                 | Hyper + S / ↓     | Focus down                          |
|                 | Hyper + D / →     | Focus right                         |
|                 | Hyper + 1/2/3     | Switch workspaces                   |
|                 | Hyper + H         | Set container layout → horizontal   |
|                 | Hyper + V         | Set container layout → vertical     |
|                 | Hyper + F         | Toggle fullscreen                   |
|                 | Hyper + 0         | Reset workspace (flatten + balance) |
|                 | Hyper + ;         | Toggle float ↔ tile                 |
|                 | Hyper + M         | Enter **Move Mode**                 |
|                 | Hyper + R         | Enter **Resize Mode**               |
| **Move Mode**   | W/A/S/D or Arrows | Move focused window                 |
|                 | Esc               | Exit Move Mode                      |
| **Resize Mode** | W/A/S/D or Arrows | Grow/shrink window (50px steps)     |
|                 | Shift + W/A/S/D   | Fine resize (10px steps)            |
|                 | Esc               | Exit Resize Mode                    |

---

### 🔧 Notes

- **Modes stick** until `Esc`.
- **Nested splits**: In a vertical workspace, focus a column and use **Hyper+H** to split it horizontally.
- **Service keys** (like flatten/balance) keep layouts tidy when things get messy.

## 🔑 Keybindings

### Main Mode

- `Hyper + W/A/S/D` → focus up/left/down/right
- `Hyper + ↑/←/↓/→` → focus with arrows
- `Hyper + 1/2/3` → switch workspaces
- `Hyper + F` → toggle fullscreen
- `Hyper + 0` → reset current workspace
- `Hyper + ;` → toggle focused window float/tiling
- `Hyper + M` → enter Move mode
- `Hyper + R` → enter Resize mode
- `Hyper + H` → set focused container layout **horizontal**
- `Hyper + V` → set focused container layout **vertical**

### Move Mode

- `W/A/S/D` or `↑/←/↓/→` → move focused window
- `Esc` → return to Main mode

### Resize Mode

- `W/A/S/D` or `↑/←/↓/→` → grow/shrink window by 50px
- `Shift + W/A/S/D` → fine resize by 10px
- `Esc` → return to Main mode

---

## 🚀 Usage Notes

- **Hyper key** is mapped via Karabiner-Elements (Right Command → ⌃⌥⌘⇧).
- **Move Mode** and **Resize Mode** are sticky until you hit `Esc`.
- **Reset (Hyper+0)** is your “clean slate” when layouts get messy.
- To **split a vertical column horizontally**:
  1. Set the workspace to vertical (`Hyper+Space` or `Hyper+V`).
  2. Move apps into left and right columns with Move Mode.
  3. Focus the left (or right) column.
  4. Press `Hyper+H` → that column now splits horizontally inside the vertical layout.
- You can nest layouts arbitrarily: vertical workspaces containing horizontal splits, and vice versa.
- Customize app IDs in the `[[on-window-detected]]` sections with `aerospace list-apps` if needed.

---

## 📂 Files

- `aerospace.toml` – the config file (in `~/.config/aerospace/`)
- `README.md` – this documentation

---

## 📖 References

- [AeroSpace Docs](https://nikitabobko.github.io/AeroSpace/)
- [Keybinding Reference](https://nikitabobko.github.io/AeroSpace/keybindings)
- [Commands Reference](https://nikitabobko.github.io/AeroSpace/commands)
