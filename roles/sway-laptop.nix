{ config, lib, pkgs, attrsets, ... }:

{
  imports = [
    ../programs/zsh.nix
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

  xdg.configFile."sway/config".source = ../programs/sway/config;
  xdg.configFile."waybar".source = ../programs/waybar;
  xdg.configFile."mako".source = ../programs/mako;

  home.file.".xinitrc".source = ../programs/xorg/xinitrc;
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
    BROWSER = "ff-tmp";
    TERMINAL = "alacritty";
    MOZ_ENABLE_WAYLAND = "true";
  };
}
