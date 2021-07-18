#!/bin/sh

apt install -y curl zsh nodejs npm

./tmux.sh
./git-split-diff.sh
./neovim.sh
./vim-plug.sh

apt install grc
