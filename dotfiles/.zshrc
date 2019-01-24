PATH=./bin:./node_modules/.bin
PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH
ZSH=~/.oh-my-zsh
ZSH_THEME="agnoster"
EDITOR=nvim

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

alias whereenv="echo $[ENV_DIR]"
alias editenv="$EDITOR $[ENV_DIR]"
alias reload-source="source ~/.zshrc"
alias edit-source="$EDITOR ~/.zshrc && reload-source"
alias vim=nvim
alias tmux="TERM=screen-256color tmux"

export NVM_DIR="$HOME/.config"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
