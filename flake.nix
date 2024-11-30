{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spacemacs = {
      url = "github:syl20bnr/spacemacs/master";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, spacemacs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };

      # Base configuration that all machines will inherit
      baseConfig = {
        imports = [
          ./home.nix
        ];
      };

      # Function to create machine-specific configurations
      mkHomeConfig = { extraModules ? [ ] }: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          baseConfig
        ] ++ extraModules;

        extraSpecialArgs = {
          inherit spacemacs;
        };
      };
    in
    {
      homeConfigurations = {
        "awright-wsl" = mkHomeConfig {
          extraModules = [
            ./users/awright-personal.nix
            ./roles/ubuntu-wsl.nix
          ];
        };

        "awright-xps13" = mkHomeConfig {
          extraModules = [
            ./users/awright-personal.nix
            ./machines/xps13.nix
            ./roles/sway-laptop.nix
          ];
        };

        "awright-work-mbp" = mkHomeConfig {
          extraModules = [
            ./users/awright-cg.nix
            ./machines/mbp-16.nix
            ./roles/darwin-laptop.nix
          ];
        };
      };
    };
}
