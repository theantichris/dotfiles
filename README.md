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

| Category            | Tool        | Key Files (chezmoi paths)        | Docs           |
| ------------------- | ----------- | -------------------------------- | -------------- |
| **macOS WM**        | AeroSpace   | `dot_config/aerospace`           | `AEROSPACE.md` |
|                     | Karabiner   | `dot_config/private_karabiner`   | `KARABINER.md` |
| **Windows WM**      | GlazeWM     | `dot_glzr/glazewm`               | `GLAZEWM.md`   |
|                     | Zebar       | `dot_glzr/zebar`                 | -              |
| **Shells**          | zsh         | `dot_zshrc`                      | -              |
|                     | oh-my-zsh   | `dot_oh-my-zsh`                  | -              |
|                     | PowerShell  | `dot_profile.ps1`                | -              |
| **Terminals**       | Kitty       | `dot_config/kitty`               | -              |
|                     | Warp        | -                                | -              |
| **Editor**          | Helix       | `dot_config/helix`               | -              |
|                     | nano        | `dot_nanorc`                     | -              |
| **File Management** | Superfile   | `dot_conf/superfile`             | -              |
|                     | eza         | `dot_config/eza`                 | -              |
| **Viewers**         | Glow        | `dot_config/glow`                | -              |
|                     | bat         | `dot_config/bat`                 | -              |
| **Notes**           | nb          | `dot_nbrc.tmpl`                  | -              |
| **Dev Tools**       | gh          | -                                | -              |
|                     | gh-dash     | `dot_config/gh-dash`             | -              |
| **JSON**            | jq          | -                                | -              |
| **HTTP**            | HTTPie      | -                                | -              |
| **Search**          | fd          | -                                | -              |
| **Git**             | -           | `dot_gitconfig`, `dot_gitignore` | -              |

## Notes

- Platform-specific files are marked in the tables above.
- Review secrets before publishing or sharing.

## 🪪 License

MIT
