{ pkgs, spacemacs, ... }:

{
  programs.emacs.enable = true;
  home.file.".emacs.d" = {
    source = spacemacs;
    recursive = true;
  };
  home.file.".spacemacs".source = ./spacemacs.el;
}
