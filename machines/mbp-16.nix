{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  xresources.properties = {
    "Xft.dpi" = 192;
  };
}
