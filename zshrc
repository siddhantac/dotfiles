source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

export WORKSPACE=$HOME/workspace
export DOTFILES=$WORKSPACE/dotfiles
export PATH=/usr/local/go/bin:$HOME/.local/share/nvim/mason/bin:/usr/local/bin:$HOME/go/bin:$HOME/workspace/bin:/opt/homebrew/bin:$HOME/.tmux/plugins/tmuxifier/bin:$PATH
export GOPATH=$HOME/go
# export ZSH="$HOME/.oh-my-zsh"
export TERM=screen-256color
export XDG_CONFIG_HOME=$HOME/.config
export LEDGER_FILE=$WORKSPACE/accounts/finances.journal
export EDITOR=nvim

#############
## HISTORY ##
#############
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Dont write duplicate entries in the history file.

source $DOTFILES/zsh/antigen.zsh
# antigen use oh-my-zsh

antigen bundle z
antigen bundle fzf
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
source_if_exists "$HOME/.fzf.zsh"

# see https://github.com/deliveryhero/kube-env
# if [[ -f ~/dh/bin/kube-env ]]; then
# 	eval "$(~/dh/bin/kube-env)"
# fi


eval "$(starship init zsh)"

source $HOME/.zshrc_custom

# vim controls
#   https://dougblack.io/words/zsh-vi-mode.html
bindkey -v
