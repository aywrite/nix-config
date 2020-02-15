#!/bin/bash
set -e

mkdir -p ~/.config && cd ~/.config
git clone https://github.com/aywrite/nix-config ./nixpkgs
ln -s ~/.config/nixpkgs ~/nix-home

sh <(curl https://nixos.org/nix/install)

cp home-template.nix home.nix

echo 'You should now install home-manager'
