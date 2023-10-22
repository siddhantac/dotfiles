#!/bin/sh

set -e

sudo apt update
sudo apt upgrade

echo "Installing packages using apt-get"

# charmbracelet
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update

xargs sudo apt -y install < setup/packages.txt

# starship
curl -sS https://starship.rs/install.sh | sh

# rust-sd
sudo apt install build-essential
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install sd
