#!/bin/sh

set -e

apt-get update
apt-get upgrade

apt-get install build-essential
brew install gcc
