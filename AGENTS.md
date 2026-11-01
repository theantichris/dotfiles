# Repository guidance

Personal dotfiles managed with chezmoi. Edit source files in this checkout and
preserve each file's existing formatting; avoid unrelated normalization.

## Conventions and shared data

- Preserve chezmoi names and attributes: `dot_`, `private_`, `executable_`,
  `symlink_`, and `.tmpl`. Templates use Go template syntax.
- Shared Cyberpunk colors live in `.chezmoidata/cyberpunk.yaml` and are exposed
  as `.cyberpunk` in templates. Update shared values there rather than duplicating
  colors across application themes.
- Package inventory lives in `.chezmoidata/packages.yaml`, grouped under
  `packages.apt`, `packages.deb`, `packages.termux`, `packages.pacman`,
  `packages.aur`, `packages.npm`, `packages.go`, and `packages.cargo`.
  `.chezmoiscripts/` contains package installation and other lifecycle scripts.
- Christopher keeps global npm installs unpinned; Agent should preserve this
  policy and document Node compatibility prerequisites instead of adding pins.
- Preserve Linux distribution branches: CachyOS enables installation and desktop
  setup; Parrot keeps the HTB VM's MATE session, application defaults, and Git
  signing, with alternate executable names where needed.
- Preserve Mitos (`ms`) as the Fish, chezmoi, and managed Git editor default.
  The `tranchion` desktop uses the separately installed `~/.local/bin/ms`;
  Hyprland and UWSM retain Helix on other hosts. Fish supplies `helix` aliases
  for `hx` on Parrot and Termux. Fastfetch also has Darwin and Android branches.
- Keep deployment exclusions in `.chezmoiignore`; `AGENTS.md` is repository-only.

## Safety

- Do not run `chezmoi apply`, `chezmoi init --apply`, `chezmoi update`, installation
  scripts, or package managers unless explicitly requested.
- Prefer direct source edits: `.chezmoi.toml.tmpl` enables `edit.apply`,
  `git.autoCommit`, and `git.autoPush`. Do not invoke automatic apply, commit, or
  push workflows unless explicitly requested.
- Live Noctalia settings and the Harper dictionary are symlinked to
  `noctalia-settings.toml` and `harper-dictionary.txt` in this checkout. Editing
  these source files may immediately affect running applications.

## Validation

- Render changed templates with `chezmoi execute-template --file PATH` or
  `chezmoi cat TARGET` before checking the resulting file's syntax. Put any
  rendered files in a temporary directory.
- Use available parsers: `fish --no-config --no-execute` for Fish, `sh -n` for
  POSIX shell, `luac -p` for Lua, Taplo or Python `tomllib` for TOML, `jq` for
  JSON, PyYAML `safe_load` for YAML, and Python `xml.etree.ElementTree` for XML.
  JSONC with comments or trailing commas needs a JSONC-aware parser.
- Check affected platform and hostname branches. Validate syntax without
  executing rendered scripts or reloading applications. Report unavailable
  checks rather than installing tooling without an explicit request.
- Run `git diff --check`. When changing guidance or deployment exclusions,
  confirm `chezmoi ignored` lists `AGENTS.md`.
