{ config, pkgs, ... }:

{
  imports = [
    ../users/base.nix
    ../programs/bash.nix
    ../programs/neovim.nix
    ../programs/tmux/default.nix
  ];

  home.packages = with pkgs; [
    # TODO copy these changes to awright personal

    # dev ops
    kubectl
    google-cloud-sdk

    # other
    firefox

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
    extraConfig = {
      url = {
        "git@gitlab.tools.flnltd.com:" = {
          insteadOf = "https://gitlab.tools.flnltd.com/";
        };
      };
    };
  };
}
