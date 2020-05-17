# based on https://github.com/danieldk/nix-home/blob/master/cfg/base-unix.nix
{ pkgs, ... }:

{
  imports = [
    ../programs/python.nix
  ];

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

    # system tools
    htop
    ytop
    ncdu
    restic
    neofetch

    # Rust CLI Tools
    exa
    tokei
    fd

    # Development
    tmux
    jq
    shellcheck
    git-crypt
    direnv

    # Languages
    # nix
    nixpkgs-fmt
    # go
    go
    golangci-lint

    # Need this for coc vim plugin
    nodejs

  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    # TODO this doesn't belong here
    # Better userland for macOS
    coreutils
    findutils
    gnugrep
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Scripts in ./bin directory
  home.file."bin/free-some-space".source = ../bin/free-some-space.sh;
  home.file."bin/pomodoro".source = ../bin/pomodoro.sh;

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
