# Andrew Wright's Dotfiles/Nix Config

I use [nix](https://nixos.org/nix/) and [home manager](https://github.com/rycee/home-manager) to manage my applications and dotfiles.

I use `zsh` as my main shell, customized using `oh-my-zsh`.

TODO update screenshot
![Terminal.app](https://raw.github.com/nicksp/dotfiles/master/iterm/nick-terminal.png)

## Installation

This repository contains user configuration deployed using the helpful tool [Home Manager](https://github.com/rycee/home-manager). The organisation of my nix files are based on [Hugo Reeves'](https://hugoreeves.com/posts/2019/nix-home). In order to setup a new home space, simply add a home.nix file similar to this one.

```nix
{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./machine/t460.nix
    ./user/awright-personal.nix
    ./role/xmonad-laptop.nix
  ];
}
```

**Programs** contains default setting for various programs & tools.
**Machines** contains configuration specific to a given machine.
**Users** contains configuration specific to a given user, think git config etc.
**Roles** contains the bulk of the configuration and sets up most user space tools, think neovim and your terminal.

## Customize

### Local Settings

The dotfiles can be easily extended to suit additional local requirements by using the following files:

#### `~/.zsh.local`

If the `~/.zsh.local` file exists, it will be automatically sourced. This allows the use of environment variables to store secrets without checking them in.

TODO: look into something like git-crypt

## Acknowledgements

### Config
- The organisation of my nix files are based on [Hugo Reeves' blog post](https://hugoreeves.com/posts/2019/nix-home)
- Some of the ideas and files for my nix config are based on [Daniel K's - nix-home](https://github.com/danieldk/nix-home)
- My original dotfiles (pre nix) were based on [Nick Plekhanov's Dotfiles](https://github.com/nicksp/dotfiles)

### Scripts
- Brightness script based on the [script by Jon Gjengset](https://github.com/jonhoo/configs/blob/master/bins/bin/adjust-brightness)

### Themes

- [agnoster - ZSH Theme](https://github.com/agnoster/agnoster-zsh-theme)

### TODO
The following are repos/articles I want to look at which I might use ideas from:

- https://github.com/disassembler/network

- [𝝺 Pure - ZSH Theme](https://github.com/marszall87/lambda-pure)
- [Spaceship prompt - ZSH Theme](https://github.com/denysdovhan/spaceship-prompt)
- [Classy Touch - ZSH Theme](https://github.com/yarisgutierrez/classyTouch_oh-my-zsh)
- [Typewritten - ZSH Theme](https://github.com/reobin/typewritten)

