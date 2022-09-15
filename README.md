# dotfiles

My dotfiles!

## Usage

1. Clone this repo
   1. `git clone git@github.com:theantichris/dotfiles.git "~/dotfiles"` or `gh repo clone theantichris/dotfiles`
1. Setup symlinks:
   1. `ln -s ~/dotfiles/.zshrc ~/.zshrc`
   1. GitConfig
      * `ln -s ~/dotfiles/.gitconfig ~/.gitconfig`
      * `ln -s ~/dotfiles/.gitconfig_windows ~/.gitconfig`
   1. `ln -s ~/dotfiles/.gitignore ~/.gitignore`
   1. `ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh`
   1. `ln -s ~/dotfiles/.zprofile ~/.zprofile`

## oh-my-zsh Plugins

* [copybuffer](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copybuffer)
  * `ctrl + o` to copy current command line
* [copyfile](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copyfile)
  * `copyfile <filename>` to copy a file
* [copypath](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copypath)
  * `copypath` copies the absolute path of the current directory
  * `copypath <file_or_directory>` copies the absolute path of the given file
* [dirhistory](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory)
  * `alt + left` goes to previous directory
  * `alt + right` goes to next directory
  * `alt + up` move to parent directory
  * `alt + down` move into first child directory
* [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
  * Adds aliases for Git commands
* [golang](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/golang)
  * Adds aliases for Go commands
* [history](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history)
  * `h` prints command history
  * `hs` use grep to search your command history
  * `hsi` case-insensitive command history search
* [jsontools](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jsontools)
  * `<data> | pp_json` pretty prints JSON
  * `is_json < <data>` returns true if data is valid JSON
  * `<data> | urlencode_json` returns a URL encoded string
  * `<data> | urldecode_json` returns decoded JSON
* [macos](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos)
* [vscode](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode)
  * `vsc` opens Visual Studio Code
* [web-search](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search)
  * `websearch ddg <term>` searches DuckDuckGo
* [yarn](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/yarn)
  * Adds aliases for Yarn commands
* [zsh-alias-finder](https://github.com/akash329d/zsh-alias-finder)
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
