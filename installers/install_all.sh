#!/bin/sh

set -e 

export DEBIAN_FRONTEND=noninteractive

fullpath=$(realpath $0)
curr_dir=$(dirname $fullpath)
dotfiles=$(dirname $curr_dir)
echo $fullpath
echo $curr_dir
echo $dotfiles
#export $DOTFILES=$(dotfiles)


echo ">>> installing basic stuff..."
echo ""
apt install -y --no-install-recommends curl zsh tmux exa

echo ""
echo ">>> installing oh-my-zsh..."
echo ""
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting

#source /root/workspace/dotfiles/zshrc
#echo $dotfiles"/zshrc"


echo ">>> installing dev stuff..."
echo ""
curl -sL https://deb.nodesource.com/setup_12.x | bash -
apt-get install -y nodejs
node -v
# npm

#add-apt-repository ppa:neovim-ppa/stable 
#apt-get update
echo ""
echo ">>> installing nvim..."
echo ""
apt install -y --no-install-recommends neovim grc
mkdir -p $HOME/.config/nvim
ln -s $dotfiles/init.vim $HOME/.config/nvim/init.vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo ""
echo ">>> setting up links..."
echo ""
mv ~/.zshrc ~/.zshrc.bk
ln -s $dotfiles/zshrc ~/.zshrc
ln -s $dotfiles/aliases ~/.oh-my-zsh/custom/aliases.zsh
ln -s $dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $dotfiles/gitconfig ~/.gitconfig
ln -s $dotfiles/gitignore.global ~/.gitignore


#echo ""
#echo ">>> installing git-split-diff..."
#echo ""
# ref: https://github.com/banga/git-split-diffs
#npm install -g git-split-diffs
#apt remove npm


apt-get clean

echo ""
echo ">>> DONE! <<<"
