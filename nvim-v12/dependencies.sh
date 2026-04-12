#!/usr/bin/env bash
# dependencies.sh - install system dependencies for this Neovim config.
# Generated from README.md by tangle.lua - do not edit directly.
# Requires Neovim to already be installed. See README.md for setup flow.

set -euo pipefail

if command -v apt-get &>/dev/null; then
    PKG() { sudo apt-get install -y "$@"; }
    sudo apt-get update -qq
elif command -v pacman &>/dev/null; then
    PKG() { sudo pacman -S --noconfirm "$@"; }
elif command -v brew &>/dev/null; then
    PKG() { brew install "$@"; }
else
    echo 'No supported package manager found (apt, pacman, brew).' >&2
    exit 1
fi

# [Prerequisites]
# Core tools: git (lazy.nvim bootstrap), curl, gcc + make (parser/plugin builds)
PKG git curl gcc make

# [Treesitter]
PKG tree-sitter-cli
