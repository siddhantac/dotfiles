typeset -U PATH
autoload colors; colors;

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
antigen bundle zsh-users/zsh-autosuggestions 

# antigen theme agnoster
# antigen theme avit
# antigen theme spaceship
# workaround for https://github.com/zsh-users/antigen/issues/675
# THEME=agnoster
# antigen list | grep $THEME; if [ $? -ne 0 ]; then antigen theme $THEME; fi
# antigen theme agnoster

antigen apply

# fzf
# (using -e is faster than using 'brew --prefix')
# ----------------
# fzf via Homebrew
if [ -e /opt/homebrew/opt/fzf/shell/completion.zsh ]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
elif [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
else
  # fzf via local installation
  if [ -e ~/.fzf ]; then
    source ~/.fzf/shell/key-bindings.zsh
    source ~/.fzf/shell/completion.zsh
    if [[ ! "$PATH" == *$HOME.fzf/bin* ]]; then
      export PATH="$PATH:$HOME/.fzf/bin"
    fi
  fi
fi

# load aliases
source_if_exists "$DOTFILES/zsh/aliases.zsh"
source_if_exists "$DOTFILES/zsh/git.zsh"
source_if_exists "$HOME/.aliases.local"
source_if_exists "$HOME/.fzf.zsh"

# see https://github.com/deliveryhero/kube-env
# if [[ -f ~/dh/bin/kube-env ]]; then
# 	eval "$(~/dh/bin/kube-env)"
# fi


# eval "$(starship init zsh)"

source $HOME/.zshrc_custom

# vim controls
#   https://dougblack.io/words/zsh-vi-mode.html
bindkey -v

#########
# PROMPT
#########
# References
#   https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
#   https://salferrarello.com/zsh-git-status-prompt/
# Formatting
#   Bold: %b<text>%b
#   Color: %F{<color>}<text>%f
# Info
#   Username: %n
#   Hostname: %m
#   Directory: %~ (~ replaces the home dir with ~), %2~ (2 levels of dirs)
#   Git branch: %b
#   Git unstaged changes: %u
#   Git staged changes: %c
#   Git action: %a (rebase, merger, cherry-pick etc.)

setopt prompt_subst

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{red}✗%f'
zstyle ':vcs_info:*' stagedstr ' %F{cyan}✓%f'
zstyle ':vcs_info:git:*' formats       '%b%u%c '
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

PROMPT='%B%F{cyan}%~%f%b %F{magenta}%f %B%F{white}${vcs_info_msg_0_}%f%b'

simple_prompt() {
  export PROMPT="%B%F{cyan}%1~%f %b"
}
