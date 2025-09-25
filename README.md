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

| Category            | Tool        | Key Files (chezmoi paths)                                                | Docs                                          |
| ------------------- | ----------- | ------------------------------------------------------------------------ | --------------------------------------------- |
| **macOS WM**        | AeroSpace   | `dot_config/aerospace/aerospace.toml`                                    | [`AEROSPACE.md`](documentation/AEROSPACE.md)  |
|                     | Karabiner   | `dot_config/private_karabiner/private_karabiner.json`                    | [`KARABINER.md`](documentation/KARABINER.md)  |
| **Windows WM**      | GlazeWM     | `dot_glzr/glazewm/config.yaml`                                           | [`GLAZEWM.md`](documentation/GLAZEWM.md)      |
|                     | Zebar       | `dot_glzr/zebar/settings.json`                                           | -                                             |
| **Shells**          | zsh         | `dot_zshrc`                                                              | -                                             |
|                     | oh-my-zsh   | `dot_oh-my-zsh`                                                          | [`ZSH.md`](documentation/ZSH.md)              |
|                     | PowerShell  | `dot_profile.ps1`                                                        | -                                             |
| **Terminals**       | Kitty       | `dot_config/kitty`                                                       | -                                             |
|                     | Warp        | -                                                                        | -                                             |
| **Editor**          | Helix       | `dot_config/helix/config.toml.tmpl`, `dot_config/helix/languages.toml`   | -                                             |
|                     | nano        | `dot_nanorc`                                                             | -                                             |
| **File Management** | Superfile   | `dot_config/superfile/config.toml`, `dot_config/superfile/hotkeys.toml`  | -                                             |
|                     | eza         | `dot_config/eza`                                                         | -                                             |
| **Viewers**         | Glow        | `dot_config/glow/Config/glow.yml`                                        | -                                             |
|                     | bat         | `dot_config/bat`                                                         | -                                             |
| **Notes**           | nb          | `dot_nbrc.tmpl`                                                          | -                                             |
| **Dev Tools**       | gh          | -                                                                        | -                                             |
|                     | gh-dash     | `dot_config/gh-dash/config.yml`                                          | -                                             |
| **JSON**            | jq          | -                                                                        | -                                             |
| **HTTP**            | HTTPie      | -                                                                        | -                                             |
| **Search**          | fd          | -                                                                        | -                                             |
| **Git**             | -           | `dot_gitconfig`, `dot_gitignore`                                         | -                                             |

## 🪪 License

MIT
