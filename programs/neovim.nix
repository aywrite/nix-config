{ pkgs, ... }:
let
  customPlugins = pkgs.callPackage ./vim/plugins.nix { };
  vimRC = builtins.readFile ./vim/vimrc;
in
{
  xdg.configFile."nvim/coc-settings.json".source = ../programs/vim/coc-settings.json;

  programs.neovim = {
    enable = true;

    # aliases
    viAlias = true;
    vimAlias = true;

    withPython3 = true;

    extraConfig = vimRC;
    plugins = with pkgs.vimPlugins // customPlugins; [
      codeium-vim
      fzf-vim
      coc-nvim
      fzfWrapper
      vim-rooter
      vim-test
      vim-tmux-navigator
      vim-dispatch
      fugitive
      surround
      ale
      LanguageClient-neovim
      vimwiki
      vim-gitgutter
      # --- Theme ---
      airline
      vim-airline-themes
      vim-colors-solarized
      # --- language specific plugins ---
      #vim-graphql
      #vim-haskell-indent
      #vim-prometheus
      Jenkinsfile-vim-syntax
      arcanist
      thrift
      rust-vim
      typescript-vim
      vim-beancount
      vim-go
      vim-javascript
      vim-ledger
      vim-nix
      vim-puppet
      vim-terraform
      vim-toml
      vim-jsonnet
    ];
  };
}
