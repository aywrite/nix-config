{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    # aliases
    viAlias = true;
    vimAlias = true;

    withPython3 = true;

    configure = {
      customRC = builtins.readFile ./vimrc;
      plug.plugins = with pkgs.vimPlugins; [
        fzf-vim
        #vim-rooter
	    vim-colors-solarized
        vim-tmux-navigator
        supertab
        #async
        vim-dispatch
        fugitive
        surround
        airline
        vim-airline-themes
        ale
        # language specific plugins
        #black
        #vim-prometheus
        vim-toml
        #vim-pug # jade syntax highlighting
        vim-go
        vim-terraform
        #vim-haskell-indent
        #vim-graphql
        #apiblueprint
        typescript-vim
        vim-ledger
        Jenkinsfile-vim-syntax
        vim-javascript
        vim-puppet
        rust-vim
        #arcanist
        #thrift
        vim-beancount
	    vim-nix
        LanguageClient-neovim
        deoplete-nvim
        deoplete-go
      ];
    };
  };
}
