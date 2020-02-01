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
}
