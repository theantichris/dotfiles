# Global instructions (Crush)

Loaded for every project via `global_context_paths`. Keep it short — context is scarce on a local 20B.

## External systems — drive these CLIs directly (already authenticated)

Prefer these over any MCP server. Run them non-interactively via the shell tool.

- **GitHub → `gh`** — e.g. `gh pr list`, `gh issue view <n>`, `gh pr create`, `gh api <endpoint>`. Add `--json <fields>` when you need structured output.
- **Linear → `linear-cli`** — issues, projects, cycles, docs, labels. Use `--json` for structured output and `-q` for terse IDs. `linear-cli me` verifies auth. `batch-create` reads JSON lines from stdin. Run `linear-cli --help` to discover verbs before guessing flags.
- **Notion → `ntn`** — pages, databases, markdown, raw API requests. Auth is in the keychain (`ntn login`). Run `ntn --help` before guessing flags.

Do not install or configure MCP servers for these; the CLIs are the sanctioned path.
