all: build

build:
	mkdir -p ~/.config

	# `-f` checks if file exists
	# `-d` checks if dir exists

	[ -d ~/.config/tmux ] || ln -s $(PWD)/tmux ~/.config/
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -d ~/.config/zsh ] || ln -s $(PWD)/zsh ~/.config/
	[ -d ~/.config/kitty ] || ln -s $(PWD)/kitty ~/.config/
	[ -d ~/.config/nvim ] || ln -s $(PWD)/nvim ~/.config/
	[ -f ~/.config/starship.toml ] || ln -s $(PWD)/starship.toml ~/.config/
	[ -f ~/Library/Application\ Support/espanso/match/base.yml ] || ln -s $(PWD)/espanso_base.yml ~/Library/Application\ Support/espanso/match/base.yml

personal:
	[ -f ~/.config/zsh/aliases.local ] || ln -s $(PWD)/zsh/aliases.serenity ~/.config/zsh/aliases.local

tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

clean:
	rm -f ~/.config/tmux
	rm -f ~/.gitconfig
	rm -f ~/.zshrc
	rm -f ~/.config/zsh
	rm -f ~/.config/kitty
	rm -f ~/.config/nvim
	rm -f ~/.config/starship.toml
	rm -f ~/Library/Application\ Support/espanso/match/base.yml

.PHONY: all build clean
