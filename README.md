# dotfiles // netrunner loadout

_chezmoi-powered personal environment. keyboard-first. cross-platform._

---

## ⚡ Boot sequence (chezmoi)

| Task                           | Command                                  |
| ------------------------------ | ---------------------------------------- |
| Initialize & apply (SSH)       | `chezmoi init <GITHUB_REPO> --apply`     |
| Pull updates & re-apply        | `chezmoi update`                         |
| Inspect changes                | `chezmoi diff`                           |
| Apply local changes            | `chezmoi apply -v`                       |
| Edit a tracked file            | `chezmoi edit <FILE>`                    |
| Start tracking a file          | `chezmoi add <FILE>`                     |
| Jump to source repo            | `chezmoi cd`                             |

> Requires [chezmoi](https://www.chezmoi.io/). Use your package manager to install.

---

## 🧰 Loadout

| Category               | Tool                     | Link                                                 | Key Files (chezmoi paths)                                                |
| ---------------------- | ------------------------ | ---------------------------------------------------- | ------------------------------------------------------------------------ |
| **macOS WM**           | AeroSpace                | [AeroSpace](https://github.com/nikitabobko/AeroSpace) | `dot_config/aerospace/aerospace.toml`                                    |
|                        | Karabiner Elements       | [Karabiner](https://karabiner-elements.pqrs.org)     | `dot_config/private_karabiner/private_karabiner.json`                    |
| **Windows WM**         | GlazeWM                  | [GlazeWM](https://github.com/glzr-io/glazewm)        | `dot_glzr/glazewm/config.yaml`                                           |
|                        | Zebar                    | [Zebar](https://github.com/glzr-io/zebar)            | `dot_glzr/zebar/settings.json`                                           |
| **Shells**             | zsh                      | [zsh](https://www.zsh.org)                           | `dot_zshrc`                                                              |
|                        | oh-my-zsh                | [oh-my-zsh](https://ohmyz.sh)                        | `dot_oh-my-zsh`                                                          |
|                        | PowerShell               | [PowerShell](https://github.com/PowerShell/PowerShell) | `dot_profile.ps1`                                                      |
| **Terminals**          | WezTerm                  | [WezTerm](https://wezfurlong.org/wezterm)            | `dot_config/wezterm/wezterm.lua.tmpl`                                    |
| **Editors**            | Helix                    | [Helix](https://helix-editor.com)                    | `dot_config/helix/config.toml.tmpl`, `dot_config/helix/languages.toml`   |
|                        | nano                     | [nano](https://www.nano-editor.org)                  | `dot_nanorc`                                                             |
|                        | VS Code                  | [VS Code](https://code.visualstudio.com)             | -                                                                        |
| **File Management**    | Superfile                | [Superfile](https://github.com/yorukot/superfile)    | `dot_config/superfile/config.toml`, `dot_config/superfile/hotkeys.toml`  |
|                        | eza                      | [eza](https://github.com/eza-community/eza)          | `dot_config/eza`                                                         |
|                        | fd                       | [fd](https://github.com/sharkdp/fd)                  | -                                                                        |
| **Viewers**            | Glow                     | [Glow](https://github.com/charmbracelet/glow)        | `dot_config/glow/Config/glow.yml`                                        |
|                        | bat                      | [bat](https://github.com/sharkdp/bat)                | `dot_config/bat`                                                         |
|                        | jlv                      | [jlv](https://github.com/hedhyw/jlv)                 | -                                                                        |
| **System Monitor**     | btop                     | [btop](https://github.com/aristocratos/btop)         | -                                                                        |
| **Notes**              | nb                       | [nb](https://github.com/xwmx/nb)                     | `dot_nbrc.tmpl`                                                          |
| **Calendar/Tasks**     | calcure                  | [calcure](https://github.com/anufrievroman/calcure)  | `dot_config/calcure/config.ini`                                          |
| **RSS**                | nom                      | [nom](https://github.com/guyfedwards/nom)            | `dot_config/nom/config.yml`                                              |
| **Dev Tools**          | gh                       | [gh](https://cli.github.com)                         | `dot_config/gh`                                                          |
|                        | gh-dash                  | [gh-dash](https://github.com/dlvhdr/gh-dash)         | `dot_config/gh-dash/config.yml`                                          |
|                        | OpenCode                 | [OpenCode](https://opencode.sh)                      | `dot_config/opencode/opencode.json`                                      |
|                        | pre-commit               | [pre-commit](https://pre-commit.com)                 | -                                                                        |
|                        | GoReleaser               | [GoReleaser](https://goreleaser.com)                 | -                                                                        |
|                        | lazygit                  | [lazygit](https://github.com/jesseduffield/lazygit)  | -                                                                        |
|                        | hugo                     | [hugo](https://gohugo.io)                            | -                                                                        |
| **Languages**          | Go                       | [Go](https://go.dev)                                 | -                                                                        |
|                        | Node.js (npm)            | [Node.js](https://nodejs.org)                        | -                                                                        |
|                        | Python (uv)              | [uv](https://docs.astral.sh/uv)                      | -                                                                        |
| **Go Tools**           | gopls                    | [gopls](https://pkg.go.dev/golang.org/x/tools/gopls) | -                                                                        |
|                        | delve                    | [delve](https://github.com/go-delve/delve)           | -                                                                        |
|                        | goimports                | [goimports](https://pkg.go.dev/golang.org/x/tools/cmd/goimports) | -                                                         |
|                        | golangci-lint            | [golangci-lint](https://golangci-lint.run)           | -                                                                        |
|                        | golangci-lint-langserver | [golangci-lint-langserver](https://github.com/nametake/golangci-lint-langserver) | -                            |
|                        | gocovsh                  | [gocovsh](https://github.com/orlangure/gocovsh)      | -                                                                        |
|                        | gollama                  | [gollama](https://github.com/sammcj/gollama)         | -                                                                        |
| **LSP/Formatters**     | markdownlint-cli2        | [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2) | `.markdownlint.yml`                                 |
|                        | marksman                 | [marksman](https://github.com/artempyanykh/marksman) | -                                                                        |
|                        | taplo                    | [taplo](https://taplo.tamasfe.dev)                   | -                                                                        |
|                        | harper                   | [harper](https://github.com/elijah-potter/harper)    | -                                                                        |
|                        | codespell                | [codespell](https://github.com/codespell-project/codespell) | `dot_config/codespell/dot_codespellrc`                           |
|                        | bash-language-server     | [bash-language-server](https://github.com/bash-lsp/bash-language-server) | -                                        |
|                        | vscode-langservers       | [vscode-langservers](https://github.com/hrsh7th/vscode-langservers-extracted) | -                                  |
|                        | yaml-language-server     | [yaml-language-server](https://github.com/redhat-developer/yaml-language-server) | -                              |
| **Utilities**          | jq                       | [jq](https://jqlang.github.io/jq)                    | -                                                                        |
|                        | jqp                      | [jqp](https://github.com/noahgorstein/jqp)           | -                                                                        |
|                        | HTTPie                   | [HTTPie](https://httpie.io)                          | -                                                                        |
|                        | HTTPie Desktop           | [HTTPie Desktop](https://httpie.io/desktop)          | -                                                                        |
|                        | atac                     | [atac](https://github.com/Julien-cpsn/ATAC)          | -                                                                        |
|                        | freeze                   | [freeze](https://github.com/charmbracelet/freeze)    | -                                                                        |
|                        | crush                    | [crush](https://github.com/charmbracelet/crush)      | -                                                                        |
|                        | vhs                      | [vhs](https://github.com/charmbracelet/vhs)          | -                                                                        |
|                        | ttyd                     | [ttyd](https://github.com/tsl0922/ttyd)              | -                                                                        |
|                        | ffmpeg                   | [ffmpeg](https://ffmpeg.org)                         | -                                                                        |
|                        | chezmoi                  | [chezmoi](https://www.chezmoi.io)                    | `dot_config/template.toml`                                               |
|                        | vdirsyncer               | [vdirsyncer](https://github.com/pimutils/vdirsyncer) | `dot_config/vdirsyncer/config`                                           |
| **Weather**            | wego                     | [wego](https://github.com/schachmat/wego)            | `dot_wegorc.tmpl`                                                        |
| **Productivity**       | Raycast                  | [Raycast](https://www.raycast.com)                   | `dot_config/raycast`                                                     |
|                        | Notion                   | [Notion](https://www.notion.so)                      | -                                                                        |
|                        | Granola                  | [Granola](https://www.granola.so)                    | -                                                                        |
|                        | SteerMouse               | [SteerMouse](https://plentycom.jp/en/steermouse)     | -                                                                        |
| **AI Tools**           | Claude                   | [Claude](https://claude.ai)                          | -                                                                        |
|                        | Claude Code              | [Claude Code](https://claude.ai/code)                | -                                                                        |
|                        | ChatGPT                  | [ChatGPT](https://chat.openai.com)                   | -                                                                        |
|                        | Ollama                   | [Ollama](https://ollama.com)                         | -                                                                        |
| **Network**            | Tailscale                | [Tailscale](https://tailscale.com)                   | -                                                                        |
| **Email**              | aerc                     | [aerc](https://aerc-mail.org)                        | `dot_config/aerc/aerc.conf`, `dot_config/aerc/binds.conf`                |
| **Font**               | Hack Nerd Font           | [Nerd Fonts](https://www.nerdfonts.com)              | -                                                                        |
| **Version Control**    | Git                      | [Git](https://git-scm.com)                           | `dot_gitconfig`, `dot_gitignore`                                         |

## 🪪 License

MIT
