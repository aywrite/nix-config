{ config, pkgs, ... }:

{
  imports = [
    ../users/base.nix
    ../programs/bash.nix
    ../programs/neovim.nix
    ../programs/tmux/default.nix
  ];

  home.packages = with pkgs; [
    # dev ops
    kubectl
    google-cloud-sdk

    # other
    firefox
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
