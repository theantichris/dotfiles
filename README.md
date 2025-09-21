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

| Category       | Tool                    | Key Files (chezmoi paths)                                                                     | Docs                            |
| -------------- | ----------------------- | ----------------------------------------------------------------------------------------------| ------------------------------- |
| **macOS WM**   | AeroSpace + Karabiner   | `dot_config/aerospace/aerospace.toml` · `dot_config/private_karabiner/private_karabiner.json` | `AEROSPACE.md` · `KARABINER.md` |
| **Windows WM** | GlazeWM (+ Zebar)       | `dot_glzr/glazewm/config.yaml` · `dot_glzr/zebar/settings.json`                               | `GLAZEWM.md`                    |
| **Shells**     | zsh / PowerShell        | `dot_zshrc` · `dot_profile.ps1`                                                               | —                               |
| **Editor**     | Helix / nano            | `AppData/Roaming/helix/config.toml` · `AppData/Roaming/helix/languages.toml`                  | —                               |
| **Terminal**   | Superfile               | `AppData/Local/superfile/config.toml` · `AppData/Local/superfile/hotkeys.toml`                | —                               |
| **Viewers**    | Glow                    | `AppData/Local/glow/Config/glow.yml`                                                          | —                               |
| **Dev Tools**  | gh-dash                 | `dot_config/gh-dash/config.yml` · `dot_nanorc`                                                | —                               |
| **Git**        | —                       | `dot_gitconfig` · `dot_gitignore`                                                             | —                               |

## Notes

- Platform-specific files are marked in the tables above.
- Review secrets before publishing or sharing.

## 🪪 License

MIT
