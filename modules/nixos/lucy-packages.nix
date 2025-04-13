{ lib, config, pkgs, ... }: let
  cfg = config.lucy-packages;
in {
  # Voxi0 -> I'll figure out how to simplify all this and move it somewhere more appropriate

  # Module options
  options.lucy-packages.enable = lib.mkEnableOption "Enable Lucy's Packages";

  # Configuration - Remove some Gnome packages
  config = lib.mkIf cfg.enable {
    # Remove some Gnome packages
    environment.gnome.excludePackages = with pkgs.gnome; [
      # gedit             # Text editor
      # file-roller       # Archive manager
      pkgs.baobab         # Disk usage analyzer
      pkgs.cheese         # Photo booth
      pkgs.eog            # Image viewer
      pkgs.epiphany       # Web browser
      pkgs.simple-scan    # Document scanner
      pkgs.totem          # Video player
      pkgs.yelp           # Help viewer
      pkgs.evince         # Document viewer
      pkgs.geary          # Email client
      pkgs.seahorse       # Password manager

      # These should be self explanatory
      # gnome-calculator
      # gnome-calendar
      # gnome-characters
      # gnome-clocks
      # gnome-font-viewer
      # gnome-screenshot
      pkgs.gnome-contacts
      pkgs.gnome-logs
      pkgs.gnome-maps
      pkgs.gnome-music
      pkgs.gnome-photos
      pkgs.gnome-system-monitor
      pkgs.gnome-weather
      pkgs.gnome-disk-utility
      pkgs.gnome-connections
    ];
  };
}
