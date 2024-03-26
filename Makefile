setup:
	./setup.sh setup

links:
	./setup.sh links

extras:
	./setup.sh extras

homebrew:
	./setup.sh homebrew

core:
	./setup.sh core

clean:
	./setup.sh clean

personal:
	[ -f ~/.config/zsh/aliases.local ] || ln -s $(PWD)/zsh/aliases.serenity ~/.config/zsh/aliases.local

.PHONY: clean extras personal core homebrew links setup
