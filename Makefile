all: build

build:
	mkdir -p ~/.config

	# `-f` checks if file exists
	# `-d` checks if dir exists
	#
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.config/tmux ] || ln -s $(PWD)/tmux ~/.config/

tmux:
	ln -s $(PWD)/tmux ~/.config/

clean:
	rm -f ~/.tmux.conf
	rm -f ~/.config/tmux

.PHONY: all build clean
