#!/bin/sh

set -e 

export DEBIAN_FRONTEND=noninteractive

fullpath=$(realpath $0)
curr_dir=$(dirname $fullpath)
dotfiles=$(dirname $curr_dir)

echo ">>> installing..."
echo ""
apt install -y --no-install-recommends curl zsh

echo ""
echo ">>> installing oh-my-zsh..."
echo ""
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting

echo ""
echo ">>> sourcing..."
echo ""
ln -s $dotfiles/zshrc ~/.zshrc
ln -s $dotfiles/aliases ~/.oh-my-zsh/custom/aliases.zsh
source /root/workspace/dotfiles/zshrc
echo $dotfiles"/zshrc"