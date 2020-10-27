{ pkgs, ... }:

{
  programs.emacs.enable = true;
  home.file.".emacs.d" = {
    source = builtins.fetchGit {
      url = "https://github.com/syl20bnr/spacemacs";
      ref = "master";
    };
    recursive = true;
  };
  home.file.".spacemacs".source = ./spacemacs.el;
}
