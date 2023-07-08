all: build

build:
	mkdir -p ~/.config

	# `-f` checks if file exists
	# `-d` checks if dir exists

	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -d ~/.config/tmux ] || ln -s $(PWD)/tmux ~/.config/
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig

tmux:
	ln -s $(PWD)/tmux ~/.config/

clean:
	rm -f ~/.tmux.conf
	rm -f ~/.config/tmux
	rm -f ~/.gitconfig

.PHONY: all build clean
