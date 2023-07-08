all: build

build:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/tmux
	mkdir -p ~/.config/kitty
	mkdir -p ~/.config/zsh

	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
