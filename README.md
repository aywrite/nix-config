# Andrew Wright's Dotfiles/Nix Config

I use [nix](https://nixos.org/nix/) and [home manager](https://github.com/rycee/home-manager) with flakes to manage my applications and dotfiles.

I use `zsh` as my main shell, customized using `oh-my-zsh`.

![Terminal.app](https://raw.github.com/aywrite/nix-config/master/terminal.png)

## Installation

This repository contains user configuration deployed using [Home Manager](https://github.com/rycee/home-manager) with Nix flakes. The configuration is organized into modular components that can be mixed and matched for different machines and roles.

### Quick Start

1. Clone and install:
```bash
curl -L https://raw.githubusercontent.com/aywrite/nix-config/master/install.sh | bash
```

2. Switch to your configuration:
```bash
cd ~/.config/nixpkgs

# For WSL:
home-manager switch --flake .#awright-wsl

# For XPS 13 with Sway:
home-manager switch --flake .#awright-xps13

# For Work MacBook:
home-manager switch --flake .#awright-work-mbp
```

## Configuration Structure

The configuration is organized into several directories:

- **programs/**: Contains default settings for various programs & tools
- **machines/**: Machine-specific configurations (hardware, display, etc.)
- **users/**: User-specific configurations (git config, personal preferences)
- **roles/**: Role-based configurations that set up specific environments:
  - `ubuntu-wsl.nix`: Configuration for WSL environment
  - `sway-laptop.nix`: Configuration for Sway window manager on laptops
  - `darwin-laptop.nix`: Configuration for macOS environments

### Base Configuration
All machine configurations inherit from a base configuration in `home.nix` which sets up core Home Manager settings. Machine-specific configurations then add their own modules and roles on top of this base.

### Available Profiles

1. **WSL Profile** (`awright-wsl`):
   - Base configuration
   - Personal user settings
   - WSL-specific adaptations

2. **XPS 13 Profile** (`awright-xps13`):
   - Base configuration
   - Personal user settings
   - Sway window manager setup
   - Laptop-specific configurations

3. **Work MacBook Profile** (`awright-work-mbp`):
   - Base configuration
   - Work user settings
   - macOS-specific adaptations
   - Work-related tools and configurations

## Customize

### Local Settings

The dotfiles can be easily extended to suit additional local requirements by using the following files:

#### `~/.zsh.local`

If the `~/.zsh.local` file exists, it will be automatically sourced. This allows the use of environment variables to store secrets without checking them in.

## Acknowledgements

### Config
- The organisation of my nix files are based on [Hugo Reeves' blog post](https://hugoreeves.com/posts/2019/nix-home)
- Some of the ideas and files for my nix configuration are based on [Daniel K's - nix-home](https://github.com/danieldk/nix-home)
- My original dotfiles (pre nix) were based on [Nick Plekhanov's Dotfiles](https://github.com/nicksp/dotfiles)

### Window Manager
- My xmonad & xmobar configuration is mostly based on [Ethan Schoonover's - dotfiles-tilingwm](https://github.com/altercation/dotfiles-tilingwm)
- Sway configuration takes some inspiration from - https://github.com/Robinhuett/dotfiles/blob/master/.config/sway/config

### Scripts
- Brightness script based on the [script by Jon Gjengset](https://github.com/jonhoo/configs/blob/master/bins/bin/adjust-brightness)

### Themes

For a colour palette I generally stick to [Solarized (Dark)](https://github.com/altercation/solarized).

I use oh-my-zsh to manage my shell theme, the current theme I am using is a slightly modified version of [𝝺 Pure](https://github.com/marszall87/lambda-pure) with the formating of git status from  [Spaceship Prompt](https://github.com/denysdovhan/spaceship-prompt).

My old theme (`andrew`) was based on the [agnoster](https://github.com/agnoster/agnoster-zsh-theme) which is the default with oh-my-zsh.

## TODO

- Configure restic
- Write an install script with template/prompts to generate home.nix
- Figure out how best to manage root user

### Apps to add

- spotify
- 1password
- iterm (mac)
- rvm
- nvm
- virtualenv wrapper

### Themes

The following are repos/articles I want to look at which I might use ideas from:

- https://github.com/disassembler/network

- [Classy Touch - ZSH Theme](https://github.com/yarisgutierrez/classyTouch_oh-my-zsh)
- [Typewritten - ZSH Theme](https://github.com/reobin/typewritten)
