{ optional, desktop, ... }:
{
  # Import Nix modules
  imports = [
    ./codium.nix
    ./bash.nix
    ./git.nix

    ./hyprland/hyprland.nix
  ];
}
