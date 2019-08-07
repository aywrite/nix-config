{ pkgs, ... }:

{
  imports = [
    ../cfg/base.nix
    ../cfg/bash.nix
    ../cfg/zsh.nix
    ../cfg/neovim.nix
  ];

  home.packages = with pkgs; [
    source-code-pro
  ];

  fonts.fontconfig.enable = true;
}
