{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.lucy-packages;
in {
  # Module options
  options.lucy-packages.enable = lib.mkEnableOption "Enable Lucy's Packages";

  # Configuration - Remove some Gnome packages
  config = lib.mkIf cfg.enable {
    # Remove some Gnome packages
    environment.gnome.excludePackages = with pkgs; [
      # gedit             # Text editor
      # file-roller       # Archive manager
      baobab # Disk usage analyzer
      cheese # Photo booth
      eog # Image viewer
      epiphany # Web browser
      simple-scan # Document scanner
      totem # Video player
      yelp # Help viewer
      evince # Document viewer
      geary # Email client
      seahorse # Password manager

      # These should be self explanatory
      # gnome-calculator
      # gnome-calendar
      # gnome-characters
      # gnome-clocks
      # gnome-font-viewer
      # gnome-screenshot
      gnome-contacts
      gnome-logs
      gnome-maps
      gnome-music
      gnome-photos
      gnome-system-monitor
      gnome-weather
      gnome-disk-utility
      gnome-connections
    ];
  };
}
