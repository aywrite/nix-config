{ config, lib, pkgs, attrsets, ... }:

{
  imports = [
    ../programs/zsh.nix
    ../programs/rust.nix
    ../programs/gpg.nix
  ];

  # Set pinentry program for macOS
  role.pinentryProgram = "${pkgs.pinentry_mac}/bin/pinentry-mac";

  # TODO where to put this
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # fonts
    fira-code
    fira-code-symbols
    gelasio
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    source-code-pro

    # other
    #pinentry
    yubikey-personalization
  ];
  # TODO move this to user?
  fonts.fontconfig.enable = true;


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
  };
}
