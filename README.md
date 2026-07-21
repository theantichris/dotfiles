# dotfiles // netrunner loadout

A cyberpunk/netrunner themed, keyboard-driven environment managed with
[chezmoi](https://www.chezmoi.io). One source tree renders per-machine configs
for three targets:

- **CachyOS Linux** — Hyprland desktop
- **macOS** — CLI stack + GUI apps via Homebrew
- **Android** — Termux

## ✨ Highlights

- **Unified cyberpunk palette** — the same hardcoded color scheme is carried
  across the shell prompt, Git, the Claude Code statusline, and every TUI. The
  canonical reference lives in [`color_palettes/cyberpunk/palette.html`](color_palettes/cyberpunk/palette.html).
- **Hyprland desktop** — configured in Lua, driven by
  [noctalia-shell](https://github.com/noctalia-dev/noctalia-shell) (a Quickshell
  desktop shell that provides the bar, launcher, control center, notifications,
  lock screen, wallpaper, and screenshot toolkit).
- **Fish shell** with a custom cyberpunk prompt and per-OS branching.
- **Helix + language servers** for LSP-powered editing.
- **Cross-platform templating** — a single repo that renders correctly on Linux,
  macOS, and Termux from `.chezmoi.os` / `.chezmoi.osRelease.id`.

## ⚡ Installation

> **Note:** These are my personal dotfiles. You'll need to update user-specific
> information in configs like Git (name/email), backup remotes, paths, and any
> API keys or tokens.

### Prerequisites

- `git`
- `chezmoi`
- SSH keys configured with GitHub (for forking)

### Fork and use with chezmoi

1. Fork this repository to your GitHub account
1. Install `git` and `chezmoi`
1. Generate an SSH key: `ssh-keygen -t ed25519 -C "your_email@example.com"`
1. Add the SSH key to GitHub
1. Run `chezmoi init <YOUR_USERNAME> --ssh`
1. Run `chezmoi apply`
1. Customize configs to your preferences

On first `apply`, the OS-specific install script
(`.chezmoiscripts/run_onchange_*install-packages-<os>.sh.tmpl`) installs the
matching toolchain for your platform.

## ⌨️ Managing configurations

| Task                     | Command                              |
|--------------------------|--------------------------------------|
| Initialize & apply (SSH) | `chezmoi init <GITHUB_REPO> --apply` |
| Pull updates             | `chezmoi update`                     |
| Inspect changes          | `chezmoi diff`                       |
| Apply local changes      | `chezmoi apply`                      |
| Render one file          | `chezmoi cat <FILE>`                 |
| Edit a tracked file      | `chezmoi edit <FILE>`                |
| Start tracking a file    | `chezmoi add <FILE>`                 |
| Jump to source repo      | `chezmoi cd`                         |

## 🧰 Loadout

<details open>
<summary><strong>Desktop — Linux / CachyOS</strong></summary>

| Tool                                                              | Key Files (chezmoi paths) |
|-------------------------------------------------------------------|---------------------------|
| [Hyprland](https://hypr.land)                                     | `dot_config/hypr`         |
| [noctalia-shell](https://github.com/noctalia-dev/noctalia-shell)  | `dot_config/hypr/noctalia`|
| [cliphist](https://github.com/sentriz/cliphist)                   | -                         |

Hyprland is configured in Lua — `hyprland.lua` loads the modules under
`dot_config/hypr/config/*.lua` (keybinds, animations, window rules, monitors,
autostart, …). Default apps: `kitty`, `dolphin`, `google-chrome`, `helix`,
`gnome-calculator`.

</details>

<details>
<summary><strong>Shell &amp; Terminal</strong></summary>

| Tool                                    | Key Files (chezmoi paths) |
|-----------------------------------------|---------------------------|
| [fish](https://fishshell.com)           | `dot_config/fish`         |
| [kitty](https://sw.kovidgoyal.net/kitty)| `dot_config/kitty`        |

Termux ships its own terminal config under `dot_termux`.

</details>

<details>
<summary><strong>Editor &amp; Language Servers</strong></summary>

| Tool                                                                             | Key Files (chezmoi paths) |
|----------------------------------------------------------------------------------|---------------------------|
| [Helix](https://helix-editor.com)                                                | `dot_config/helix`        |
| [bash-language-server](https://github.com/bash-lsp/bash-language-server)         | -                         |
| [lua-language-server](https://github.com/LuaLS/lua-language-server)              | -                         |
| [marksman](https://github.com/artempyanykh/marksman)                             | -                         |
| [taplo](https://taplo.tamasfe.dev)                                               | -                         |
| [typos-lsp](https://github.com/tekumara/typos-lsp)                               | -                         |
| [vscode-langservers](https://github.com/hrsh7th/vscode-langservers-extracted)    | -                         |
| [yaml-language-server](https://github.com/redhat-developer/yaml-language-server) | -                         |

</details>

<details>
<summary><strong>Files, Viewers &amp; Monitoring</strong></summary>

| Tool                                                    | Key Files (chezmoi paths)      |
|---------------------------------------------------------|--------------------------------|
| [Superfile](https://github.com/yorukot/superfile)       | `dot_config/private_superfile` |
| [eza](https://github.com/eza-community/eza)             | `dot_config/eza`               |
| [fd](https://github.com/sharkdp/fd)                     | -                              |
| [entr](https://github.com/eradman/entr)                 | -                              |
| [bat](https://github.com/sharkdp/bat)                   | `dot_config/bat`               |
| [glow](https://github.com/charmbracelet/glow)           | `dot_config/private_glow`      |
| [tldr](https://tldr.sh/)                                | -                              |
| [btop](https://github.com/aristocratos/btop)            | `dot_config/btop`              |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | `dot_config/fastfetch`         |

</details>

<details>
<summary><strong>Git &amp; Dev</strong></summary>

| Tool                                                                 | Key Files (chezmoi paths)             |
|----------------------------------------------------------------------|---------------------------------------|
| [Git](https://git-scm.com)                                           | `dot_gitconfig.tmpl`, `dot_gitignore` |
| [git-delta](https://github.com/dandavison/delta)                     | -                                     |
| [gh](https://cli.github.com)                                         | - (macOS)                             |
| [pre-commit](https://pre-commit.com)                                 | -                                     |
| [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2) | -                                     |
| [GoReleaser](https://goreleaser.com)                                 | -                                     |
| [vhs](https://github.com/charmbracelet/vhs)                          | -                                     |
| [hugo](https://gohugo.io)                                            | - (macOS)                             |
| [Crush](https://github.com/charmbracelet/crush)                      | `dot_config/crush`                    |
| [Claude Code](https://claude.com/claude-code)                        | `dot_claude`                          |

</details>

<details>
<summary><strong>Go Toolchain</strong></summary>

| Tool                                                                             | Key Files (chezmoi paths) |
|----------------------------------------------------------------------------------|---------------------------|
| [go](https://go.dev) / [gopls](https://pkg.go.dev/golang.org/x/tools/gopls)      | -                         |
| [delve](https://github.com/go-delve/delve)                                       | -                         |
| [golangci-lint](https://golangci-lint.run)                                       | -                         |
| [golangci-lint-langserver](https://github.com/nametake/golangci-lint-langserver) | -                         |
| [goimports](https://pkg.go.dev/golang.org/x/tools/cmd/goimports)                 | -                         |
| [gocovsh](https://github.com/orlangure/gocovsh)                                  | -                         |
| [go-global-update](https://github.com/Gelio/go-global-update)                    | -                         |
| [cobra-cli](https://github.com/spf13/cobra-cli)                                  | -                         |
| [ghost](https://github.com/theantichris/ghost)                                   | -                         |

</details>

<details>
<summary><strong>Rust Tools</strong></summary>

| Tool                                                           | Key Files (chezmoi paths) |
|----------------------------------------------------------------|---------------------------|
| [rustup](https://rustup.rs)                                    | -                         |
| [cargo-update](https://github.com/nabijaczleweli/cargo-update) | -                         |
| [outside](https://github.com/BaconIsAVeg/outside)              | `dot_config/outside`      |

</details>

<details>
<summary><strong>Notes, News &amp; Productivity</strong></summary>

| Tool                                                    | Key Files (chezmoi paths)    |
|---------------------------------------------------------|------------------------------|
| [clin](https://github.com/reekta92/clin-rs)             | `dot_config/clin`            |
| [Toney](https://github.com/SourcewareLab/Toney)         | `dot_config/toney` (Android) |
| [linear-tui](https://github.com/roeyazroel/linear-tui)  | `dot_linear-tui`             |
| [golazo](https://github.com/0xjuanma/golazo)            | `dot_config/golazo`          |
| [newsboat](https://newsboat.org)                        | `dot_config/newsboat`        |

</details>

<details>
<summary><strong>Communication</strong></summary>

| Tool                                            | Key Files (chezmoi paths) |
|-------------------------------------------------|---------------------------|
| [oxicord](https://github.com/linuxmobile/oxicord) | `dot_config/oxicord`    |
| [matcha](https://github.com/floatpane/matcha)   | -                         |
| [slack-desktop](https://slack.com)              | -                         |

</details>

<details>
<summary><strong>Utilities &amp; System</strong></summary>

| Tool                                                                                  | Key Files (chezmoi paths) |
|---------------------------------------------------------------------------------------|---------------------------|
| [chezmoi](https://www.chezmoi.io)                                                     | -                         |
| [Tailscale](https://tailscale.com)                                                    | -                         |
| [Bitwarden](https://bitwarden.com) / [bitwarden-cli](https://bitwarden.com/help/cli/) | -                         |
| [Ollama](https://ollama.com)                                                          | -                         |
| [speedtest-cli](https://github.com/sivel/speedtest-cli)                               | -                         |
| [cmatrix](https://github.com/abishekvashok/cmatrix)                                   | -                         |
| [Nerd Fonts](https://www.nerdfonts.com)                                               | -                         |
| [qFlipper](https://flipperzero.one)                                                   | -                         |

</details>

<details>
<summary><strong>macOS GUI (Homebrew casks)</strong></summary>

| App                                              | Cask                  |
|--------------------------------------------------|-----------------------|
| [Bitwarden](https://bitwarden.com)               | `bitwarden`           |
| [Notion](https://www.notion.so)                  | `notion`              |
| [Seafile](https://www.seafile.com)               | `seafile-client`      |
| [Surfshark](https://surfshark.com)               | `surfshark`           |
| [Battle.net](https://www.blizzard.com)           | `battle-net`          |
| [UHK Agent](https://ultimatehackingkeyboard.com) | `uhk-agent`           |
| [qFlipper](https://flipperzero.one)              | `qflipper`            |
| [Hack Nerd Font](https://www.nerdfonts.com)      | `font-hack-nerd-font` |

The full macOS package set lives in [`dot_Brewfile`](dot_Brewfile).

</details>

## 🎨 Color system

The whole environment shares one hardcoded cyberpunk palette. The canonical
reference — backgrounds, text, accents, semantic, syntax, and terminal colors
with hex values — is [`color_palettes/cyberpunk/palette.html`](color_palettes/cyberpunk/palette.html).

The values are **duplicated** (not shared) across the Fish prompt
(`dot_config/fish/functions/fish_prompt.fish`), the Claude Code statusline
(`dot_claude/executable_statusline-cyberpunk.sh`), the Git config
(`dot_gitconfig.tmpl`), and the clin theme (`dot_config/clin/themes`). Change
one, change all.

## 🪪 License

MIT
