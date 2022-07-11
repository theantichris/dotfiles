export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

ENABLE_CORRECTION=true
COMPLETION_WAITING_DOTS=true
ZSH_ALIAS_FINDER_AUTOMATIC=true

plugins=(
  copyfile
  copypath
  git
  golang
  vscode
  yarn
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Aliases
alias bat="batcat"
alias lla="ll -a"

source $ZSH/oh-my-zsh.sh
