# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/christopherlamm/.oh-my-zsh"

ENABLE_CORRECTION=true
COMPLETION_WAITING_DOTS=true
ZSH_ALIAS_FINDER_AUTOMATIC=true

plugins=(
  alias-finder
  copydir
  copyfile
  docker
  docker-compose
  git
  golang
  heroku
  vscode
  yarn
  zsh-autosuggestions
  zsh_reload
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source ~/.iterm2_shell_integration.zsh

# Aliases
alias bi="brew install"
alias bic="brew install --cask"
alias bu="brew update && brew upgrade --greedy && brew cleanup && brew doctor"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias rm=trash

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/christopherlamm/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;