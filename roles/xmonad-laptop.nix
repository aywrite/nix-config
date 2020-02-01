{ config, lib, pkgs, attrsets, ... }:

{
  imports = [
    ../programs/zsh.nix
  ];
  nixpkgs.config.allowUnfree = true;

  # TODO move xmonad under home manager properly
  home.file.".xmonad".source = ../programs/xmonad;

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
