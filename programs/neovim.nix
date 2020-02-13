{ pkgs, ... }:
let
   customPlugins = pkgs.callPackage ./vim/plugins.nix {};
   vimRC = builtins.readFile ./vim/vimrc;
in
{
  programs.neovim = {
    enable = true;

    # aliases
    viAlias = true;
    vimAlias = true;

    withPython3 = true;

    extraConfig = vimRC;
    plugins = with pkgs.vimPlugins // customPlugins; [
        fzf-vim
        coc-nvim
        fzfWrapper
        vim-rooter
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
        #vim-prometheus
        vim-toml
        vim-go
        vim-terraform
        #vim-haskell-indent
        #vim-graphql
        vimwiki
        typescript-vim
        vim-ledger
        Jenkinsfile-vim-syntax
        vim-javascript
        vim-puppet
        rust-vim
        arcanist
        thrift
        vim-beancount
        vim-nix
        LanguageClient-neovim
    ];
  };
}
