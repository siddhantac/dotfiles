#!/bin/bash
set -e

if [ ! -f "`which lvim`" ]; then
  echo "> installing lunarvim..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py
  exec $SHELL
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
else
    echo "found lvim, skipping installation..."
fi
