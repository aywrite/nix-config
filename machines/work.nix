{ config, pkgs, ... }:



{
  imports = [
    ../cfg/base.nix
    ../cfg/bash.nix
    ../cfg/zsh.nix
    ../cfg/neovim.nix
  ];
  # Symlink home files
  home.file.".xmonad".source = ~/dotfiles/xmonad;
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  home.packages = with pkgs; [
    alacritty
    firefox
  ];
}
