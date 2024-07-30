#!/bin/bash

message() {
    # tput: sets terminal capabilities
    # setaf: sets foreground color (set ansi foreground color)
    # sgr0: sets terminal to default color 
  content="$2";
  if [ "$1" = "info" ]; then
    color="$(tput setaf 3)"
    content="$content..."
  elif [ "$1" = "error" ]; then
    color="$(tput setaf 1)" 
  elif [ "$1" = "success" ]; then
   color="$(tput setaf 2)" 
   tput cuu1 && tput el
  fi
  
  printf "%s%s%s\n" "$color" "$content" "$(tput sgr0)"
  
  if [ "$1" = "error" ]; then
    exit 1
  fi
}

homebrew() {
    # taken from:
    # https://github.com/denolfe/dotfiles/blob/master/macos/setup-homebrew.sh
    if [ -f "`which brew`" ]; then
        message "success" "Homebrew found, skipping installation"
        return 0
    fi

    message "info" "Installing Homebrew"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

    brew update
    brew upgrade
    brew install mas
    brew cleanup

    message "success" "Homebrew installed"
}

core() {
    message "info" "installing core tools"

	which kitty || curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    brew install tmux 
    brew install hledger 
    brew install zoxide 
    brew install fzf 
    brew install git-delta 
    brew install neovim
    brew install npm
    brew install sd 
    brew install eza 
    brew install bat 
    brew install ripgrep
    brew install fd
	brew cleanup

    # tpm
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # asdf
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

    message "success" "core tools installed"
}

setup_links() {
    message "info" "setting up links"

	mkdir -p ~/.config

	# `-d` checks if dir exists
	[ -d ~/.config/tmux ] || ln -s $(PWD)/tmux ~/.config/
	[ -d ~/.config/zsh ] || ln -s $(PWD)/zsh ~/.config/
	[ -d ~/.config/kitty ] || ln -s $(PWD)/kitty ~/.config/
	[ -d ~/.config/nvim ] || ln -s $(PWD)/nvim ~/.config/

	# `-f` checks if file exists
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.zshrc ] || ln -s $(PWD)/zsh/zshrc ~/.zshrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux/tmux.conf ~/.tmux.conf

    message "success" "links setup"
}

install_extras() {
    message "info" "installing extra tools"

    # install nerd fonts for nice icons
    brew tap homebrew/cask-fonts
    brew install font-hack-nerd-font

    # install espanso
    brew tap espanso/espanso
    brew install espanso
    [ -f ~/Library/Application\ Support/espanso/match/base.yml ] || ln -s $(PWD)/espanso_base.yml ~/Library/Application\ Support/espanso/match/base.yml

    brew install gh
    brew cleanup

    message "success" "extra tools installed"
}

clean() {
    message "info" "cleaning up (removing links)"

	rm -rf ~/.config/tmux
	rm -f ~/.gitconfig
	rm -f ~/.zshrc
	rm -rf ~/.config/zsh
	rm -rf ~/.config/kitty
	rm -rf ~/.config/nvim
	rm -f ~/.config/starship.toml
	rm -f ~/Library/Application\ Support/espanso/match/base.yml

    message "success" "cleaned up"
}

karabiner() {
    message "info" "setup custom capslock in karabiner"

	[ -f ~/.config/karabiner/assets/complex_modifications/custom_capslock.json ] || ln -s $(PWD)/karabiner/custom_capslock.json ~/.config/karabiner/assets/complex_modifications/custom_capslock.json

}

case $1 in

    setup)
        message "info" "setting up everything"

        homebrew || message "error" "failed to install homebrew"
        core || message "error" "failed to install core tools"
        setup_links || message "error" "failed to setup links"
        install_extras || message "error" "failed to install extra tools"
        ;;
    homebrew)
        homebrew || message "error" "failed to install homebrew"
        ;;
    core)
        core || message "error" "failed to install core tools"
        ;;
    links)
        setup_links || message "error" "failed to setup links"
        ;;
    extras)
        install_extras || message "error" "failed to install extra tools"
        ;;
    clean)
        clean || message "error" "failed to clean up"
        ;;
    karabiner)
        karabiner || message "error" "failed to setup karabiner"
        ;;
esac
