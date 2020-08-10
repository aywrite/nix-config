{ config, pkgs, ... }:

{
  imports = [
    ../users/base.nix
    ../programs/bash.nix
    ../programs/tmux/default.nix
  ];

  home.packages = with pkgs; [
    # dev ops
    argocd
    aws-iam-authenticator
    awscli
    google-cloud-sdk
    kubectl
    kubernetes-helm
    kustomize
    minikube
    sops

    # ruby
    solargraph
  ];

  home.sessionVariables = {
    BROWSER = "ff-work";
    http_proxy = "http://10.255.254.1:8118";
    https_proxy = "http://10.255.254.1:8118";
    HTTP_PROXY = "http://10.255.254.1:8118";
    HTTPS_PROXY = "http://10.255.254.1:8118";
    no_proxy = "***REDACTED***";
    NO_PROXY = "***REDACTED***";
  };

  programs.git = {
    enable = true;
    userEmail = "andrew.w@covergenius.com";
    userName = "Andrew Wright";
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
      url = {
        "git@gitlab.covergenius.biz:" = {
          insteadOf = "https://gitlab.covergenius.biz";
        };
      };
    };
  };
}
