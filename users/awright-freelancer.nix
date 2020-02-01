{ config, pkgs, ... }:

{
  imports = [
    ../users/base.nix
    ../programs/bash.nix
    ../programs/neovim.nix
  ];

  home.packages = with pkgs; [
    # TODO check the extra tools out
    # TODO re-organise the tools
    # TODO copy these changes to awright personal

    # Rust CLI Tools
    exa
    #bat
    #tokei
    #xsv
    #fd

    # Development
    tmux
    jq
    #git-crypt

    # Files
    #zstd
    #restic

    # Media
    #youtube-dl
    #imagemagick

    # Overview
    #wtf
    #lazygit
    #neofetch

    # other
    fzf
    firefox
    cointop
    kubectl
    google-cloud-sdk

    # python 3 development environment
    (python3.withPackages(ps: [
      ps.python-language-server
      ps.setuptools
      # type checking, import sorting and code formatting
      ps.pyls-mypy ps.pyls-isort ps.pyls-black
    ]))
  ];

  programs.git = {
    enable = true;
    userEmail = "awright@freelancer.com";
    userName = "awright";
    signing.key = "0x46BAAEE2AFADB938";
    signing.signByDefault = false;
  };
}
