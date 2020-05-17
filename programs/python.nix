{ pkgs, ... }:

{
  xdg.configFile."pylintrc".source = ../programs/pylintrc;

  home.packages = with pkgs; [
    (python3.withPackages
      (ps: [
        ps.python-language-server
        ps.setuptools
        # type checking, import sorting and code formatting
        ps.pyls-mypy
        ps.pyls-isort
        ps.pyls-black
      ]))
  ];
}
