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
  };

  # Flake actions - What to do after fetching all the inputs/dependencies
  outputs = { self, nixpkgs, ... }@inputs: {
    # NixOS configurations
    nixosConfigurations.linda = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/linda/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.nixos-hardware.nixosModules.microsoft-surface-surface-pro-intel
      ];
    };
  };
}
