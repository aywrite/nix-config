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
    aws-iam-authenticator
    awscli
    google-cloud-sdk
    kubectl
    kubernetes-helm
    kustomize
    minikube
  ];

  home.sessionVariables = {
    BROWSER = "ff-work";
    http_proxy = "http://10.255.254.1:8118";
    https_proxy = "http://10.255.254.1:8118";
    HTTP_PROXY = "http://10.255.254.1:8118";
    HTTPS_PROXY = "http://10.255.254.1:8118";
    no_proxy = "localhost,.rentalcover.internal,.xcover.internal,.brightwrite.internal,127.0.0.1/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,224.0.0.0/4,223.255.255.0/24,192.0.0.0/24,191.255.0.0/16,128.0.0.0/8";
    NO_PROXY = "localhost,.rentalcover.internal,.xcover.internal,.brightwrite.internal,127.0.0.1/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,224.0.0.0/4,223.255.255.0/24,192.0.0.0/24,191.255.0.0/16,128.0.0.0/8";
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
