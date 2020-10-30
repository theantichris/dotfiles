# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/christopherlamm/.oh-my-zsh"

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin"
export PATH="$PATH:/usr/local/sbin:/Users/christopherlamm/go/bin:$HOME/.local/bin:$HOME/.asdf/bin:$PATH"

export GPG_TTY=$(tty)

COMPLETION_WAITING_DOTS="true"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
ZSH_ALIAS_FINDER_AUTOMATIC=true

plugins=(alias-finder copydir copyfile docker docker-compose git golang zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source ~/.iterm2_shell_integration.zsh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# Aliases
alias vsc="code ."
alias rm=trash

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# asdf
. /usr/local/opt/asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit

# Heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/christopherlamm/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
