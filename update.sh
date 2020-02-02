#!/usr/bin/env bash
set -o errexit
set -o pipefail

# update packages source
source "$HOME"/.nix-profile/etc/profile.d/nix.sh
nix-channel --update

# switch to new config
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
home-manager switch -f home.nix

# Post update fixes/commands
vim -E -c UpdateRemotePlugins -c q || true
