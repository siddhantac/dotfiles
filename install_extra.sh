#!/bin/bash

set -e

# install nerd fonts for nice icons
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font

# install espanso
brew tap espanso/espanso
brew install espanso
[ -f ~/Library/Application\ Support/espanso/match/base.yml ] || ln -s $(PWD)/espanso_base.yml ~/Library/Application\ Support/espanso/match/base.yml

brew install gh

