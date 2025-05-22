{
  # Flake description (duh)
  description = "Lucy's silly flake";

  # Flake inputs/dependencies
  inputs = {
    # Nix packages collection
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Install Flatpaks declaratively with Nix
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # A collection of NixOS modules covering hardware quirks
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home Manager - To manage user programs and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SOPS - Secrets provisioning for NixOS
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Window switcher hyprland
    hyprswitch.url = "github:h3rmt/hyprswitch/release";

    # rust package
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  # Flake actions - What to do after fetching all the inputs/dependencies
  outputs = { self, nixpkgs, rust-overlay, ... }@inputs: let
    #nixpkgs.config.allowUnfree = true;
    system = "x86_64-linux";

    # Define pkgs with the rust overlay applied
    pkgsFor = system: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ rust-overlay.overlays.default ];
    };
  in {
    # NixOS configurations
    nixosConfigurations.linda = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/linda/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
      ];
    };
   nixosConfigurations.yurania = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        pkgs = pkgsFor "x86_64-linux";
        };
      modules = [
        ./hosts/yurania/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];
    };
  };
}
