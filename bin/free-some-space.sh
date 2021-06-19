#!/usr/bin/env bash

# Free some space
# by Andrew Wright
# https://github.com/aywrite
# MIT License
#
# Really dumb script to just automate some of the common ways to free up some
# space.
#
set -o errexit
set -o nounset
set -o pipefail

# debian packages
if command -v apt; then
  sudo apt autoremove
  sudo apt-get autoclean
fi

# pacman packages
if command -v paccache; then
  sudo paccache -r
fi

# yay cache (aur only)
if command -v yay; then
  yay -Sc --aur
fi

# docker
if command -v docker; then
  docker system prune
fi

# nix/nixos
if command -v nix; then
  nix-collect-garbage --delete-older-than 30d
  nix optimise-store
fi

# yarn
if command -v yarn; then
  yarn cache clean
fi

# Report usage
df -h /
df -h ~/
