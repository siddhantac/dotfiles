#!/bin/sh

add-apt-repository ppa:neovim-ppa/stable 
apt-get update

echo ">>> installing basic stuff..."
echo ""
apt install -y curl zsh tmux neovim nodejs npm grc

echo ""
echo ">>> installing vim-plug..."
echo ""
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo ""
echo ">>> installing git-split-diff..."
echo ""
# ref: https://github.com/banga/git-split-diffs
npm install -g git-split-diffs

echo ""
echo ">>> DONE! <<<"
