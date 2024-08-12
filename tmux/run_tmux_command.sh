#!/bin/zsh

if [ -z "$1" ]; then
    tmux display "Command missing. Usage: run_tmux_command <command>"
    exit 1
fi

# if [[ $1 == "test" ]]; then
#     echo "test run" >> ~/workspace/tmp/tmux_test
# fi

if [[ $1 == "new-session" ]]; then
    tmux neww ~/.config/tmux/tmux-sessionizer
fi

if [[ $1 == "list-sessions" ]]; then
    tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
    sed '/^$/d' |\
    fzf --reverse --header jump-to-session |\
    xargs tmux switch-client -t
fi

if [[ $1 == "kill-session" ]]; then
    tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
    sed '/^$/d' |\
    fzf --reverse --header kill-session |\
    xargs tmux kill-session -t
fi

if [[ $1 == "window-left" ]]; then
    tmux swap-window -t -1
fi

if [[ $1 == "window-right" ]]; then
    tmux swap-window -t +1
fi

if [[ $1 == "reload-config" ]]; then
    tmux source-file ~/.config/tmux/tmux.conf
    tmux display "Config reloaded"
fi
