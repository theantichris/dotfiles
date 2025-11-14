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
|                        | [Mako](https://github.com/emersion/mako)                                         | `dot_config/mako`                |
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
| **Viewers**            | [Glow](https://github.com/charmbracelet/glow)                                    | `dot_config/glow`                |
|                        | [bat](https://github.com/sharkdp/bat)                                            | `dot_config/bat`                 |
|                        | [jlv](https://github.com/hedhyw/jlv)                                             | -                                |
|                        | [tldr](https://tldr.sh/)                                                         | -                                |
| **System Monitor**     | [btop](https://github.com/aristocratos/btop)                                     | -                                |
| **Notes/Tasks**        | [nb](https://github.com/xwmx/nb)                                                 | `dot_nbrc.tmpl`                  |
| **Calendar**           | [calcure](https://github.com/anufrievroman/calcure)                              | `dot_config/calcure`             |
| **RSS**                | [nom](https://github.com/guyfedwards/nom)                                        | `dot_config/nom`                 |
| **Dev Tools**          | [Git](https://git-scm.com)                                                       | `dot_gitconfig`, `dot_gitignore` |
|                        | [gh](https://cli.github.com)                                                     | `dot_config/gh`                  |
|                        | [gh-dash](https://github.com/dlvhdr/gh-dash)                                     | `dot_config/gh-dash`             |
|                        | [OpenCode](https://opencode.ai)                                                  | `dot_config/opencode`            |
|                        | [pre-commit](https://pre-commit.com)                                             | -                                |
|                        | [GoReleaser](https://goreleaser.com)                                             | -                                |
|                        | [lazygit](https://github.com/jesseduffield/lazygit)                              | -                                |
|                        | [hugo](https://gohugo.io)                                                        | -                                |
|                        | [entr](https://github.com/eradman/entr)                                          | -                                |
|                        | [doctl](https://docs.digitalocean.com/reference/doctl/)                          | -                                |
|                        | [Posting](https://github.com/darrenburns/posting)                                | `dot_config/posting`             |
| **Go Tools**           | [gopls](https://pkg.go.dev/golang.org/x/tools/gopls)                             | -                                |
|                        | [delve](https://github.com/go-delve/delve)                                       | -                                |
|                        | [goimports](https://pkg.go.dev/golang.org/x/tools/cmd/goimports)                 | -                                |
|                        | [golangci-lint](https://golangci-lint.run)                                       | -                                |
|                        | [golangci-lint-langserver](https://github.com/nametake/golangci-lint-langserver) | -                                |
|                        | [gocovsh](https://github.com/orlangure/gocovsh)                                  | -                                |
|                        | [gotestsum](https://github.com/gotestyourself/gotestsum)                         | -                                |
| **LSP/Formatters**     | [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)             | _                                |
|                        | [marksman](https://github.com/artempyanykh/marksman)                             | -                                |
|                        | [taplo](https://taplo.tamasfe.dev)                                               | -                                |
|                        | [harper](https://github.com/elijah-potter/harper)                                | `dot_config/harper`              |
|                        | [codespell](https://github.com/codespell-project/codespell)                      | `dot_config/codespell`           |
|                        | [bash-language-server](https://github.com/bash-lsp/bash-language-server)         | -                                |
|                        | [vscode-langservers](https://github.com/hrsh7th/vscode-langservers-extracted)    | -                                |
|                        | [yaml-language-server](https://github.com/redhat-developer/yaml-language-server) | -                                |
|                        | [lua-language-server](https://github.com/LuaLS/lua-language-server)              | -                                |
| **Utilities**          | [jq](https://jqlang.github.io/jq)                                                | -                                |
|                        | [jqp](https://github.com/noahgorstein/jqp)                                       | -                                |
|                        | [HTTPie](https://httpie.io)                                                      | -                                |
|                        | [freeze](https://github.com/charmbracelet/freeze)                                | -                                |
|                        | [crush](https://github.com/charmbracelet/crush)                                  | -                                |
|                        | [vhs](https://github.com/charmbracelet/vhs)                                      | -                                |
|                        | [ttyd](https://github.com/tsl0922/ttyd)                                          | -                                |
|                        | [ffmpeg](https://ffmpeg.org)                                                     | -                                |
|                        | [chezmoi](https://www.chezmoi.io)                                                | `dot_config/template.toml`       |
|                        | [vdirsyncer](https://github.com/pimutils/vdirsyncer)                             | `dot_config/vdirsyncer`          |
| **Weather**            | [outside](https://github.com/BaconIsAVeg/outside)                                | `dot_config/outside`             |
| **AI Tools**           | [Claude](https://claude.ai)                                                      | -                                |
|                        | [ChatGPT](https://chat.openai.com)                                               | -                                |
|                        | [Ollama](https://ollama.com)                                                     | -                                |
| **Network**            | [Tailscale](https://tailscale.com)                                               | -                                |
| **Email**              | [aerc](https://aerc-mail.org)                                                    | `dot_config/aerc`                |
| **Font**               | [Nerd Fonts](https://www.nerdfonts.com)                                          | -                                |
| **Browsers**           | [Firefox](https://www.firefox.com)                                               | -                                |
|                        | [w3m](https://github.com/acg/w3m)                                                | -                                |
| **Security**           | [Bitwarden](https://bitwarden.com/)                                              | -                                |

## Documentation

[Aerospace](/documentation/AEROSPACE.md)
[Karabiner](/documentation/KARABINER.md)

## Color Palettes

[Cyberwave](/color_palettes/cyberwave/cyberwave_palette.html)
[Cyberpunk](/color_palettes/cyberpunnk/palette.html)

## 🪪 License

MIT
