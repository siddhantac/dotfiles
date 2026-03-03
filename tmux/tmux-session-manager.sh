#!/bin/bash

# Helper function: called when ctrl-r is pressed for rename
if [ "$1" = "rename" ]; then
    session="$2"
    # Use fzf for text input (no nested popup, becomes this process)
    new_name=$(echo | fzf --print-query --header "Rename session: $session" --prompt 'New name> ' | head -1)
    if [ -n "$new_name" ]; then
        tmux rename-session -t "$session" "$new_name"
        tmux display-message "Renamed '$session' to '$new_name'"
    fi
    exit 0
fi

# Main session list with inline actions via keybindings
tmux list-sessions -F '#{?session_attached,,#{session_name}}' | \
sed '/^$/d' | \
fzf --reverse \
    --header 'enter:switch | ctrl-k:kill | ctrl-r:rename' \
    --prompt 'Session> ' \
    --bind "enter:become(tmux switch-client -t {})" \
    --bind "ctrl-k:execute(tmux kill-session -t {})+reload(tmux list-sessions -F '#{?session_attached,,#{session_name}}' | sed '/^\$/d')" \
    --bind "ctrl-r:become(~/workspace/dotfiles/tmux/tmux-session-manager.sh rename {})"
