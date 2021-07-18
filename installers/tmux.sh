#!/bin/bash

set -e

ver=$1
default_ver=2.7

if [ -z "$ver" ]
then
    echo "installing $default_ver"
    ver=$default_ver
fi

# install libevent
curl -L https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz -o libevent.tar.gz
tar -xf libevent.tar.gz
cd libevent-2.1.8-stable
./configure
make
make install
cd ..

# install ncurses
curl -L ftp://ftp.invisible-island.net/ncurses/ncurses.tar.gz -o ncurses.tar.gz
tar -xf ncurses.tar.gz
cd ncurses-6.1

./configure
make
make install
cd ..

# install tmux
curl -L https://github.com/tmux/tmux/releases/download/2.7/tmux-$ver.tar.gz -o tmux.tar.gz
tar -xf tmux.tar.gz
cd tmux-$ver

./configure
make 
make install

echo ""
echo "done!"

