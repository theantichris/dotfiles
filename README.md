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

| OS          | Window Manager / Keys | **Hyper**          | Key Files (chezmoi paths)                                                             | Docs                            |
| ----------- | --------------------- | ------------------ | ------------------------------------------------------------------------------------- | ------------------------------- |
| **macOS**   | AeroSpace + Karabiner | Caps Lock → ⌃⌥⌘⇧   | `dot_config/aerospace/aerospace.toml` · `dot_config/private_karabiner/karabiner.json` | `AEROSPACE.md` · `KARABINER.md` |
| **Windows** | GlazeWM (+ Zebar)     | Ctrl+Alt+Shift+`~` | `glazewm/config.yaml`                                                                 | `GLAZEWM.md`                    |
| **Shells**  | zsh / PowerShell      | —                  | `dot_zshrc` · `dot_profile.ps1`                                                       | —                               |

## Notes

- Platform-specific files are marked in the tables above.
- Review secrets before publishing or sharing.

## ✅ TODOs

- [ ] Exclude README.md from sync
- [ ] Exclude install script folders from sync
- [ ] Enable OS specific syncs

## 🪪 License

MIT
