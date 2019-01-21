# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="/home/mdsanchez/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

