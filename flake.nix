{
  # Flake description (duh)
  description = "Lucy's silly flake";

  # Dependencies
  inputs = {
    # Nix packages collection
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Install Flatpaks declaratively with Nix
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # A collection of NixOS modules covering hardware quirks
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # To manage user programs and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets provisioning for NixOS
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland window switcher
    hyprswitch.url = "github:h3rmt/hyprswitch/release";

    # Overlay of binary Rust toolchains
    rust-overlay.url = "github:oxalica/rust-overlay";

    vscodium-server.url = "github:unicap/nixos-vscodium-server";
  };

  # Flake actions - What to do after fetching all the inputs/dependencies
  outputs = {
    nixpkgs,
    rust-overlay,
    ...
  } @ inputs: let
		# Generate packages for specified system
    system = "x86_64-linux";
    pkgs = pkgsFor system;
    pkgsFor = system: import nixpkgs {
			inherit system;
			overlays = [rust-overlay.overlays.default];
			config = {
				allowUnfree = true;
				# for godot android export
				android_sdk.accept_license = true;
			};
		};
  in {
    # Development environment to keep this codebase clean
    formatter.${system} = pkgs.alejandra;
    devShells.${system}.default = pkgs.mkShellNoCC {
      buildInputs = with pkgs; [
        deadnix # Scan Nix files for dead code
        statix # Analyze and provide linting + suggestions for Nix
      ];
    };

    # NixOS configurations
    nixosConfigurations = {
			linda = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [
					./hosts/linda/configuration.nix
					inputs.home-manager.nixosModules.default
					inputs.nix-flatpak.nixosModules.nix-flatpak
					inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
				];
			};
			yurania = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs pkgs;};
				modules = [
					./hosts/yurania/configuration.nix
					inputs.home-manager.nixosModules.default
					inputs.nix-flatpak.nixosModules.nix-flatpak
				];
			};
		};
  };
}
