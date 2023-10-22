#!/bin/sh
set -e

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
