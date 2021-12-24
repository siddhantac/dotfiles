export DOTFILES=$HOME/workspace/dotfiles
export PATH=$PATH:/usr/local/bin:$HOME/go/bin:$HOME/bin
export GOPATH=$HOME/go
export ZSH="$HOME/.oh-my-zsh"
export TERM=screen-256color

source $DOTFILES/antigen.zsh
antigen use oh-my-zsh

antigen bundle z
antigen bundle git
antigen bundle fzf
antigen bundle docker
antigen bundle zsh-users/zsh-syntax-highlighting 
antigen bundle zsh-users/zsh-autosuggestions 

antigen theme agnoster
# antigen theme avit
# antigen theme spaceship

antigen apply

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
