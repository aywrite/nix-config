# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Home Manager configuration using Nix Flakes. Manages dotfiles, development tools, and desktop environments across multiple machines (macOS and Linux).

## Commands

```bash
# Deploy configuration to current machine
home-manager switch --flake .#awright-work-mbp      # Work MacBook (aarch64-darwin)
home-manager switch --flake .#awright-personal-mbp   # Personal MacBook (aarch64-darwin)
home-manager switch --flake .#awright-xps13          # XPS 13 laptop (x86_64-linux, Sway)
home-manager switch --flake .#awright-wsl            # WSL (x86_64-linux)

# Update flake dependencies and deploy
./update.sh <profile-name>

# Format nix files
nixpkgs-fmt <file.nix>

# Lint shell scripts
shellcheck <script.sh>
```

Pre-commit hooks run: `nixpkgs-fmt`, `shellcheck`, `check-yaml`, `check-toml`, `check-json`, `detect-private-key`, and `commitizen` for commit messages.

## Architecture

Configuration is composed in layers, each building on the previous:

1. **`flake.nix`** — Entry point. Defines the four home configurations and their inputs (nixpkgs 25.05, home-manager 25.05, rust-overlay, spacemacs).

2. **`users/*.nix`** — Per-identity configs. Each user file (e.g., `awright-cg.nix` for work) imports a role, a machine, and `base.nix`. Sets git identity, signing keys, and identity-specific packages.

3. **`roles/*.nix`** — Environment types. `common.nix` is the shared base role imported by all others. Specialized roles (`darwin-laptop.nix`, `sway-laptop.nix`, `ubuntu-wsl.nix`, etc.) add platform/WM-specific programs and settings.

4. **`machines/*.nix`** — Hardware-specific settings (display scaling, screen layouts).

5. **`programs/*.nix`** — Individual program modules. Each file configures one tool via Home Manager options. Subdirectories (`shell/`, `vim/`, `python/`, etc.) hold associated dotfiles.

**Data flow:** `flake.nix` → `users/<name>.nix` → imports `roles/<role>.nix` + `machines/<hw>.nix` → role imports `programs/*.nix` via `roles/common.nix`.

## Key Conventions

- Nix files are formatted with `nixpkgs-fmt`.
- Shell dotfiles live in `programs/shell/` and are sourced by both bash and zsh configs.
- Machine-local customization goes in `~/.zsh.local` (not tracked).
- The `bin/` directory contains standalone shell scripts added to `$PATH` by Home Manager.
- Commit messages follow the Commitizen convention.
