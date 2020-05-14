{ pkgs, ... }:
let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  pkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
  rustStable = pkgs.mozilla.latest.rustChannels.stable.rust.override {
    extensions = [ "rust-src" "rls-preview" "clippy-preview" "rustfmt-preview" ];
  };
in
{
  home.packages = with pkgs; [
    latest.rustChannels.stable.rust
    #latest.rustChannels.nightly.rust
    rustracer
  ];
}
