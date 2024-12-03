# based on https://github.com/danieldk/nix-home/blob/master/cfg/base-unix.nix
{ pkgs, ... }:

{
  imports = [
    ../programs/emacs.nix
    ../programs/neovim.nix
    ../programs/python.nix
    ../programs/vscode.nix
  ];

  home.homeDirectory = "/home/awright";
  home.username = "awright";

  home.packages = with pkgs; [
    # Basic utilities
    ripgrep
    unzip
    git
    fzf
    colordiff

    # Network utilities
    mtr
    netcat
    nettools
    wget

    # system tools
    htop
    bottom
    ncdu
    restic
    neofetch

    # Other utils
    ispell

    # Rust CLI Tools
    #exa -- currently broken?
    tokei
    fd

    # Development
    tmux
    jq
    shellcheck
    git-crypt
    direnv
    pre-commit

    # Languages
    # nix
    nixpkgs-fmt
    # go
    go
    golangci-lint
    # jsonnet
    jsonnet
    jsonnet-bundler
    # terraform
    terraform-ls

    # Need this for coc vim plugin
    nodejs
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Scripts in ./bin directory
  home.file."bin/free-some-space".source = ../bin/free-some-space.sh;
  home.file."bin/pomodoro".source = ../bin/pomodoro.sh;
  home.file."bin/ff-personal".source = ../bin/ff-personal.sh;
  home.file."bin/ff-work".source = ../bin/ff-work.sh;

  # default git ignores
  programs.git = {
    ignores = [
      # Git credential file
      ".gitconfig.local"
      # Folder view configuration files
      ".DS_Store"
      "Desktop.ini"
      # Thumbnail cache files
      "._*"
      "*~"
      "Thumbs.db"
      # Files that might appear on external disks
      ".Spotlight-V100"
      ".Trashes"
      # Compiled Python files
      "*.pyc"
      ".mypy_cache/"
      # npm & bower
      "bower_components"
      "node_modules"
      "npm-debug.log"
      # IDEs stuff
      ".idea"
      # haskell
      ".o"
    ];
  };
}
