#!/bin/bash
set -e
set -o pipefail

# Define available profiles with descriptions using simple arrays
PROFILE_KEYS=(1 2 3 4)
PROFILE_NAMES=("awright-wsl" "awright-xps13" "awright-work-mbp" "awright-personal-mbp")
PROFILE_DESCS=("For WSL" "For XPS 13" "For Work MacBook" "For Personal MacBook")

# Function to show the menu
show_menu() {
    echo "Available profiles:"
    for i in 0 1 2 3; do
        echo "  ${PROFILE_KEYS[$i]}) ${PROFILE_NAMES[$i]} - ${PROFILE_DESCS[$i]}"
    done
}

# Source nix if it exists
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Function to show usage information
show_usage() {
    echo "Usage: $0 <profile>"
    echo ""
    echo "Available profiles:"
    for i in 0 1 2 3; do
        echo "  ${PROFILE_NAMES[$i]} - ${PROFILE_DESCS[$i]}"
    done
    echo ""
    echo "Example: $0 awright-personal-mbp"
    exit 1
}

# Check if profile is provided as argument
if [ $# -eq 1 ]; then
    FLAKE_TARGET="$1"
    # Validate the provided profile
    valid_profile=false
    for i in 0 1 2 3; do
        if [ "$FLAKE_TARGET" = "${PROFILE_NAMES[$i]}" ]; then
            valid_profile=true
            break
        fi
    done

    if [ "$valid_profile" = true ]; then
        echo "==> Using flake target: ${FLAKE_TARGET}"
    else
        echo "==> Error: Invalid profile: ${FLAKE_TARGET}"
        show_usage
    fi
else
    echo "==> Error: No profile specified"
    show_usage
fi

# Update flake inputs
echo "==> Updating flake inputs..."
nix flake update

# Switch to new configuration
echo "==> Switching to new configuration..."
home-manager switch --flake ".#${FLAKE_TARGET}"

# Post update tasks
echo "==> Running post-update tasks..."

# Update vim plugins if neovim is installed
if command -v nvim >/dev/null 2>&1; then
    echo "==> Updating Neovim plugins..."
    nvim -E -c "UpdateRemotePlugins" -c "qa!" || true
fi

echo "==> Update complete!"
