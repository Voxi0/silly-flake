{ lib, config, pkgs, ... }:

let
	cfg = config.lucy-packages;
in
{
    options = {
        lucy-packages.enable
            = lib.mkEnableOption "enable lucy packages";
    };

    config = lib.mkIf cfg.enable {
        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
            # Cli utils
            vim
            wget
            git
            fastfetch
            # System tools
            sops
            # Development
            # cargo
            # rustfmt
            # rustc

            gcc # Needed to compile rust

            docker
            docker-compose

            # Gui but not a flatpak
            vlc
        ];

        # Remove some gnome packages
        environment.gnome.excludePackages = with pkgs.gnome; [
        pkgs.baobab      # disk usage analyzer
        pkgs.cheese      # photo booth
        pkgs.eog         # image viewer
        pkgs.epiphany    # web browser
        # gedit       # text editor
        pkgs.simple-scan # document scanner
        pkgs.totem       # video player
        pkgs.yelp        # help viewer
        pkgs.evince      # document viewer
        # file-roller # archive manager
        pkgs.geary       # email client
        pkgs.seahorse    # password manager

        # these should be self explanatory
        # gnome-calculator
        # gnome-calendar
        # gnome-characters
        # gnome-clocks 
        pkgs.gnome-contacts
        # gnome-font-viewer 
        pkgs.gnome-logs 
        pkgs.gnome-maps 
        pkgs.gnome-music 
        pkgs.gnome-photos 
        # gnome-screenshot
        pkgs.gnome-system-monitor 
        pkgs.gnome-weather 
        pkgs.gnome-disk-utility 
        pkgs.gnome-connections
  ];
    };
}
