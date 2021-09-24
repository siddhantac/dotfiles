#!/bin/sh

ln -s ~/workspace/dotfiles/tmux.conf ~/.tmux.conf

mkdir -p ~/.config/nvim
ln -s ~/workspace/dotfiles/init.vim ~/.config/nvim/init.vim

ln -s ~/workspace/dotfiles/aliases ~/.oh-my-zsh/custom/alias.zsh
