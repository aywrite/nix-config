{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
      supportedSystems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Function to get pkgs for a specific system
      pkgsFor = system: import nixpkgs {
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
      mkHomeConfig = { system ? builtins.currentSystem, extraModules ? [ ] }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor system;

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
        # WSL configuration
        "awright-wsl" = mkHomeConfig {
          system = "x86_64-linux";
          extraModules = [
            ./users/awright-personal.nix
            ./roles/ubuntu-wsl.nix
          ];
        };

        "awright-xps13" = mkHomeConfig {
          system = "x86_64-linux";
          extraModules = [
            ./users/awright-personal.nix
            ./machines/xps13.nix
            ./roles/sway-laptop.nix
          ];
        };

        "awright-work-mbp" = mkHomeConfig {
          system = "aarch64-darwin";
          extraModules = [
            ./users/awright-cg.nix
            ./machines/mbp-16.nix
            ./roles/darwin-laptop.nix
          ];
        };
      };
    };
}
