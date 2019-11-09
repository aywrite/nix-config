{ config, pkgs, ... }:

{
  imports = [
    ../cfg/base.nix
    ../cfg/bash.nix
    ../cfg/zsh.nix
    ../cfg/neovim.nix
  ];
  home.file.".xmonad".source = ~/dotfiles/xmonad;
  home.file."bin/brightness".source = ./work/brightness;
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";



  home.packages = with pkgs; [
    alacritty
    fzf
    firefox
    cointop
    (python3.withPackages(ps: [
      ps.python-language-server
      ps.setuptools
      # the following plugins are optional, they provide type checking, import sorting and code formatting
      ps.pyls-mypy ps.pyls-isort ps.pyls-black
    ]))
  ];
}
