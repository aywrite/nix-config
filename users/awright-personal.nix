{ config, pkgs, ... }:

{
  imports = [
    ../users/base.nix
    ../programs/bash.nix
    #../programs/tmux/default.nix
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
    signing.key = "0x46BAAEE2AFADB938";
    signing.signByDefault = false;
    settings = {
      user = {
        email = "andrew.wright502@gmail.com";
        name = "awright";
      };
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
