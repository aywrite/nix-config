#!/bin/bash
set -e

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Clone repository if needed
mkdir -p ~/.config && cd ~/.config
if [ ! -d "./nixpkgs" ] || [ -z "$(ls -A ./nixpkgs 2>/dev/null)" ]; then
    echo "==> Cloning nix-config repository..."
    git clone https://github.com/aywrite/nix-config ./nixpkgs
else
    echo "==> nixpkgs directory already exists and is not empty, skipping clone"
fi

# Check if nix is installed
if ! command_exists nix; then
    echo "==> Installing Nix..."
    sh <(curl -L "https://nixos.org/nix/install")
    # Source nix
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
else
    echo "==> Nix is already installed"
fi

# Enable flakes in nix configuration
echo "==> Configuring Nix flakes..."
mkdir -p ~/.config/nix
if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
    echo "==> Enabled flakes in nix.conf"
else
    echo "==> Flakes already enabled in nix.conf"
fi

# Create required directories
mkdir -p /nix/var/nix/{profiles,gcroots}/per-user/$USER
chmod 0755 /nix/var/nix/{profiles,gcroots}/per-user/$USER

# Create symbolic link from ~/nix-home to ~/.config/nixpkgs if it doesn't exist
if [ ! -L "$HOME/nix-home" ]; then
    echo "==> Creating symbolic link from ~/nix-home to ~/.config/nixpkgs"
    ln -s "$HOME/.config/nixpkgs" "$HOME/nix-home"
else
    echo "==> Symbolic link ~/nix-home already exists"
fi

echo "Installation complete! You can now use home-manager with flakes:"
echo "cd ~/.config/nixpkgs"
echo ""
echo "# For WSL:"
echo "home-manager switch --flake .#awright-wsl"
echo ""
echo "# For XPS 13:"
echo "home-manager switch --flake .#awright-xps13"
echo ""
echo "# For Work MacBook:"
echo "home-manager switch --flake .#awright-work-mbp"
echo ""
echo "# For Personal MacBook:"
echo "home-manager switch --flake .#awright-personal-mbp"
