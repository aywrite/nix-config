# based on https://github.com/danieldk/nix-home/blob/master/cfg/base-unix.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Basic utilities
    htop
    ncdu
    ripgrep
    unzip
    git

  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    # Better userland for macOS
    coreutils
    findutils
    gnugrep
  ];

  programs.home-manager = {
    enable = true;
  };
}
