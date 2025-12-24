# dotfiles // netrunner loadout

chezmoi powered personal environment. keyboard-first. cross-platform.

![fastfetch](/screenshots/fastfetch.png)

![desktop](/screenshots/desktop.png)

## ⚡ Boot sequence (chezmoi)

1. Install `git` and `chezmoi`
1. Create ssh keys
1. Run `chezmoi init theantichris --ssh`
1. Run `chezmoi apply`

## ⌨️Common Tasks

| Task                           | Command                                  |
| ------------------------------ | ---------------------------------------- |
| Initialize & apply (SSH)       | `chezmoi init <GITHUB_REPO> --apply`     |
| Pull updates & re-apply        | `chezmoi update`                         |
| Inspect changes                | `chezmoi diff`                           |
| Apply local changes            | `chezmoi apply -v`                       |
| Edit a tracked file            | `chezmoi edit <FILE>`                    |
| Start tracking a file          | `chezmoi add <FILE>`                     |
| Jump to source repo            | `chezmoi cd`                             |

## 🧰 Loadout

| Category               | Tool                                                                             | Key Files (chezmoi paths)        |
| ---------------------- | -------------------------------------------------------------------------------- | -------------------------------- |
| **Linux WM**           | [Hyprland](https://hypr.land)                                                    | `dot_config/hypr`                |
|                        | [Waybar](https://github.com/Alexays/Waybar)                                      | `dot_config/waybar`              |
|                        | [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)                   | `dot_config/swaync`              |
|                        | [hyprlauncher](https://github.com/blacwulf/hyprlauncher)                         | `dot_config/hypr`                |
|                        | [wlogout](https://github.com/ArtsyMacaw/wlogout)                                 | `dot_config/wlogout`             |
| **macOS WM**           | [AeroSpace](https://github.com/nikitabobko/AeroSpace)                            | `dot_config/aerospace`           |
|                        | [Karabiner](https://karabiner-elements.pqrs.org)                                 | `dot_config/private_karabiner`   |
|                        | [Raycast](https://www.raycast.com)                                               | `dot_config/raycast`             |
| **Shells**             | [fish](https://fishshell.com)                                                    | `dot_config/fish`                |
| **Terminals**          | [WezTerm](https://wezfurlong.org/wezterm)                                        | `dot_config/wezterm`             |
| **Editors**            | [Helix](https://helix-editor.com)                                                | `dot_config/helix`               |
| **File Management**    | [Superfile](https://github.com/yorukot/superfile)                                | `dot_config/superfile`           |
|                        | [eza](https://github.com/eza-community/eza)                                      | `dot_config/eza`                 |
|                        | [fd](https://github.com/sharkdp/fd)                                              | -                                |
|                        | [fzf](https://github.com/junegunn/fzf)                                           | -                                |
| **Viewers**            | [bat](https://github.com/sharkdp/bat)                                            | `dot_config/bat`                 |
|                        | [Glow](https://github.com/charmbracelet/glow)                                    | `dot_config/glow`                |
|                        | [jlv](https://github.com/hedhyw/jlv)                                             | -                                |
|                        | [tldr](https://tldr.sh/)                                                         | -                                |
| **System Monitor**     | [btop](https://github.com/aristocratos/btop)                                     | -                                |
| **Notes/Tasks**        | [nb](https://github.com/xwmx/nb)                                                 | `dot_nbrc.tmpl`                  |
| **Calendar**           | [khal](https://github.com/pimutils/khal)                                         | `dot_config/khal`                |
| **RSS**                | [nom](https://github.com/guyfedwards/nom)                                        | `dot_config/nom`                 |
| **Dev Tools**          | [Crush](https://github.com/charmbracelet/crush)                                  | `dot_config/crush`               |
|                        | [doctl](https://docs.digitalocean.com/reference/doctl/)                          | -                                |
|                        | [entr](https://github.com/eradman/entr)                                          | -                                |
|                        | [gh](https://cli.github.com)                                                     | `dot_config/gh`                  |
|                        | [gh-dash](https://github.com/dlvhdr/gh-dash)                                     | `dot_config/gh-dash`             |
|                        | [Git](https://git-scm.com)                                                       | `dot_gitconfig`, `dot_gitignore` |
|                        | [GoReleaser](https://goreleaser.com)                                             | -                                |
|                        | [hugo](https://gohugo.io)                                                        | -                                |
|                        | [lazygit](https://github.com/jesseduffield/lazygit)                              | -                                |
|                        | [Posting](https://github.com/darrenburns/posting)                                | `dot_config/posting`             |
|                        | [pre-commit](https://pre-commit.com)                                             | -                                |
| **Go Tools**           | [delve](https://github.com/go-delve/delve)                                       | -                                |
|                        | [gocovsh](https://github.com/orlangure/gocovsh)                                  | -                                |
|                        | [goimports](https://pkg.go.dev/golang.org/x/tools/cmd/goimports)                 | -                                |
|                        | [golangci-lint](https://golangci-lint.run)                                       | -                                |
|                        | [golangci-lint-langserver](https://github.com/nametake/golangci-lint-langserver) | -                                |
|                        | [gopls](https://pkg.go.dev/golang.org/x/tools/gopls)                             | -                                |
|                        | [gotestsum](https://github.com/gotestyourself/gotestsum)                         | -                                |
| **LSP/Formatters**     | [bash-language-server](https://github.com/bash-lsp/bash-language-server)         | -                                |
|                        | [codespell](https://github.com/codespell-project/codespell)                      | `dot_config/codespell`           |
|                        | [harper](https://github.com/elijah-potter/harper)                                | `dot_config/harper`              |
|                        | [lua-language-server](https://github.com/LuaLS/lua-language-server)              | -                                |
|                        | [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)             | -                                |
|                        | [marksman](https://github.com/artempyanykh/marksman)                             | -                                |
|                        | [taplo](https://taplo.tamasfe.dev)                                               | -                                |
|                        | [vscode-langservers](https://github.com/hrsh7th/vscode-langservers-extracted)    | -                                |
|                        | [yaml-language-server](https://github.com/redhat-developer/yaml-language-server) | -                                |
| **Utilities**          | [chezmoi](https://www.chezmoi.io)                                                | `dot_config/chezmoi`             |
|                        | [fastfetch](https://github.com/fastfetch-cli/fastfetch)                          | `dot_config/fastfetch`           |
|                        | [ffmpeg](https://ffmpeg.org)                                                     | -                                |
|                        | [freeze](https://github.com/charmbracelet/freeze)                                | -                                |
|                        | [HTTPie](https://httpie.io)                                                      | -                                |
|                        | [jq](https://jqlang.github.io/jq)                                                | -                                |
|                        | [jqp](https://github.com/noahgorstein/jqp)                                       | -                                |
|                        | [ttyd](https://github.com/tsl0922/ttyd)                                          | -                                |
|                        | [vdirsyncer](https://github.com/pimutils/vdirsyncer)                             | `dot_config/vdirsyncer`          |
|                        | [vhs](https://github.com/charmbracelet/vhs)                                      | -                                |
| **Weather**            | [outside](https://github.com/BaconIsAVeg/outside)                                | `dot_config/outside`             |
| **AI Tools**           | [Ollama](https://ollama.com)                                                     | -                                |
| **Network**            | [bandwhich](https://github.com/imsnif/bandwhich)                                 | -                                |
|                        | [bluetui](https://github.com/pythops/bluetui)                                    | -                                |
|                        | [Tailscale](https://tailscale.com)                                               | -                                |
| **Email**              | [aerc](https://aerc-mail.org)                                                    | `dot_config/aerc`                |
| **Font**               | [Nerd Fonts](https://www.nerdfonts.com)                                          | -                                |
| **Browsers**           | [Chrome](https://www.google.com/chrome/)                                         | `dot_config/chrome-flags.conf`   |
|                        | [chawan](https://github.com/chawan-project/chawan)                               | `dot_config/chawan`              |
| **Social**             | [Toot](https://github.com/ihabunek/toot)                                         | -                                |
| **Security**           | [Bitwarden](https://bitwarden.com/)                                              | -                                |

## 📚 Documentation

- [Aerospace](/documentation/AEROSPACE.md) - Window manager configuration for macOS
- [Karabiner](/documentation/KARABINER.md) - Keyboard customization for macOS

## 🎨 Themes

Unified color schemes applied across all applications:

- **Cyberpunk** (active) - Neon blues, pinks, magentas with dark backgrounds
- **Cyberwave** (legacy) - Purple and blue tones

Theme files: `/color_palettes/[theme]/palette.html`

## 🪪 License

MIT
