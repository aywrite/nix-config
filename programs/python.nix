{ pkgs, ... }:

let
  python = pkgs.python311;
  pythonPackages = python.pkgs;

  # Global development tools
  globalTools = with pkgs; [
    ruff
    uv
  ];

  # Python packages
  pythonEnvironment = with pythonPackages; [
    # Core
    pip
    virtualenv
    setuptools

    # LSP and tools
    python-lsp-server
    python-lsp-ruff
    pyls-isort
    python-lsp-black

    # Testing and debugging
    pytest
    pytest-cov
    debugpy
    ipython

    # Package management
    pipx

    # Documentation
    sphinx
  ];

in
{
  # Configuration files
  xdg.configFile = {
    "pylintrc".source = ../programs/python/pylintrc;
    "flake8".source = ../programs/python/flake8.cfg;
    "pycodestyle".source = ../programs/python/pycodestyle.cfg;
    "ruff.toml".source = ../programs/python/ruff.toml;
    "pyproject.toml".source = ./python/pyproject.toml;
    #"pip/pip.conf".source = ./python/pip.conf;
    #"pypoetry/config.toml".source = ./python/poetry-config.toml;
  };

  # Python packages
  home.packages = [
    (python.withPackages (ps: pythonEnvironment))
  ] ++ globalTools;

  # Environment variables
  home.sessionVariables = {
    PYTHONBREAKPOINT = "ipdb.set_trace";
    PYTHONDONTWRITEBYTECODE = "1"; # Prevent creation of .pyc files
    PYTHONUNBUFFERED = "1"; # Unbuffered output
    VIRTUAL_ENV_DISABLE_PROMPT = "1"; # Let shell handle venv prompts
  };
}
