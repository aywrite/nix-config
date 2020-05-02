{ config, pkgs, ... }:

{
  imports = [
    ../users/base.nix
    ../programs/bash.nix
    ../programs/neovim.nix
    ../programs/tmux/default.nix
  ];

  home.packages = with pkgs; [
    # other
    firefox
    cointop

    # kubernetes
    kubectl
    kubernetes-helm
    kustomize
    minikube
  ];

  home.sessionVariables = {
    BROWSER = "ff-personal";
  };

  programs.git = {
    enable = true;
    userEmail = "andrew.wright502@gmail.com";
    userName = "awright";
    signing.key = "0x46BAAEE2AFADB938";
    signing.signByDefault = true;
    extraConfig = {
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
