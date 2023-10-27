# taken from:
# https://github.com/denolfe/dotfiles/blob/master/macos/setup-homebrew.sh

#!/usr/bin/env bash
#
# Install homebrew and essential packages

set -e

if [ ! -f "`which brew`" ]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "skipping Homebrew installation..."
fi

brew update
brew upgrade
brew bundle install --file=Brewfile
brew cleanup

echo "All packages installed."
