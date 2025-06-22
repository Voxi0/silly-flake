{ optional, desktop, ... }:
{
  # Import Nix modules
  imports = [
    ./codium.nix
    ./bash.nix
    ./git.nix
    ./silly-fetch-config.nix

    ./hyprland/hyprland.nix
  ];
}
