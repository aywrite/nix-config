{ pkgs, ... }:

{
  xdg.configFile."pylintrc".source = ../programs/python/pylintrc;
  xdg.configFile."flake8".source = ../programs/python/flake8.cfg;
  xdg.configFile."pycodestyle".source = ../programs/python/pycodestyle.cfg;
  xdg.configFile."ruff.toml".source = ../programs/python/ruff.toml;

  home.packages = with pkgs; [
    (
      python310.withPackages (ps: with ps; [
        # LSP and basic tools
        python-lsp-server
        setuptools
        pip
        
        # Type checking and formatting
        pylsp-mypy
        pyls-isort
        python-lsp-black
        ruff-lsp
        
        # Testing
        pytest
        pytest-cov
        
        # Development tools
        ipython
        debugpy
        
        # Package management
        pipx
        poetry
        uv
        
        # Documentation
        sphinx
      ])
    )
    
    # Standalone tools (not Python packages)
    ruff
    black
    isort
    mypy
  ];

  # Environment variables for better Python development
  home.sessionVariables = {
    PYTHONBREAKPOINT = "ipdb.set_trace";
    PYTHONDONTWRITEBYTECODE = "1";  # Prevent creation of .pyc files
    PYTHONUNBUFFERED = "1";  # Unbuffered output
    VIRTUAL_ENV_DISABLE_PROMPT = "1";  # Let shell handle venv prompts
  };
}
