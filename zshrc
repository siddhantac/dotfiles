export DOTFILES=$HOME/workspace/dotfiles
export PATH=$PATH:/usr/local/bin:$HOME/go/bin:$HOME/workspace/bin:/opt/homebrew/bin
export GOPATH=$HOME/go
export ZSH="$HOME/.oh-my-zsh"
export TERM=screen-256color
export LEDGER_FILE=$HOME/workspace/accounts/finances.journal
export XDG_CONFIG_HOME=$HOME/.config

source $DOTFILES/antigen.zsh
antigen use oh-my-zsh

antigen bundle z
antigen bundle git
antigen bundle fzf
antigen bundle docker
antigen bundle zsh-users/zsh-syntax-highlighting 
antigen bundle zsh-users/zsh-autosuggestions 

# antigen theme agnoster
# antigen theme avit
# antigen theme spaceship
# workaround for https://github.com/zsh-users/antigen/issues/675
THEME=agnoster
antigen list | grep $THEME; if [ $? -ne 0 ]; then antigen theme $THEME; fi

antigen apply

# load aliases
[[ -s "$DOTFILES/aliases" ]] && source "$DOTFILES/aliases"
[[ -s ".aliases.local" ]] && source ".aliases.local"

[[ -s ~/.fzf.zsh ]] && source ~/.fzf.zsh

# see https://github.com/deliveryhero/kube-env
if [[ -f ~/dh/bin/kube-env ]]; then
	eval "$(~/dh/bin/kube-env)"
fi

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi
export PATH="$PATH:$HOME/.spicetify"

source $HOME/.zshrc_custom
