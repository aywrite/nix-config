{ pkgs, ... }:
let
  rust-overlay = import (builtins.fetchTarball https://github.com/oxalica/rust-overlay/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ rust-overlay ]; };
  rustStable = nixpkgs.rust-bin.stable.latest.default.override {
    extensions = [
      "rust-src"
      "clippy-preview"
      "rustfmt-preview"
      "rust-analysis"
    ];
  };
in
{
  home.packages = with nixpkgs; [
    rustStable
    rust-analyzer
  ];
}
