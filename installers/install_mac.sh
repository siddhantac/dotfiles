#!/bin/sh

set -e 

echo ">>> [1/5] installing basic stuff..."
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
	the_silver_searcher \
	fzf \
	yarn

echo ""
echo ">>> [2/5] installing oh-my-zsh and plugins..."
echo ""
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo ""
echo ">>> [3/5] installing vim-plug..."
echo ""
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cd ~/.vim/plugged/coc.nvim
yarn install && yarn build

echo ""
echo ">>> [4/5] installing tmux plugin manager..."
echo ""
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo ""
echo ">>> [5/5] installing extra tools..."
echo "          *  git-status-checker..."
go build -o /usr/local/bin/git-status-checker ./scripts/git-status-checker.go

echo ""
echo "          *  git-split-diff..."
# ref: https://github.com/banga/git-split-diffs
npm install -g git-split-diffs


echo ""
echo ">>> cleaning up..."
echo ""
brew cleanup

echo ""
echo ">>> DONE! <<<"
