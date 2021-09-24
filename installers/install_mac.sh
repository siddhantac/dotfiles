#!/bin/sh

set -e 

export DEBIAN_FRONTEND=noninteractive 

echo ">>> installing basic stuff..."
echo ""
brew install \
	curl \
	zsh \
	tmux \
	go \
	node \
	neovim \
	grc \
	exa \
	the_silver_searcher

node -v


echo ""
echo ">>> installing git-split-diff..."
echo ""
# ref: https://github.com/banga/git-split-diffs
npm install -g git-split-diffs

echo ""
echo ">>> installing vim-plug..."
echo ""
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo ""
echo ">>> installing oh-my-zsh and plugins..."
echo ""
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
brew install zsh-syntax-highlighting

echo ""
echo ">>> installing git-status-checker..."
echo ""
go build -o /usr/local/bin/git-status-checker ./scripts/git-status-checker.go

brew cleanup

echo ""
echo ">>> DONE! <<<"
