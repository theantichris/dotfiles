# Helix Editor Configuration

## Overview

A cyberpunk/netrunner themed modal text editor setup featuring LSP integration, auto formatting, and vim like keybindings. Configured for modern development workflows with inline diagnostics, relative line numbers, and comprehensive language support.

### Visual Style

- **Cyberpunk Theme**: Custom theme with magenta (#CA0174), cyan (#00F0FF), and neon green accents
- **Mode based Cursors**: Cyan (normal), green (insert), magenta (select)
- **Status Bar**: Color coded by mode with detailed information
- **Rainbow Brackets**: Multicolor bracket pairs for easy nesting visualization
- **Relative Line Numbers**: Vim style line numbering for efficient navigation

## Getting Started

### Installation

1. Install Helix:
   - Linux: `sudo pacman -S helix` or build from source
   - macOS: `brew install helix`
   - Windows: Download from [helix-editor.com](https://helix-editor.com)
2. Install language servers (see Language Support section)
3. Apply configuration: `chezmoi apply` or copy the files
4. Launch: `hx` or `helix`

### First Launch

Helix uses the cyberpunk theme by default. The editor will autosave your work and show diagnostics inline.

## Key Features

### Modal Editing

Helix uses vim like modes with some differences:
- **Normal mode**: Navigation and commands
- **Insert mode**: Text entry
- **Select mode**: Text selection and manipulation
- Visual feedback via cursor color and status bar

### Built-in LSP

Language Server Protocol support out of the box:
- Autocompletion
- Go to definition
- Inline diagnostics
- Code actions
- Hover documentation

### Autoformatting

Automatic code formatting on save for supported languages (Go, JSON, TOML, Lua).

### Multiple Cursors

Native support for multiple cursor editing without plugins.

### Autosave

Changes automatically saved to reduce data loss.

## Editor Settings

### Display

- **Relative line numbers**: Easier motion commands (`10j` to move down 10 lines)
- **Current line highlight**: Cursorline enabled
- **80 column ruler**: Visual guide at 80 characters
- **Indent guides**: Visual indicators for indentation levels (╎ character)
- **Color modes**: Mode indicator shows different colors
- **True color**: 24 bit color support

### Editing

- **Autosave**: Enabled
- **Completion replace**: Replaces word when accepting completion
- **Trim trailing whitespace**: Automatic on save
- **Soft wrap**: Lines wrap at 80 characters
- **Bar cursor in insert mode**: Visual indicator for insert mode

### Diagnostics

- **End of line hints**: Inline diagnostics at line end
- **Cursor line warnings**: Show warnings on current line
- **Other lines disabled**: Cleaner view, check with space commands

## Language Support

Configured with LSP servers and autoformatting for:

### Go
- **LSP**: gopls
- **Formatter**: goimports
- **Grammar check**: harper-ls

### JSON/JSONC
- **LSP**: vscode-json-languageserver
- **Auto-format**: Enabled
- **Grammar check**: harper-ls

### Lua
- **LSP**: lua-language-server
- **Auto-format**: Enabled
- **Template support**: `*.lua.tmpl` files
- **Grammar check**: harper-ls

### Markdown
- **LSP**: marksman
- **Grammar check**: harper-ls

### TOML
- **LSP**: taplo
- **Grammar check**: harper-ls

### Bash/Shell
- **LSP**: bash-language-server
- **Template support**: `*.sh.tmpl`, `*.bash.tmpl` files
- **Grammar check**: harper-ls

All languages include Harper grammar/spell checking for prose and comments.

## Configuration Files

All settings in [`~/.config/helix/`](../dot_config/helix/):

- [`config.toml`](../dot_config/helix/config.toml.tmpl) - Main editor configuration
- [`languages.toml`](../dot_config/helix/languages.toml) - Language server configuration
- [`themes/`](../dot_config/helix/themes/) - Custom themes
  - [`cyberpunk.toml`](../dot_config/helix/themes/cyberpunk.toml) - Main theme
  - [`cyberwave.toml`](../dot_config/helix/themes/cyberwave.toml) - Alternative theme

## Resources

- [Helix Documentation](https://docs.helix-editor.com/) - Official docs
- [Helix GitHub](https://github.com/helix-editor/helix) - Source code and issues
- [Helix Keymap](https://docs.helix-editor.com/keymap.html) - Complete keybinding reference
- [Cyberpunk Palette](../color_palettes/cyberpunk/palette.html) - Color reference
