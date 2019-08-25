{ pkgs }:

{
  arcanist = pkgs.vimUtils.buildVimPlugin {
    name = "arcanist";
    src = pkgs.fetchFromGitHub {
      owner = "solarnz";
      repo = "arcanist.vim";
      rev = "bd59e799e838c8d946d33142104b2db625dc15d6";
      sha256 = "11v7gqa5rnv28q0i3d02g9sw22gkjn10afvjx7bg352d91knxn9m";
    };
  };

  vim-rooter = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-rooter";
    version = "2019-02-25";
    src = pkgs.fetchFromGitHub {
      owner = "airblade";
      repo = "vim-rooter";
      rev = "7db12da2d63b6da5cdb968b29788de5e2beec14d";
      sha256 = "1dw9d69hvgnsjbj5qksbwb70kpnlba5nnygwq0baclnk7k5x1mbp";
    };
  };

  thrift = pkgs.vimUtils.buildVimPlugin {
    name = "thrift";
    src = pkgs.fetchFromGitHub {
      owner = "solarnz";
      repo = "thrift.vim";
      rev = "7c937d2a08e1154b2586729b67f0d1c8f5940e86";
      sha256 = "0m2dp9wr4qqy5g5r4nhswmpbr2gw1dk6bj3h1zv2ini660kh98q9";
    };
  };
}
