#!/bin/bash
set -e

mkdir -p ~/.config && cd ~/.config
git clone https://github.com/aywrite/nix-config ./nixpkgs
ln -s ~/.config/nixpkgs ~/nix-home

sh <(curl https://nixos.org/nix/install)

cd ~/.config/nix-home
cp home-template.nix home.nix

echo 'You should now install home-manager'
mkdir -m 0755 -p /nix/var/nix/{profiles,gcroots}/per-user/$USER
