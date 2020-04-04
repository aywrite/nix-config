{ config, lib, pkgs, attrsets, ... }:

{
  imports = [
    ../programs/zsh.nix
    ../programs/rust.nix
  ];
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # fonts
    fira-code
    fira-code-symbols
    source-code-pro
    font-awesome # required for waybar
  ];
  # TODO move this to user?
  fonts.fontconfig.enable = true;

  xdg.configFile."i3/config".source = ../programs/i3/config;

  home.file.".xinitrc".source = ../programs/i3/xinitrc;
  home.file.".profile".source = ../programs/xorg/xprofile;
  xresources.extraConfig = builtins.readFile ../programs/xorg/Xresources;

  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ../programs/alacritty.nix) {
      shell.program = "zsh";
    };
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    MOZ_ENABLE_WAYLAND = "false";
  };
}
