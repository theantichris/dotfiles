# CRUSH.md

Project context for agents working in this repo.

## What this repo is

This is the **chezmoi source directory** (`chezmoi cd` lands here). Files here
are *not* the live configs — chezmoi renders and copies them into `$HOME`.
Editing a file here changes nothing until it is applied.

The source→target name mapping is chezmoi's attribute convention, not the
literal filename:

- `dot_foo` → `~/.foo`
- `*.tmpl` **suffix** → rendered as a Go text/template, suffix stripped
- `private_` → target gets `0600`
- `executable_` → target gets `+x`
- `empty_` → target may be zero-length
- `.chezmoiscripts/run_onchange_{before,after}_*.sh.tmpl` → run during `apply`
  when the rendered content hash changes; `before`/`after` orders them against
  file writes

So `dot_config/fish/config.fish.tmpl` is the source for
`~/.config/fish/config.fish`.

## Workflow

Git is handled by Christopher. Agent makes edits and verifies them; Agent does
not commit or push.

```sh
chezmoi diff <target-path>            # preview what apply would change
chezmoi cat <target-path>             # render one file to stdout
chezmoi execute-template < file.tmpl  # render arbitrary template text
chezmoi status                        # summarize pending adds/deletes
chezmoi apply                         # write changes into $HOME
chezmoi data                          # dump template variables
```

All of these take **target** paths (`~/.config/fish/config.fish`), never source
names. That includes `chezmoi add`, which takes the path in `$HOME` to start
managing.

Always render or diff a `.tmpl` after editing it — a template that parses fine
can still produce wrong output on a given OS branch.

## Cross-platform templating

Every machine-specific decision keys off `.chezmoi.os` and
`.chezmoi.osRelease.id`. Supported targets: **darwin** (macOS),
**linux/cachyos** (primary desktop), **android** (Termux), plus **ubuntu** and
**parrot** package scripts. Two layers control per-OS behavior:

1. **`.chezmoiignore`** — a template itself. Its
   `{{ if (ne .chezmoi.os "android") }}…{{ end }}` blocks list *target paths*
   that should NOT be applied on that OS. When adding a config that only exists
   on some platforms, gate it here. **Patterns are target paths**
   (`.config/kitty`), never source names (`dot_config/kitty`).
2. **Inline `{{ if eq .chezmoi.os "darwin" }}…{{ else }}…{{ end }}`** inside a
   `.tmpl` — for value differences (`EDITOR hx` vs `helix`, Homebrew shellenv,
   storage paths).

Use one layer or the other for a given decision, not both: `.chezmoiignore`
excludes whole targets, inline guards vary values within a target.

## Package installation

`.chezmoiscripts/run_onchange_before_install-packages-<os>.sh.tmpl` install the
toolchain per OS. **The OS guard is an inline template wrapper in the script
body** (`{{- if eq .chezmoi.os "android" -}}`), not something the filename does
— a script with no guard runs everywhere.

The darwin script is `after` and reruns keyed on the Brewfile hash
(`{{ include "dot_Brewfile" | sha256sum }}`), so edit `dot_Brewfile` to change
macOS packages. Go/Rust/gh toolchains are installed in these scripts and
mirrored by the `sys-update` fish function.

## Shared template partials

`.chezmoitemplates/` holds partials pulled in via
`{{ includeTemplate "name" . }}`. Both current partials — `clin-config.toml` and
`clin-cyberpunk-theme.toml` — are the single source of truth for clin, included
by the Linux copies (`dot_config/clin/`) and the macOS copies
(`Library/Application Support/com.clin.clin/`). Edit the partial, not the
includers.

## The cyberpunk color system

The whole environment shares one hardcoded palette — the canonical reference is
[`color_palettes/cyberpunk/palette.html`](color_palettes/cyberpunk/palette.html).

The values are **duplicated, not shared**, across
`dot_config/fish/functions/fish_prompt.fish` (`cyberpunk_*` vars, also consumed
by `sys-update`), the `[color …]`/`[delta]` sections of `dot_gitconfig.tmpl`, and
the clin theme partial. Change one, change all.

## Fish shell layout

- `config.fish.tmpl` sources `conf.d/eza.fish`, `environment.fish`, and
  `path.fish` explicitly; the rest of `conf.d/*.fish` autoload.
- `conf.d/*.fish` are plain (no template) alias/tool bundles: `chezmoi`, `git`,
  `go`, `eza`, `crush`, `modern-cli` (aliases `grep`→rg, `find`→fd when
  present), etc.
- `crush.fish` defines `ai`, which runs Crush with its cwd pinned to the notes
  workspace so general chat does not scatter CRUSH.md files into code repos.
- The `.tmpl` fish files (`config`, `environment`, `path`,
  `functions/sys-update`) branch on OS; `toney.fish` and `gpg-unlock.fish` are
  Android-only via `.chezmoiignore`.

## Agent configuration

Crush is the coding agent. Its config lives in `dot_config/crush/`: `crushrc`
(providers, models, LSPs, options, permissions), `CRUSH.md` (global
instructions), and `skills/`. `crushrc` is a Bash script executed at load time,
so a syntax error there breaks startup — check edits with
`bash -n dot_config/crush/crushrc`.

`dot_claude/` is the superseded Claude Code config. It is kept for reference but
is **unmanaged** — `.chezmoiignore` excludes `.claude`, so nothing in it is
applied. Do not add to it.

## Not managed here

`README.md`, `LICENSE`, `color_palettes/`, `CLAUDE.md`, `CRUSH.md`, `.crush`,
and `.claude` are in `.chezmoiignore` — they live in the repo for reference but
are never applied to `$HOME`.

`.chezmoiignore` also lists paths that do not exist yet (`documentation/`,
`AGENTS.md`, `screenshots/`, `.markdownlint.yml`, `.github/workflows`,
`chezmoi.toml`). Those entries are pre-emptive and harmless; do not treat them
as evidence the files are present.

There is no build and no test suite; this repo is configuration only. The
closest thing to a build is `chezmoi apply`.
