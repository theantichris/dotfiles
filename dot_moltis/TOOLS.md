# Host and Tool Notes

These are environment-specific working notes, not tool registration or permission settings. Confirm details that may have changed.

## Host and shell

- Main computer: **tranchion**, a Lenovo Legion running **CachyOS** (Arch-based Linux) with **Hyprland**.
- Shell: **fish**. Write interactive commands using fish syntax, not Bash syntax.
- In the owner's fish configuration, `grep` may resolve to `rg` (ripgrep). Prefer `rg` and its own flags. Use `command grep` explicitly when GNU grep behavior is required.
- Terminal: kitty. Superfile (`spf`) is the preferred file manager.
- NVIDIA RTX 5090 GPU is available for local AI workloads.

## Configuration management

- Dotfiles are managed with **chezmoi**, sourced from `~/.local/share/chezmoi/` and the private GitHub repository `theantichris/dotfiles-new`.
- Chezmoi has `[git] autoCommit = true` and `autoPush = true`. Do **not** ask for extra manual commits or pushes after `chezmoi add`.
- For tracked settings, inspect and modify the **chezmoi source** with approval; avoid making untracked edits only to the rendered destination.
- Moltis config: `~/.config/moltis/moltis.toml`, from `dot_config/moltis/private_moltis.toml` in that repo.
- These global workspace instructions deploy to `~/.moltis/AGENTS.md` and `~/.moltis/TOOLS.md`. Moltis's generated `MEMORY.md` and `memory/` contents are runtime data, not dotfiles.

## AI services and tools

- Moltis runs as a **systemd user service**: `systemctl --user ... moltis`; local web UI: `https://localhost:41869`.
- Ollama runs locally, normally at `http://localhost:11434`. Current chat model: `huihui_ai/gpt-oss-abliterated:20b`; memory embeddings: `nomic-embed-text`.
- Moltis uses built-in SQLite hybrid memory with autonomous memory writes. Sandbox execution is disabled, but configured native filesystem writes and shell commands still require approval.
- Read tool documentation and version-specific source before changing Moltis options; don't assume sample configuration comments are active settings.

## Local workflow preferences

- Obsidian vault: `~/Documents/clin Vault` (lowercase `clin`). Quote paths containing spaces; read notes freely, but get approval before editing notes.
- For routine read-only file discovery, searching, and inspection (including Obsidian), use Moltis's native `Glob`, `Grep`, and `Read` tools with the correct absolute path. These tools do not require shell-command approval for reads. Do not invoke `exec` to run `rg`, `grep`, `find`, `ls`, or `cat` when a native filesystem tool can do the job. If a shell command is genuinely necessary, use it only with the existing approval mechanism; never bypass approval controls.
- Prefer official CachyOS/Arch packages when practical. Shelly is the existing AUR frontend; `paru` is not installed. Don't add another AUR helper just to solve an install problem.
- The owner generally prefers Go or Rust tools when an appropriate package is unavailable.
- When working with code repositories, inspect their existing instructions and Git history before proposing changes; get approval before mutations.
