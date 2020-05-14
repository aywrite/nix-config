{ pkgs, ... }:
let
  extras = [
    ./shell/bashrc
  ];
  extraInitExtra = builtins.foldl' (soFar: new: soFar + "\n" + builtins.readFile new) "" extras;
in
{
  programs.bash = {
    enable = true;
    initExtra = ''
      # https://github.com/NixOS/nixpkgs/issues/57957#issuecomment-478125749
      # Fixes issue with cannot set locale
      export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
    '' + extraInitExtra;
    profileExtra = ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
    '';
  };
}
