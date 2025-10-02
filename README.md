# dotfiles // netrunner loadout

_chezmoi-powered personal environment. keyboard-first. cross-platform._

---

## ⚡ Boot sequence (chezmoi)

| Task                           | Command                                  |
| ------------------------------ | ---------------------------------------- |
| **Initialize & apply (HTTPS)** | `chezmoi init <GITHUB_USERNAME> --apply` |
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

| Category            | Tool                  | Link                                              | Key Files (chezmoi paths)                                                |
| ------------------- | --------------------- | ------------------------------------------------- | ------------------------------------------------------------------------ |
| **macOS WM**        | AeroSpace             | https://github.com/nikitabobko/AeroSpace          | `dot_config/aerospace/aerospace.toml`                                    |
|                     | Karabiner Elements    | https://karabiner-elements.pqrs.org               | `dot_config/private_karabiner/private_karabiner.json`                    |
| **Windows WM**      | GlazeWM               | https://github.com/glzr-io/glazewm                | `dot_glzr/glazewm/config.yaml`                                           |
|                     | Zebar                 | https://github.com/glzr-io/zebar                  | `dot_glzr/zebar/settings.json`                                           |
| **Shells**          | zsh                   | https://www.zsh.org                               | `dot_zshrc`                                                              |
|                     | oh-my-zsh             | https://ohmyz.sh                                  | `dot_oh-my-zsh`                                                          |
|                     | PowerShell            | https://github.com/PowerShell/PowerShell          | `dot_profile.ps1`                                                        |
| **Terminals**       | Kitty                 | https://sw.kovidgoyal.net/kitty                   | `dot_config/kitty`                                                       |
|                     | Warp                  | https://www.warp.dev                              | -                                                                        |
| **Editors**         | Helix                 | https://helix-editor.com                          | `dot_config/helix/config.toml.tmpl`, `dot_config/helix/languages.toml`   |
|                     | nano                  | https://www.nano-editor.org                       | `dot_nanorc`                                                             |
|                     | VS Code               | https://code.visualstudio.com                     | -                                                                        |
| **File Management** | Superfile             | https://github.com/yorukot/superfile              | `dot_config/superfile/config.toml`, `dot_config/superfile/hotkeys.toml`  |
|                     | eza                   | https://github.com/eza-community/eza              | `dot_config/eza`                                                         |
|                     | fd                    | https://github.com/sharkdp/fd                     | -                                                                        |
| **Viewers**         | Glow                  | https://github.com/charmbracelet/glow             | `dot_config/glow/Config/glow.yml`                                        |
|                     | bat                   | https://github.com/sharkdp/bat                    | `dot_config/bat`                                                         |
| **Notes**           | nb                    | https://github.com/xwmx/nb                        | `dot_nbrc.tmpl`                                                          |
| **Dev Tools**       | gh                    | https://cli.github.com                            | `dot_config/gh`                                                          |
|                     | gh-dash               | https://github.com/dlvhdr/gh-dash                 | `dot_config/gh-dash/config.yml`                                          |
|                     | OpenCode              | https://opencode.sh                               | `dot_config/opencode/opencode.json`                                      |
|                     | pre-commit            | https://pre-commit.com                            | -                                                                        |
|                     | GoReleaser            | https://goreleaser.com                            | -                                                                        |
| **Languages**       | Go                    | https://go.dev                                    | -                                                                        |
|                     | Node.js (npm)         | https://nodejs.org                                | -                                                                        |
|                     | Python (uv)           | https://docs.astral.sh/uv                         | -                                                                        |
| **Go Tools**        | gopls                 | https://pkg.go.dev/golang.org/x/tools/gopls       | -                                                                        |
|                     | delve                 | https://github.com/go-delve/delve                 | -                                                                        |
|                     | goimports             | https://pkg.go.dev/golang.org/x/tools/cmd/goimports | -                                                                      |
|                     | golangci-lint         | https://golangci-lint.run                         | -                                                                        |
|                     | gocovsh               | https://github.com/orlangure/gocovsh              | -                                                                        |
|                     | jlv                   | https://github.com/hedhyw/jlv                     | -                                                                        |
| **Linters/Formatters** | markdownlint-cli2  | https://github.com/DavidAnson/markdownlint-cli2   | `.markdownlint.yml`                                                      |
|                     | marksman              | https://github.com/artempyanykh/marksman          | -                                                                        |
|                     | taplo                 | https://taplo.tamasfe.dev                         | -                                                                        |
| **Utilities**       | jq                    | https://jqlang.github.io/jq                       | -                                                                        |
|                     | HTTPie                | https://httpie.io                                 | -                                                                        |
|                     | HTTPie Desktop        | https://httpie.io/desktop                         | -                                                                        |
|                     | freeze                | https://github.com/charmbracelet/freeze           | -                                                                        |
|                     | wego                  | https://github.com/schachmat/wego                 | `dot_wegorc.tmpl`                                                        |
|                     | chezmoi               | https://www.chezmoi.io                            | `chezmoi.toml.tmpl`                                                      |
| **Productivity**    | Raycast               | https://www.raycast.com                           | `dot_config/raycast`                                                     |
|                     | Notion                | https://www.notion.so                             | -                                                                        |
|                     | Granola               | https://www.granola.so                            | -                                                                        |
|                     | SteerMouse            | https://plentycom.jp/en/steermouse                | -                                                                        |
| **AI Tools**        | Claude                | https://claude.ai                                 | -                                                                        |
|                     | Claude Code           | https://claude.ai/code                            | -                                                                        |
|                     | ChatGPT               | https://chat.openai.com                           | -                                                                        |
|                     | Ollama                | https://ollama.com                                | -                                                                        |
| **Network**         | Tailscale             | https://tailscale.com                             | -                                                                        |
| **Email**           | neomutt               | https://neomutt.org                               | `dot_config/neomutt/neomuttrc`, `dot_config/neomutt/cyberwaverc`         |
| **Font**            | Hack Nerd Font        | https://www.nerdfonts.com                         | -                                                                        |
| **Config Manager**  | Git                   | https://git-scm.com                               | `dot_gitconfig`, `dot_gitignore`                                         |

## 🪪 License

MIT
