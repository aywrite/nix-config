{ pkgs, ... }:
let
  rustStable = pkgs.rust-bin.stable.latest.default.override {
    extensions = [
      "rust-src"
      "clippy-preview"
      "rustfmt-preview"
      "rust-analysis"
    ];
  };
in
{
  home.packages = with pkgs; [
    rustStable
    rust-analyzer
  ];
}
