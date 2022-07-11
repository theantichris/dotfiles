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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
