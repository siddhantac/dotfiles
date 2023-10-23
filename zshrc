source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

export WORKSPACE=$HOME/workspace
export DOTFILES=$WORKSPACE/dotfiles
export PATH=$HOME/.local/share/nvim/mason/bin:/usr/local/bin:$HOME/go/bin:$HOME/workspace/bin:/opt/homebrew/bin:$HOME/.tmux/plugins/tmuxifier/bin:$PATH
export GOPATH=$HOME/go
# export ZSH="$HOME/.oh-my-zsh"
export TERM=screen-256color
export XDG_CONFIG_HOME=$HOME/.config
export LEDGER_FILE=$WORKSPACE/accounts/finances.journal
export EDITOR=nvim

source $DOTFILES/zsh/antigen.zsh
antigen use oh-my-zsh

antigen bundle z
antigen bundle git
antigen bundle fzf
antigen bundle docker
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle zsh-users/zsh-syntax-highlighting 
antigen bundle zsh-users/zsh-autosuggestions 

# antigen theme agnoster
# antigen theme avit
# antigen theme spaceship
# workaround for https://github.com/zsh-users/antigen/issues/675
# THEME=agnoster
# antigen list | grep $THEME; if [ $? -ne 0 ]; then antigen theme $THEME; fi
# antigen theme agnoster

antigen apply

# load aliases
source_if_exists "$DOTFILES/zsh/aliases.zsh"
source_if_exists "$DOTFILES/zsh/git.zsh"
source_if_exists "$HOME/.aliases.local"

[[ -s ~/.fzf.zsh ]] && source ~/.fzf.zsh

# see https://github.com/deliveryhero/kube-env
if [[ -f ~/dh/bin/kube-env ]]; then
	eval "$(~/dh/bin/kube-env)"
fi

#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='vim'
#fi
export PATH="$PATH:$HOME/.spicetify"

eval "$(starship init zsh)"

source $HOME/.zshrc_custom

# vim controls
#   https://dougblack.io/words/zsh-vi-mode.html
bindkey -v

eval "$(tmuxifier init -)"
