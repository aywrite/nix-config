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
    argocd
    google-cloud-sdk
    kubernetes-helm
    kubectl
    kustomize
    minikube
  ];

  home.sessionVariables = {
    BROWSER = "ff-work";
  };

  programs.git = {
    enable = true;
    userEmail = "anderw.w@covergenius.com";
    userName = "awright";
    signing.key = "0x46BAAEE2AFADB938";
    signing.signByDefault = true;
    extraConfig = {
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
      url = {
        "git@bitbucket.com:" = {
          insteadOf = "https://bitbucket.com/";
        };
      };
    };
  };
}
