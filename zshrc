export PATH=$PATH:/usr/local/bin:$HOME/go/bin:$HOME/bin
export GOPATH=$HOME/go
export DOTFILES=$HOME/workspace/dotfiles
export ZSH="$HOME/.oh-my-zsh"
export TERM=screen-256color

#ZSH_THEME="avit"
ZSH_THEME="agnoster"
#ZSH_THEME="spaceship"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions z fzf docker)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# see https://github.com/deliveryhero/kube-env
if [[ -f ~/dh/bin/kube-env ]]; then
	eval "$(~/dh/bin/kube-env)"
fi

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi
