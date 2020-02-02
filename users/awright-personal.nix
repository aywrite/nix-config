{ config, pkgs, ... }:

{
  imports = [
    ../users/base.nix
    ../programs/bash.nix
    ../programs/neovim.nix
    ../programs/tmux/default.nix
  ];

  home.packages = with pkgs; [
    # Rust CLI Tools
    exa
    #bat
    #tokei
    #xsv
    #fd

    # Development
    tmux
    jq
    shellcheck
    #git-crypt

    # Files
    #zstd
    #restic

    # Media
    #youtube-dl
    #imagemagick

    # Overview
    htop
    #wtf
    #lazygit
    #neofetch
  ];

  programs.git = {
    enable = true;
    userEmail = "andrew.wright502@gmail.com";
    userName = "awright";
    signing.key = "0x46BAAEE2AFADB938";
    signing.signByDefault = true;
  };
}
