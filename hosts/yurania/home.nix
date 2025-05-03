{ inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../../modules/home/yurania.nix
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Hyprland
  programs.kitty.enable = true; # required for the default Hyprland config
  wayland.windowManager.hyprland.enable = true; # enable Hyprland

  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # Home
  home = {
    # User information
    username = "lucy";
    homeDirectory = "/home/lucy";

    # Environment variables to always set at login
    sessionVariables.EDITOR = "codium";

    # Shell aliases
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos#yurania";
    };

    # User packages
    packages = with pkgs; [
      # CLI utilities
      vim
      wget
      fastfetch
      btop

      # Development
      cargo rustfmt rustc
      gcc # Needed to compile rust
      docker docker-compose

      # GUI but not a Flatpak
      grimblast
      vlc
      kdePackages.dolphin
      

      # hyprland stuff
      rofi
      hyprpaper
    ];

    # Manage dotfiles
    file = {
      ".config/btop/themes/archeva-01.theme".source = ../../dotfiles/archeva-01-dotfiles/archeva-01.theme;
      "bin".source = ../../bin;
    };

    # Don't change this value even if you update Home Manager
    stateVersion = "24.11";
  };

  # X Desktop Group (XDG)
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/about" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/unknown" = "app.zen_browser.zen.desktop";
    };
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
