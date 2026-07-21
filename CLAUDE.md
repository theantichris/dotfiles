# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

This is the **chezmoi source directory** (`chezmoi cd` lands here). Files here are *not* the live configs — chezmoi renders and copies them into `$HOME`. Editing a file here changes nothing until it is applied. The source→target name mapping is chezmoi's attribute-prefix convention, not the literal filename:

- `dot_foo` → `~/.foo`
- `*.tmpl` → rendered as a Go text/template before being written (prefix stripped)
- `private_` → target gets `0600` perms
- `executable_` → target gets `+x`
- `.chezmoiscripts/run_onchange_{before,after}_*.sh.tmpl` → scripts run during `apply` when their content hash changes (`before`/`after` = ordering vs. file writes)

So `dot_config/fish/config.fish.tmpl` is the source for `~/.config/fish/config.fish`.

## Workflow — editing configs

Git is handled by the user; do not commit or push. Make edits, then verify with chezmoi:

```sh
chezmoi diff <target-path>            # preview what apply would change (target path, e.g. ~/.config/fish/config.fish)
chezmoi cat <target-path>             # render a single file to stdout (fastest way to check a .tmpl result)
chezmoi execute-template < file.tmpl  # render arbitrary template text with this machine's data
chezmoi apply                         # write changes into $HOME (run after edits so they take effect)
chezmoi data                          # dump the template variables (.chezmoi.os, .chezmoi.osRelease.id, .chezmoi.homeDir, …)
```

Always render/diff a `.tmpl` after editing it — a template that parses fine can still produce wrong output for a given OS branch.

## Cross-platform templating (the core mechanism)

Every machine-specific decision keys off `.chezmoi.os` and `.chezmoi.osRelease.id`. Supported targets: **darwin** (macOS), **linux/cachyos** (primary desktop), **android** (Termux), plus **ubuntu** and **parrot** package scripts. Two layers control per-OS behavior:

1. **`.chezmoiignore`** — a template itself. Its `{{ if (ne .chezmoi.os "android") }}…{{ end }}` blocks list *target paths* that should NOT be applied on a given OS. When adding a config that only exists on some platforms, gate it here. **Patterns are target paths** (`.config/kitty`), never source names (`dot_config/kitty`).
2. **Inline `{{ if eq .chezmoi.os "darwin" }}…{{ else }}…{{ end }}`** inside individual `.tmpl` files — for value differences (e.g. `EDITOR hx` vs `helix`, Homebrew shellenv, storage paths).

## Package installation

`.chezmoiscripts/run_onchange_before_install-packages-<os>.sh.tmpl` install the toolchain per OS. Each is wrapped in an OS guard so only the matching one runs. The darwin script is `after` and reruns keyed on the Brewfile hash (`{{ include "dot_Brewfile" | sha256sum }}`) — edit `dot_Brewfile` to change macOS packages. Go/Rust/gh toolchains are installed and updated inside these scripts and mirrored by the `sys-update` fish function.

## Shared template partials

`.chezmoitemplates/` holds partials pulled in via `{{ includeTemplate "name" . }}`. Currently `clin-config.toml` is the single source of truth for the clin config, included by both `dot_config/clin/config.toml.tmpl` and `Library/Application Support/com.clin.clin/config.toml.tmpl` (macOS). Edit the partial, not the includers.

## The cyberpunk color system

The whole environment shares one hardcoded palette — the canonical reference is [`color_palettes/cyberpunk/palette.html`](color_palettes/cyberpunk/palette.html) (backgrounds, text, accents, semantic, syntax, and terminal colors with hex values). The same values recur across tools and must be kept in sync when changing the theme.

They are duplicated (not shared) across: `dot_config/fish/functions/fish_prompt.fish` (`cyberpunk_*` vars, also consumed by `sys-update`), `dot_claude/executable_statusline-cyberpunk.sh`, and the `[color …]`/`[delta]` sections of `dot_gitconfig.tmpl`. Change one, change all.

## Fish shell layout

- `config.fish.tmpl` sources `environment.fish`, `path.fish`, and `conf.d/eza.fish` explicitly; the rest of `conf.d/*.fish` autoload.
- `conf.d/*.fish` are plain (no template) alias/tool bundles: `chezmoi`, `git`, `go`, `eza`, `modern-cli` (aliases `grep`→rg, `find`→fd when present), etc.
- `.tmpl` fish files (`config`, `environment`, `path`, `functions/sys-update`) branch on OS.
- `claude.fish` aliases `claude` to the Termux node CLI path when present (Android only; ignored elsewhere via `.chezmoiignore`).

## Not managed here

`README.md`, `LICENSE`, `documentation/`, `color_palettes/`, `AGENTS.md`, `CLAUDE.md`, `.crush`, and lint/CI files are in `.chezmoiignore` — they live in the repo for reference but are never applied to `$HOME`.
