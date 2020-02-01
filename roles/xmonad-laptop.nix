{ config, lib, pkgs, attrsets, ... }:

{
  imports = [
    ../programs/zsh.nix
  ];
  nixpkgs.config.allowUnfree = true;

  # TODO move xmonad under home manager properly
  # Can't do the whole xmonad directory because it prevents
  # xmonad for outputing the build and error files etc.
  home.file.".xmonad/xmonad.hs".source = ../programs/xmonad/xmonad.hs;
  home.file.".xmobarrc".source = ../programs/status-bars/xmobarrc;

  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ../programs/alacritty.nix) {
      shell.program = "zsh";
    };
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chrome";
    TERMINAL = "urxvt";
  };

  # TODO add urxvt
}
