{ config, lib, pkgs, ... }:

{
  xdg.configFile."rofi".source = ./rofi;
}
