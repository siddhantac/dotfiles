all: build

install-kitty:
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

install: install-kitty

build:
	mkdir -p ~/.config

	# `-f` checks if file exists
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.zshrc ] || ln -s $(PWD)/zsh/zshrc ~/.zshrc
	[ -f ~/Library/Application\ Support/espanso/match/base.yml ] || ln -s $(PWD)/espanso_base.yml ~/Library/Application\ Support/espanso/match/base.yml

	# `-d` checks if dir exists
	[ -d ~/.config/tmux ] || ln -s $(PWD)/tmux ~/.config/
	[ -d ~/.config/zsh ] || ln -s $(PWD)/zsh ~/.config/
	[ -d ~/.config/kitty ] || ln -s $(PWD)/kitty ~/.config/
	[ -d ~/.config/nvim ] || ln -s $(PWD)/nvim ~/.config/

personal:
	[ -f ~/.config/zsh/aliases.local ] || ln -s $(PWD)/zsh/aliases.serenity ~/.config/zsh/aliases.local

tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

clean:
	rm -rf ~/.config/tmux
	rm -f ~/.gitconfig
	rm -f ~/.zshrc
	rm -rf ~/.config/zsh
	rm -rf ~/.config/kitty
	rm -rf ~/.config/nvim
	rm -f ~/.config/starship.toml
	rm -f ~/Library/Application\ Support/espanso/match/base.yml

.PHONY: all build clean
