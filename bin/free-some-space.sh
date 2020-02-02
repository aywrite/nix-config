#!/usr/bin/env bash

# Free some space
# by Andrew Wright
# https://github.com/aywrite
# MIT License
#
# Really dumb script to just automate some of the common ways to free up some
# space.
#
# TODO: Make it work on multiple OS / if program is not installed
set -o errexit
set -o nounset
set -o pipefail

# debian packages
sudo apt autoremove
sudo apt-get autoclean

# docker
docker system prune

nix-collect-garbage
nix optimise-store

# yarn
yarn cache clean

# Report usage
df -h /
