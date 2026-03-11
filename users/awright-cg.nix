{ config, pkgs, gws-cli, ... }:

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

    # google workspace
    gws-cli.packages.${pkgs.system}.default

    # ruby
    solargraph
  ];

  home.sessionVariables = {
    BROWSER = "google-chrome-stable";
  };

  programs.git = {
    enable = true;
    signing.key = "0xA0D1FD637BFB4181";
    signing.signByDefault = true;
    settings = {
      user = {
        email = "andrew.w@covergenius.com";
        name = "Andrew Wright";
      };
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
