#!/bin/bash
set -e

mkdir -p ~/.config && cd ~/.config
git clone https://github.com/aywrite/nix-config ./nixpkgs
ln -s ~/.config/nixpkgs ~/nix-home

sh <(curl -L "https://nixos.org/nix/install")

cd ~/.config/nix-home
cp home-template.nix home.nix

echo 'You should now install home-manager'
mkdir -p /nix/var/nix/{profiles,gcroots}/per-user/$USER
chmod 0755 /nix/var/nix/{profiles,gcroots}/per-user/$USER
