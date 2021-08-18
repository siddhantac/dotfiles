export PATH=$PATH:/usr/local/bin:/usr/local/go/bin:$HOME/go/bin:$HOME/bin
export GOPATH=$HOME/go
#export DOTFILES=$HOME/workspace/dotfiles
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="avit"
ZSH_THEME="agnoster"
#ZSH_THEME="spaceship"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions z fzf docker)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(thefuck --alias)

# see https://github.com/deliveryhero/kube-env
if [[ -f ~/dh/bin/kube-env ]]; then
	eval "$(~/dh/bin/kube-env)"
fi
