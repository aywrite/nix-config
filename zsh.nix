{ pkgs, ... }:
{
  # .zshenv
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      ignoreDups = false;
      save = 1000000;
      size = 1000000;
    };
    shellAliases = {
      cls = "clear";
    };

    initExtra = ''
      # Directories to be prepended to $PATH
      declare -a dirs_to_prepend
      dirs_to_prepend=(
        "/usr/local/bin"
        "/usr/bin"
        "/bin"
        "/usr/sbin/
        /sbin"
        "/usr/local/sbin"
        "/usr/local/git/bin"
        "/usr/local/go/bin"
        "/usr/local/mysql/bin"
        "/usr/local/"
        "$HOME/.local/bin"
        "$HOME/dotfiles/bin"
        "$HOME/go/bin" # go binaries
        "$HOME/bin"
        "$HOME/.cargo/bin" # rust binaries
        "$HOME/.yarn/bin" # rust binaries
        "$HOME/work/arcanist/arcanist/bin"
        "$HOME/tools/arcanist/bin"
        "$HOME/tools/"
        "/usr/local/opt/bison/bin"
        "$HOME/.rbenv/bin"
      )
      
      # These are slow, might be useful later though
      #"$(brew --prefix ruby)/bin"
      #"$(brew --prefix coreutils)/libexec/gnubin" # Add brew-installed GNU core utilities bin
      #"$(brew --prefix)/share/npm/bin" # Add npm-installed package bin
      
      for dir in ''${(k)dirs_to_prepend[@]}
      do
        if [ -d ''${dir} ]; then
          # If these directories exist, then prepend them to existing PATH
          PATH="''${dir}:$PATH"
        fi
      done
      
      unset dirs_to_prepend
      export PATH

      # Display red dots while waiting for completion
      COMPLETION_WAITING_DOTS="true"
      # --- TODO nixify everything below here ---
      # Load the shell dotfiles
      for file in $HOME/.{shell_exports,shell_aliases,shell_functions,shell_config}; do
          [ -r "$file" ] && [ -f "$file" ] && source "$file";
      done;
      unset file;
      # Source local extra (private) settings specific to machine if it exists
      [ -f ~/.zsh.local ] && source ~/.zsh.local
      # load virtualenvwrapper script
      source /usr/local/bin/virtualenvwrapper.sh
      # ruby env manager
      eval "$(rbenv init -)"
      # ssh agent
      eval `ssh-agent -s` > /dev/null
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      # This loads nvm bash_completion
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
      # fzf
      [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    '';
    oh-my-zsh = {
      enable = true;
      theme = "andrew";
      custom = "\$HOME/dotfiles/zsh/themes/";
      plugins = [
        "git"
      ];
    };

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
      }
    ];
  };
}
