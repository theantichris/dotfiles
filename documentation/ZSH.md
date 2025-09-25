# Cyberwave ZSH Theme

A cyberpunk-inspired ZSH theme with vibrant neon colors and comprehensive development environment indicators.

## Features

### Visual Design

- **Cyberpunk Aesthetic**: Neon cyan, pink, and purple accents on a dark background
- **256 Color Support**: Full RGB color rendering for rich visual experience
- **Multi-line Prompt**: Clean separation between information display and command input
- **Smart Path Truncation**: Intelligently shortens long directory paths

### Git Integration

- **Branch Display**: Current branch name with colored indicators
- **Status Symbols**:
  - Yellow dot (`●`) - Unstaged changes
  - Green dot (`●`) - Staged changes
  - Red dot (`●`) - Untracked files
  - Purple arrow (`⇣`) - Behind remote (with count)
  - Purple arrow (`⇡`) - Ahead of remote (with count)

### Development Environment Indicators

- **Virtual Environment**: Python virtualenv/venv detection
- **Node.js**: Version display when in Node projects (detects `package.json`)
- **Go**: Version display when in Go projects (detects `go.mod`)
- **SSH Detection**: Highlights user and hostname when in SSH sessions
- **Command Timing**: Shows execution time for commands taking >2 seconds

### Prompt Elements

- **Exit Status**: Red cross with exit code on command failure
- **User/Host**: Only shown when SSH'd or using non-default user
- **Directory Path**: Current working directory with home shortening
- **Timestamp**: Right-aligned clock showing current time

## Installation

1. Place the theme file in your Oh My Zsh custom themes directory:

   ```bash
   ~/.oh-my-zsh/custom/themes/cyberwave.zsh-theme
   ```

2. Set the theme in your `.zshrc`:

   ```bash
   ZSH_THEME="cyberwave"
   ```

3. Reload your shell:

   ```bash
   source ~/.zshrc
   ```

## Color Palette

The theme uses a carefully crafted cyberwave color palette:

| Color      | Hex         | Usage                                     |
|------------|-------------|-------------------------------------------|
| Primary    | `#16e6c9`   | Main accent (cyan) - directories, prompt  |
| Secondary  | `#26add0`   | Blue - git branches, Go version           |
| Tertiary   | `#c73df5e3` | Purple - functions, virtualenv            |
| Quaternary | `#ff8ffd`   | Pink - operators, hostname                |
| Success    | `#23d18b`   | Green - staged changes, Node version      |
| Warning    | `#cca700`   | Yellow - unstaged changes, execution time |
| Error      | `#e25e44`   | Red - untracked files, exit codes         |
| Text       | `#cdcefb`   | Main text color                           |
| Comment    | `#8e9395`   | Muted text - brackets, separators         |

## Prompt Structure

```text
╭─[exit_status] [user@host] (virtualenv) [go_version] [node_version] ~/current/path [git_branch●●●]
╰─❯❯❯
```

### Components Breakdown

- **Exit Status**: Only shown on non-zero exit codes
- **User@Host**: Only shown in SSH sessions or for non-default users
- **Virtual Environment**: Python environment name when activated
- **Language Versions**: Context-aware display based on project files
- **Path**: Smart truncation for long paths
- **Git Status**: Branch name with visual status indicators
- **Prompt Arrows**: Gradient cyan → blue → purple arrows

## Customization

### Modifying Colors

Edit the `cyberwave_colors` associative array at the top of the theme file:

```zsh
cyberwave_colors=(
    [primary]="#16e6c9"      # Change main accent color
    [secondary]="#26add0"    # Change secondary color
    # ... etc
)
```

### Adjusting Path Length

Modify the path truncation threshold in the `cyberwave_pwd()` function (line 121):

```zsh
if [[ ${#home_replaced} -gt 40 ]]; then  # Change 40 to your preferred length
```

### Command Timing Threshold

Adjust when execution time appears in `cyberwave_exec_time()` (line 142):

```zsh
if [[ $elapsed -gt 2 ]]; then  # Change 2 to desired seconds
```

### Default User

Change the user check in `cyberwave_user_host()` (line 190):

```zsh
if [[ -n $SSH_CONNECTION ]] || [[ $USER != "chris" ]]; then  # Replace "chris"
```

## Requirements

- Zsh 5.0+
- Oh My Zsh framework
- Terminal with 256 color support
- Git (for repository status features)

## Terminal Configuration

For best results, ensure your terminal:

- Supports true color (24-bit RGB)
- Uses a monospace font with good Unicode support
- Has a dark background (theme optimized for dark terminals)

## Troubleshooting

### Colors Not Displaying Correctly

- Verify your terminal supports 256 colors: `echo $TERM`
- Should show something like `xterm-256color` or `screen-256color`

### Git Status Not Showing

- Ensure git is installed and accessible
- Check Oh My Zsh git status isn't disabled: `git config oh-my-zsh.hide-status`

### Performance Issues

- Large git repositories may slow down prompt
- Consider disabling git status for specific repos:

  ```bash
  git config oh-my-zsh.hide-status 1
  ```

## License

This theme is part of a personal dotfiles repository. Feel free to use and modify for your own purposes.

## Credits

Inspired by cyberpunk aesthetics and the need for a comprehensive development-focused prompt that provides context without overwhelming the terminal.
