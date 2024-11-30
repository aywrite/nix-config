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

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
log() {
    echo -e "${BLUE}==>${NC} $1"
}

success() {
    echo -e "${GREEN}==>${NC} $1"
}

error() {
    echo -e "${RED}==>${NC} $1"
}

# Function to get size in megabytes
get_size() {
    df -BM "$1" | awk 'NR==2 {sub(/M$/,"",$4); print $4}'
}

# Function to run command if it exists
run_if_exists() {
    local cmd=$1
    shift
    if command -v "$cmd" >/dev/null 2>&1; then
        log "Running $cmd cleanup..."
        "$@"
    fi
}

# Store initial space
SPACE_BEFORE=$(get_size "/")
log "Initial free space: ${SPACE_BEFORE}M"

# Debian/Ubuntu package cleanup
run_if_exists apt \
    bash -c 'sudo apt autoremove -y && sudo apt-get autoclean -y'

# Arch Linux package cleanup
run_if_exists paccache \
    sudo paccache -r
run_if_exists pacman \
    sudo pacman -Sc --noconfirm

# AUR package cleanup
run_if_exists yay \
    yay -Sc --aur --noconfirm

# Docker cleanup
if command -v docker >/dev/null 2>&1; then
    log "Cleaning Docker..."
    docker system prune -f
    # Remove dangling volumes
    docker volume prune -f
    # Remove unused images
    docker image prune -a -f --filter "until=720h"
fi

# Nix cleanup
if command -v nix >/dev/null 2>&1; then
    log "Cleaning Nix store..."
    # Remove old generations
    nix-collect-garbage --delete-older-than 30d
    # Remove all unused paths
    nix-store --gc
    # Optimize store
    nix store optimise
    # Clean old roots
    rm -f ~/.local/state/nix/profiles/home-manager*-link
fi

# Node.js package managers cleanup
run_if_exists yarn \
    yarn cache clean
run_if_exists npm \
    npm cache clean --force
run_if_exists pnpm \
    pnpm store prune

# logs
run_if_exists journalctl \
  journalctl --vacuum-time=30d

# Final space check
SPACE_AFTER=$(get_size "/")
SPACE_SAVED=$(echo "$SPACE_AFTER $SPACE_BEFORE" | awk '{printf "%d", $1 - $2}')

success "Cleanup complete!"
success "Free space before: ${SPACE_BEFORE}M"
success "Free space after: ${SPACE_AFTER}M"
success "Space saved: ${SPACE_SAVED}M"
