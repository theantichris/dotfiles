# dotfiles // netrunner loadout

A cyberpunk/netrunner themed desktop environment built on Hyprland and Fish. Keyboard driven workflow with vim style navigation and cross platform compatibility. Theme inspired by [sddm-astronaut](https://github.com/Keyitdev/sddm-astronaut-theme) Cyberpunk theme.

![desktop](/screenshots/desktop.png)

## ✨ Highlights

- **Cyberpunk Aesthetic** - Unified magenta/cyan color scheme across all tools
- **Tiling Window Manager** - Hyprland with vim style navigation and smooth animations
- **Modern Development Stack** - LSP powered editing with Helix, Fish shell with custom prompt
- **Terminal Multiplexing** - WezTerm with built-in pane splitting and tab management
- **Cross Platform** - Configurations for Linux, macOS, and Windows managed with chezmoi
- **Comprehensive Tooling** - Preconfigured Git, Go, language servers, and formatters

## ⚡ Installation

> **Note:** These are my personal dotfiles. You'll need to update user specific information in configs like Git (name/email), paths, and any API keys or tokens.

### Prerequisites

- `git`
- `chezmoi`
- SSH keys configured with GitHub (for forking)

### Option 1: Fork and Use with Chezmoi (Recommended)

1. Fork this repository to your GitHub account
1. Install `git` and `chezmoi`
1. Generate SSH key: `ssh-keygen -t ed25519 -C "your_email@example.com"`
1. Add SSH key to GitHub
1. Run `chezmoi init <YOUR_USERNAME> --ssh`
1. Run `chezmoi apply`
1. Customize configs to your preferences

### Option 2: Manual Installation

1. Clone or download this repository
1. Copy desired config files to their destinations:
   - `dot_config/` contents → `~/.config/`
   - `dot_gitconfig` → `~/.gitconfig`
   - Other `dot_*` files → `~/.*` (remove `dot_` prefix)
1. Install tools from the Loadout section as needed

## ⌨️ Managing Configurations

| Task                           | Command                                  |
|--------------------------------|------------------------------------------|
| Initialize & apply (SSH)       | `chezmoi init <GITHUB_REPO> --apply`     |
| Pull updates                   | `chezmoi update`                         |
| Inspect changes                | `chezmoi diff`                           |
| Apply local changes            | `chezmoi apply`                          |
| Edit a tracked file            | `chezmoi edit <FILE>`                    |
| Start tracking a file          | `chezmoi add <FILE>`                     |
| Jump to source repo            | `chezmoi cd`                             |

## 🧰 Loadout

<details>
<summary><strong>Linux WM</strong></summary>

| Tool                                                               | Key Files (chezmoi paths) |
|--------------------------------------------------------------------|---------------------------|
| [Hyprland](https://hypr.land)                                      | `dot_config/hypr`         |
| [hyprcursor](https://github.com/hyprwm/hyprcursor)                 | -                         |
| [hypridle](https://github.com/hyprwm/hypridle)                     | -                         |
| [hyprlock](https://github.com/hyprwm/hyprlock)                     | -                         |
| [hyprpaper](https://github.com/hyprwm/hyprpaper)                   | -                         |
| [hyprpolkitagent](https://github.com/hyprwm/hyprpolkitagent)       | -                         |
| [hyprshot](https://github.com/Gustash/hyprshot)                    | -                         |
| [hyprshutdown](https://github.com/4lguna/hyprshutdown)             | -                         |
| [Waybar](https://github.com/Alexays/Waybar)                        | `dot_config/waybar`       |
| [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)     | `dot_config/swaync`       |
| [hyprlauncher](https://github.com/blacwulf/hyprlauncher)           | `dot_config/hypr`         |
| [wlogout](https://github.com/ArtsyMacaw/wlogout)                   | `dot_config/wlogout`      |
| [waypaper](https://github.com/anufrievroman/waypaper)              | -                         |
| [pwvucontrol](https://github.com/saivert/pwvucontrol)              | -                         |
| [sddm-astronaut](https://github.com/Keyitdev/sddm-astronaut-theme) | -                         |

</details>

<details>
<summary><strong>macOS WM</strong></summary>

| Tool                                                      | Key Files (chezmoi paths)      |
|-----------------------------------------------------------|--------------------------------|
| [AeroSpace](https://github.com/nikitabobko/AeroSpace)     | `dot_config/aerospace`         |
| [Karabiner](https://karabiner-elements.pqrs.org)          | `dot_config/private_karabiner` |
| [Raycast](https://www.raycast.com)                        | `dot_config/raycast`           |

</details>

<details>
<summary><strong>Shells</strong></summary>

| Tool                          | Key Files (chezmoi paths) |
|-------------------------------|---------------------------|
| [fish](https://fishshell.com) | `dot_config/fish`         |

</details>

<details>
<summary><strong>Terminals</strong></summary>

| Tool                                      | Key Files (chezmoi paths) |
|-------------------------------------------|---------------------------|
| [WezTerm](https://wezfurlong.org/wezterm) | `dot_config/wezterm`      |

</details>

<details>
<summary><strong>Editors</strong></summary>

| Tool                              | Key Files (chezmoi paths) |
|-----------------------------------|---------------------------|
| [Helix](https://helix-editor.com) | `dot_config/helix`        |

</details>

<details>
<summary><strong>File Management</strong></summary>

| Tool                                              | Key Files (chezmoi paths) |
|---------------------------------------------------|---------------------------|
| [Superfile](https://github.com/yorukot/superfile) | `dot_config/superfile`    |
| [eza](https://github.com/eza-community/eza)       | `dot_config/eza`          |
| [fd](https://github.com/sharkdp/fd)               | -                         |
| [fzf](https://github.com/junegunn/fzf)            | -                         |
| [gdu](https://github.com/dundee/gdu)              | -                         |
| [rclone](https://rclone.org)                      | -                         |

</details>

<details>
<summary><strong>Viewers</strong></summary>

| Tool                                          | Key Files (chezmoi paths) |
|-----------------------------------------------|---------------------------|
| [bat](https://github.com/sharkdp/bat)         | `dot_config/bat`          |
| [Glow](https://github.com/charmbracelet/glow) | `dot_config/glow`         |
| [jlv](https://github.com/hedhyw/jlv)          | -                         |
| [tldr](https://tldr.sh/)                      | -                         |

</details>

<details>
<summary><strong>System Monitor</strong></summary>

| Tool                                         | Key Files (chezmoi paths) |
|----------------------------------------------|---------------------------|
| [btop](https://github.com/aristocratos/btop) | -                         |
| [nvtop](https://github.com/Syllo/nvtop)      | -                         |

</details>

<details>
<summary><strong>Communication</strong></summary>

| Tool                                                | Key Files (chezmoi paths) |
|-----------------------------------------------------|---------------------------|
| [aerc](https://aerc-mail.org)                       | `dot_config/aerc`         |
| [gurk](https://github.com/boxdot/gurk-rs)           | -                         |
| [signal-desktop](https://signal.org)                | -                         |
| [slack-desktop](https://slack.com)                  | -                         |
| [Toot](https://github.com/ihabunek/toot)            | -                         |

</details>

<details>
<summary><strong>Notes/Tasks</strong></summary>

| Tool                             | Key Files (chezmoi paths) |
|----------------------------------|---------------------------|
| [nb](https://github.com/xwmx/nb) | `dot_nbrc.tmpl`           |

</details>

<details>
<summary><strong>Calendar</strong></summary>

| Tool                                     | Key Files (chezmoi paths) |
|------------------------------------------|-------------------------- |
| [khal](https://github.com/pimutils/khal) | `dot_config/khal`         |

</details>

<details>
<summary><strong>RSS</strong></summary>

| Tool                                      | Key Files (chezmoi paths) |
|-------------------------------------------|---------------------------|
| [nom](https://github.com/guyfedwards/nom) | `dot_config/nom`          |

</details>

<details>
<summary><strong>Dev Tools</strong></summary>

| Tool                                                    | Key Files (chezmoi paths)        |
|---------------------------------------------------------|----------------------------------|
| [Crush](https://github.com/charmbracelet/crush)         | `dot_config/crush`               |
| [doctl](https://docs.digitalocean.com/reference/doctl/) | -                                |
| [entr](https://github.com/eradman/entr)                 | -                                |
| [gh](https://cli.github.com)                            | `dot_config/gh`                  |
| [gh-dash](https://github.com/dlvhdr/gh-dash)            | `dot_config/gh-dash`             |
| [Git](https://git-scm.com)                              | `dot_gitconfig`, `dot_gitignore` |
| [git-delta](https://github.com/dandavison/delta)        | -                                |
| [GoReleaser](https://goreleaser.com)                    | -                                |
| [hugo](https://gohugo.io)                               | -                                |
| [lazygit](https://github.com/jesseduffield/lazygit)     | -                                |
| [Posting](https://github.com/darrenburns/posting)       | `dot_config/posting`             |
| [pre-commit](https://pre-commit.com)                    | -                                |

</details>

<details>
<summary><strong>Go Tools</strong></summary>

| Tool                                                                             | Key Files (chezmoi paths) |
|----------------------------------------------------------------------------------|---------------------------|
| [delve](https://github.com/go-delve/delve)                                       | -                         |
| [go-global-update](https://github.com/Gelio/go-global-update)                    | -                         |
| [gocovsh](https://github.com/orlangure/gocovsh)                                  | -                         |
| [goimports](https://pkg.go.dev/golang.org/x/tools/cmd/goimports)                 | -                         |
| [golangci-lint](https://golangci-lint.run)                                       | -                         |
| [golangci-lint-langserver](https://github.com/nametake/golangci-lint-langserver) | -                         |
| [gopls](https://pkg.go.dev/golang.org/x/tools/gopls)                             | -                         |
| [gotestsum](https://github.com/gotestyourself/gotestsum)                         | -                         |

</details>

<details>
<summary><strong>Python Tools</strong></summary>

| Tool                                      | Key Files (chezmoi paths) |
|-------------------------------------------|---------------------------|
| [uv](https://github.com/astral-sh/uv)     | -                         |

</details>

<details>
<summary><strong>Rust Tools</strong></summary>

| Tool                                                  | Key Files (chezmoi paths) |
|-------------------------------------------------------|---------------------------|
| [cargo-update](https://github.com/nabijaczleweli/cargo-update) | -                         |
| [rustup](https://rustup.rs)                           | -                         |

</details>

<details>
<summary><strong>LSP/Formatters</strong></summary>

| Tool                                                                             | Key Files (chezmoi paths) |
|----------------------------------------------------------------------------------|---------------------------|
| [bash-language-server](https://github.com/bash-lsp/bash-language-server)         | -                         |
| [codespell](https://github.com/codespell-project/codespell)                      | `dot_config/codespell`    |
| [harper](https://github.com/elijah-potter/harper)                                | `dot_config/harper`       |
| [jedi-language-server](https://github.com/pappasam/jedi-language-server)         | -                         |
| [lua-language-server](https://github.com/LuaLS/lua-language-server)              | -                         |
| [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)             | -                         |
| [marksman](https://github.com/artempyanykh/marksman)                             | -                         |
| [taplo](https://taplo.tamasfe.dev)                                               | -                         |
| [vscode-langservers](https://github.com/hrsh7th/vscode-langservers-extracted)    | -                         |
| [yaml-language-server](https://github.com/redhat-developer/yaml-language-server) | -                         |

</details>

<details>
<summary><strong>Utilities</strong></summary>

| Tool                                                    | Key Files (chezmoi paths) |
|---------------------------------------------------------|---------------------------|
| [chezmoi](https://www.chezmoi.io)                       | `dot_config/chezmoi`      |
| [cmatrix](https://github.com/abishekvashok/cmatrix)     | -                         |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | `dot_config/fastfetch`    |
| [ffmpeg](https://ffmpeg.org)                            | -                         |
| [freeze](https://github.com/charmbracelet/freeze)       | -                         |
| [HTTPie](https://httpie.io)                             | -                         |
| [jq](https://jqlang.github.io/jq)                       | -                         |
| [jqp](https://github.com/noahgorstein/jqp)              | -                         |
| [pass](https://www.passwordstore.org)                   | -                         |
| [rbonsai](https://gitlab.com/jallbrit/cbonsai)          | -                         |
| [speedtest-cli](https://github.com/sivel/speedtest-cli) | -                         |
| [squiid](https://github.com/pythops/squiid)             | -                         |
| [superseedr](https://github.com/dertuxmalwieder/superseedr) | -                     |
| [traytui](https://github.com/pythops/traytui)           | -                         |
| [ttyd](https://github.com/tsl0922/ttyd)                 | -                         |
| [vdirsyncer](https://github.com/pimutils/vdirsyncer)    | `dot_config/vdirsyncer`   |
| [vhs](https://github.com/charmbracelet/vhs)             | -                         |
| [xdg-terminal-exec](https://github.com/Vladimir-csp/xdg-terminal-exec) | -          |

</details>

<details>
<summary><strong>Weather</strong></summary>

| Tool                                              | Key Files (chezmoi paths) |
|---------------------------------------------------|---------------------------|
| [outside](https://github.com/BaconIsAVeg/outside) | `dot_config/outside`      |

</details>

<details>
<summary><strong>AI Tools</strong></summary>

| Tool                         | Key Files (chezmoi paths) |
|------------------------------|---------------------------|
| [Ollama](https://ollama.com) | -                         |

</details>

<details>
<summary><strong>Network</strong></summary>

| Tool                                             | Key Files (chezmoi paths) |
|--------------------------------------------------|---------------------------|
| [bandwhich](https://github.com/imsnif/bandwhich) | -                         |
| [bluetui](https://github.com/pythops/bluetui)    | -                         |
| [Tailscale](https://tailscale.com)               | -                         |

</details>

<details>
<summary><strong>Email</strong></summary>

| Tool                          | Key Files (chezmoi paths) |
|-------------------------------|---------------------------|
| [aerc](https://aerc-mail.org) | `dot_config/aerc`         |

</details>

<details>
<summary><strong>Font</strong></summary>

| Tool                                    | Key Files (chezmoi paths) |
|-----------------------------------------|---------------------------|
| [Nerd Fonts](https://www.nerdfonts.com) | -                         |

</details>

<details>
<summary><strong>Browsers</strong></summary>

| Tool                                               | Key Files (chezmoi paths)      |
|----------------------------------------------------|--------------------------------|
| [Chrome](https://www.google.com/chrome/)           | `dot_config/chrome-flags.conf` |
| [chawan](https://github.com/chawan-project/chawan) | `dot_config/chawan`            |

</details>

<details>
<summary><strong>Social</strong></summary>

| Tool                                     | Key Files (chezmoi paths) |
|------------------------------------------|---------------------------|
| [Toot](https://github.com/ihabunek/toot) | -                         |

</details>

<details>
<summary><strong>Security</strong></summary>

| Tool                                     | Key Files (chezmoi paths) |
|------------------------------------------|---------------------------|
| [Bitwarden](https://bitwarden.com/)      | -                         |
| [bitwarden-cli](https://bitwarden.com/help/cli/) | -                 |
| [pass](https://www.passwordstore.org)    | -                         |

</details>

<details>
<summary><strong>Themes</strong></summary>

| Tool                                                      | Key Files (chezmoi paths) |
|-----------------------------------------------------------|---------------------------|
| [breeze](https://github.com/KDE/breeze)                   | -                         |
| [breeze-gtk](https://github.com/KDE/breeze-gtk)           | -                         |
| [nwg-look](https://github.com/nwg-piotr/nwg-look)         | -                         |
| [rose-pine-hyprcursor](https://github.com/rose-pine/hyprcursor) | -                  |

</details>

<details>
<summary><strong>Audio/Video</strong></summary>

| Tool                                             | Key Files (chezmoi paths) |
|--------------------------------------------------|---------------------------|
| [pipewire](https://pipewire.org)                 | -                         |
| [wireplumber](https://pipewire.pages.freedesktop.org/wireplumber/) | -           |

</details>

## 📚 Documentation

### Linux

- [Hyprland](/documentation/HYPRLAND.md) - Window manager configuration (themes, animations, keybinds)
- [Waybar](/documentation/WAYBAR.md) - Status bar configuration (modules, styling, scripts)
- [Fish](/documentation/FISH.md) - Shell configuration (prompt, aliases, functions)
- [WezTerm](/documentation/WEZTERM.md) - Terminal configuration (colors, keybindings, multiplexing)
- [Helix](/documentation/HELIX.md) - Editor configuration (LSP, themes, keybindings)

### macOS

- [Aerospace](/documentation/AEROSPACE.md) - Window manager configuration
- [Karabiner](/documentation/KARABINER.md) - Keyboard customization

## 🪪 License

MIT
