{ config, lib, pkgs, attrsets, ... }:

{
  imports = [
    ../programs/zsh.nix
    ../programs/rust.nix
  ];

  # TODO where to put this
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # fonts
    fira-code
    fira-code-symbols
    font-awesome # required for waybar
    gelasio
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro

    # wayland programs
    mako
    slurp
    grim
  ];
  # TODO move this to user?
  fonts.fontconfig.enable = true;

  xdg.configFile."sway/config".source = ../programs/sway/config;
  xdg.configFile."waybar".source = ../programs/waybar;
  xdg.configFile."mako".source = ../programs/mako;

  home.file.".xprofile".source = ../programs/xorg/xprofile;
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
    MOZ_ENABLE_WAYLAND = "true";
    #https://github.com/swaywm/sway/issues/5008
    WLR_DRM_NO_MODIFIERS = 1;
  };
}
