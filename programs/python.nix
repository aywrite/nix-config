{ pkgs, ... }:

{
  xdg.configFile."pylintrc".source = ../programs/python/pylintrc;
  xdg.configFile."flake8".source = ../programs/python/flake8.cfg;
  xdg.configFile."pycodestyle".source = ../programs/python/pycodestyle.cfg;

  home.packages = with pkgs; [
    (
      python3.withPackages (ps: [
        ps.python-language-server
        ps.setuptools
        # type checking, import sorting and code formatting
        ps.pyls-mypy
        ps.pyls-isort
        ps.pyls-black
      ]))
  ];
}
