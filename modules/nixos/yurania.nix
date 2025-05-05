_: {
  # Import Nix modules
  imports = [
    ./lucy-packages.nix ./flatpak.nix ./steam.nix ./python.nix
  ];
}
