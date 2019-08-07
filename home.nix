{ config, pkgs, ... }:



{
  imports = [
    ./bash.nix
    ./zsh.nix
    ./neovim.nix
  ];
  # Symlink home files
  home.file.".xmonad".source = ~/dotfiles/xmonad;
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    alacritty
    htop
    firefox
  ];
}
