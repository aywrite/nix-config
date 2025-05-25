{ config, lib, pkgs, username ? "awright", ... }:

with lib;

{
  options.role = {
    username = mkOption {
      type = types.str;
      default = username;
      description = "Username for the current profile";
    };

    isWSL = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the system is running under WSL";
    };

    pinentryProgram = mkOption {
      type = types.str;
      default = "${pkgs.pinentry}/bin/pinentry";
      description = "The pinentry program to use for GPG";
    };
  };
}
