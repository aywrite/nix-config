{ config, lib, pkgs, attrsets, ... }:

{
  imports = [
    ../programs/zsh.nix
    ../programs/rofi.nix
  ];
  nixpkgs.config.allowUnfree = true;

  home.file.".xinitrc".source = ../programs/xorg/xinitrc;
  home.file.".profile".source = ../programs/xorg/xprofile;
  xresources.extraConfig = builtins.readFile ../programs/xorg/Xresources;
  xsession.enable = true;

  # TODO move this to user?
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    fira-code
    fira-code-symbols
    source-code-pro
  ];
  # TODO move this to user?
  programs.urxvt = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ../programs/alacritty.nix) {
      shell.program = "zsh";
    };
  };

  # Can't do the whole xmonad directory because it prevents
  # xmonad for outputing the build and error files etc.
  home.file.".xmonad/xmonad.hs".source = ../programs/xmonad/xmonad.hs;
  home.file.".xmobarrc".source = ../programs/status-bars/xmobarrc;

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chrome";
    TERMINAL = "urxvt";
  };

  # TODO add urxvt
}
