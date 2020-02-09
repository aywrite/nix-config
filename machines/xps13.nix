{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.file."bin/brightness".source = ./t460/brightness;
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
}
