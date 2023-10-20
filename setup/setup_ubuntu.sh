#!/bin/sh

set -e

sudo apt-get update
sudo apt-get upgrade

echo "Installing packages using apt-get"

xargs sudo apt-get -y install < packages.txt
