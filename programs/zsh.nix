{ pkgs, ... }:
let
  # this idea is from https://github.com/BrianHicks/dotfiles.nix/blob/master/dotfiles/zsh.nix
  extras = [
    ./shell/zshrc
    ./shell/shell_exports
    ./shell/shell_aliases
    ./shell/shell_functions
  ];
  extraInitExtra = builtins.foldl' (soFar: new: soFar + "\n" + builtins.readFile new) "" extras;
in
{
  home.file.".zsh-themes" = {
    source = ./shell/zsh-themes;
    recursive = true;
  };
  # .zshenv
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history = {
      ignoreDups = true;
      save = 100000;
      size = 100000;
    };
    shellAliases = {
      cls = "clear";
    };

    initContent = ''
      # Display red dots while waiting for completion
      COMPLETION_WAITING_DOTS="true"
    '' + extraInitExtra;
    oh-my-zsh = {
      enable = true;
      theme = "pure-space";
      custom = "\$HOME/.zsh-themes/";
      plugins = [
        "git"
      ];
    };

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "1yl8zdip1z9inp280sfa5byjbf2vqh2iazsycar987khjsi5d5w8";
        };
      }
    ];
  };
}
