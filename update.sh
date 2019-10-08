#!/bin/bash
set -e

source $HOME/.nix-profile/etc/profile.d/nix.sh
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
home-manager switch -f machines/work.nix
vim -E -c UpdateRemotePlugins -c q
