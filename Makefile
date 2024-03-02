all: brew install setup extra

setup:
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

extra:
	./install_extra.sh

personal:
	[ -f ~/.config/zsh/aliases.local ] || ln -s $(PWD)/zsh/aliases.serenity ~/.config/zsh/aliases.local

brew:
	./macos/setup-homebrew.sh

install:
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
	brew install tmux neovim hledger eza bat zoxide fzf
	git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
	brew cleanup

clean:
	rm -rf ~/.config/tmux
	rm -f ~/.gitconfig
	rm -f ~/.zshrc
	rm -rf ~/.config/zsh
	rm -rf ~/.config/kitty
	rm -rf ~/.config/nvim
	rm -f ~/.config/starship.toml
	rm -f ~/Library/Application\ Support/espanso/match/base.yml

.PHONY: all build clean extra personal install kitty tpm
