# dotfiles

My dotfiles repository managed by [chezmoi](https://www.chezmoi.io/).

## Structure

- `dot_gitconfig` — Git configuration settings
- `dot_gitignore` — Global Git ignore rules
- `dot_profile.ps1` — PowerShell profile script
- `dot_zshrc` — Zsh shell configuration
- `dot_config/` — Additional configuration files
  - `template.toml` — chezmoi configuration
  - `aerospace/aerospace.toml` — Aerospace-specific settings
  - `private_karabiner/private_karabiner.json` — Karabiner custom key mappings (macOS)

## Usage

To use these dotfiles:

1. Clone the repository to your home directory:

   ```pwsh
   git clone https://github.com/theantichris/dotfiles.git ~/dotfiles
   ```

2. Symlink or copy the desired files to their appropriate locations. For example:

   ```pwsh
   New-Item -ItemType SymbolicLink -Path $HOME\.gitconfig -Target $HOME\dotfiles\dot_gitconfig
   ```

   Or for Zsh on macOS/Linux:

   ```sh
   ln -s ~/dotfiles/dot_zshrc ~/.zshrc
   ```

3. Customize the configuration files as needed for your environment.

## Notes

- Some files are platform-specific (e.g., PowerShell for Windows, Zsh for macOS/Linux).
- The `dot_config` directory contains additional configurations for specific tools and setups.
- Always review and update sensitive or private information before sharing your dotfiles publicly.

## License

MIT License. See [LICENSE](LICENSE) for details.
