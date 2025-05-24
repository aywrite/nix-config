{ config, pkgs, ... }:

{
  imports = [
    ../users/base.nix
    ../programs/bash.nix
    ../programs/tmux/default.nix
  ];

  home.packages = with pkgs; [
    # dev ops
    # argocd - TODO broken?
    aws-iam-authenticator
    awscli2
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    kubectl
    kubernetes-helm
    kustomize
    minikube
    krew
    terraform
    sops
    glab

    # ruby
    solargraph
  ];

  home.sessionVariables = {
    BROWSER = "google-chrome-stable";
  };

  programs.git = {
    enable = true;
    userEmail = "andrew.w@covergenius.com";
    userName = "Andrew Wright";
    signing.key = "0xA0D1FD637BFB4181";
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
      url = {
        "git@gitlab.covergenius.biz:" = {
          insteadOf = "https://gitlab.covergenius.biz";
        };
      };
    };
  };
}
