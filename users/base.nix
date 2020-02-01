# based on https://github.com/danieldk/nix-home/blob/master/cfg/base-unix.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # TODO should this be done on machine level instead?
    # Basic utilities
    htop
    ncdu
    ripgrep
    unzip
    git

  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    # TODO this doesn't belong here
    # Better userland for macOS
    coreutils
    findutils
    gnugrep
  ];

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
