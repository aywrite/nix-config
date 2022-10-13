{ pkgs, ... }:

{
  xdg.configFile."pylintrc".source = ../programs/python/pylintrc;
  xdg.configFile."flake8".source = ../programs/python/flake8.cfg;
  xdg.configFile."pycodestyle".source = ../programs/python/pycodestyle.cfg;

  home.packages = with pkgs; [
    (
      python39.withPackages (ps: [
        ps.python-lsp-server
        ps.setuptools
        # type checking, import sorting and code formatting
        ps.pylsp-mypy
        ps.pyls-isort
        ps.python-lsp-black
      ])
    )
  ];
}
