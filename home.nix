{ config, pkgs, ... }:



{
  imports = [
    ./zsh.nix
  ];
  # Symlink home files
  home.file.".vim".source = ~/dotfiles/vim;
  home.file.".xmonad".source = ~/dotfiles/xmonad;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    git
    htop
    neovim
    firefox
    zsh-syntax-highlighting
  ];
}
