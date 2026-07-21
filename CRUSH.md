# CRUSH.md

This file is intended as a quick‑start reference for agents working in this chezmoi source tree. It explains how the configuration system works, what commands are useful, and highlights non‑obvious conventions.

## Table of contents

- [chezmoi basics](#chezmoi-basics)
- [project layout](#project-layout)
- [important scripts & tools](#important-scripts--tools)
- [building and testing](#building-and-testing)
- [gotchas & edge‑cases](#gotchas--edge-cases)

## chezmoi basics

chezmoi stores the *source* files here.  They are rendered via Go text‑templates to user targets when you run `chezmoi apply`.  Source names use prefixes:

- `dot_foo` → `~/.foo`
- `.tmpl` or `*.tmpl` → template (prefix stripped)
- `private_` → target gets mode 0600
- `executable_` → target gets +x

You can preview changes with:

```
chezmoi diff ~/.config/fish/config.fish   # shows what will be written
chezmoi cat ~/.config/fish/config.fish    # renders single template
chezmoi apply                             # write all pending changes
```

A key point is that templates may contain conditional blocks based on `.chezmoi.os` and `.chezmoi.osRelease.id`.  See `README.md` for full cross‑platform logic.

## project layout

The repository is organized into three broad categories:

1. **Templates** – files whose names start with `dot_`, `*.tmpl` or inside `dot_config/...`.  These map directly to target paths in `$HOME$`.
2. **Partial templates** – stored under `.chezmoitemplates/` and included via `{{ includeTemplate "name" . }}`.  Edit the partial, not its includers.
3. **Scripts that run on change** – located in `.chezmoiscripts/`.  Names follow
   `run_onchange_{before,after}_*_*.sh.tmpl` and are executed when `chezmoi apply` detects a hash change.  The OS guard is automatically applied through the filename; e.g., `-android.sh.tmpl` runs only on Android.

Important directories:

- `dot_config/`        – most per‑user configuration files.
- `.chezmoitemplates/` – shared partials.
- `dot_Brewfile`       – macOS package list (only applied when running on Darwin).

## important scripts & tools

| Script                                                                 | Purpose                                                                      |
|------------------------------------------------------------------------|------------------------------------------------------------------------------|
| `.chezmoiscripts/run_onchange_before_install-packages‑cachyos.sh.tmpl` | Installs core toolchain (Go, Rust, gh) before packages on CachyOS.           |
| `.chezmoiscripts/run_onchange_after_install-packages-darwin.sh.tmpl`   | Runs after Brewfile install – re‑runs if the hash of `dot_Brewfile` changes. |
| `.chezmoiscripts/run_onchange_before_install-packages-android.sh.tmpl` | Installs Android/Termux dependencies.                                        |

Typical commands when adding a new config:

```
chezmoi add dot_config/...  # stage the file
chezmoi diff ~/<target>     # verify templated output
chezmoi apply               # push to $HOME
```

## building and testing

This repo contains only configuration; there are no compile‑time build steps or unit tests.  The main “build” is running `chezmoi apply` after modifications.

## gotchas & edge‑cases

- **`.chezmoiignore` is itself a template** – it can conditionally exclude targets based on the OS. If you modify it, run `chezmoi data` to ensure variables are correctly expanded.
- **File names that look like templates but aren't** – e.g., `gitconfig.tmpl` must be rendered with `${...}` placeholders; failing to escape braces will break rendering.
- **Permission inheritance** – only files prefixed with `private_` become 0600. Otherwise the file inherits your `$HOME` umask.
- **Ordering of before/after scripts** – `*_before_*` run *before* other writes, `*_after_*` after. Use this when you need to install a program required by subsequent files.
- **OS guards in source files vs `.chezmoiignore`** – Don’t duplicate the same guard twice; `.chezmoiignore` handles target exclusion, while inline `{{ if eq .chezmoi.os "darwin" }}` within a template sets per‑template values.
