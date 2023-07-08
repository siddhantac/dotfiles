all: build

build:
	mkdir -p ~/.config

	# `-f` checks if file exists
	# `-d` checks if dir exists

	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -d ~/.config/tmux ] || ln -s $(PWD)/tmux ~/.config/
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -d ~/.config/zsh ] || ln -s $(PWD)/zsh ~/.config/

tmux:
	ln -s $(PWD)/tmux ~/.config/

clean:
	rm -f ~/.tmux.conf
	rm -f ~/.config/tmux
	rm -f ~/.gitconfig
	rm -f ~/.zshrc
	rm -f ~/.config/zsh

.PHONY: all build clean
