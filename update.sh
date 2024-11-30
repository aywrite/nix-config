#!/usr/bin/env bash
set -o errexit
set -o pipefail

# Function to detect the current host
detect_host() {
    if grep -q "microsoft" /proc/version 2>/dev/null; then
        echo "wsl"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "mbp"
    elif [[ -f "/etc/nixos/configuration.nix" ]]; then
        if [[ "$(hostname)" == *"xps"* ]]; then
            echo "xps13"
        else
            echo "unknown"
        fi
    else
        echo "unknown"
    fi
}

# Source nix if it exists
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Detect the current host
HOST_TYPE=$(detect_host)
FLAKE_TARGET="awright-${HOST_TYPE}"

echo "==> Detected host type: ${HOST_TYPE}"
echo "==> Using flake target: ${FLAKE_TARGET}"

# Update flake inputs
echo "==> Updating flake inputs..."
nix flake update

# Switch to new configuration
echo "==> Switching to new configuration..."
if [ "${HOST_TYPE}" != "unknown" ]; then
    home-manager switch --flake ".#${FLAKE_TARGET}"
else
    echo "Error: Unknown host type. Please specify your configuration manually:"
    echo "home-manager switch --flake .#awright-wsl     # For WSL"
    echo "home-manager switch --flake .#awright-xps13   # For XPS 13"
    echo "home-manager switch --flake .#awright-work-mbp # For Work MacBook"
    exit 1
fi

# Post update tasks
echo "==> Running post-update tasks..."

# Update vim plugins if neovim is installed
if command -v nvim >/dev/null 2>&1; then
    echo "==> Updating Neovim plugins..."
    nvim -E -c "UpdateRemotePlugins" -c "qa!" || true
fi

echo "==> Update complete!"
