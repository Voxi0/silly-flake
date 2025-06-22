{ inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../../modules/home/yurania.nix
  ];

  # Let Home Manager install and manage itself
  programs.home-manager = {
    enable = true;
    # backupFileExtension = "backup";
  };

  # Home
  home = {
    # User information
    username = "lucy";
    homeDirectory = "/home/lucy";

    # Environment variables to always set at login
    sessionVariables.EDITOR = "codium";

    # User packages
    packages = with pkgs; [
      # CLI utilities
      vim
      wget
      fastfetch
      btop
      caligula
      unrar-free

      # Development
      # cargo rustfmt rustc
      (rust-bin.stable.latest.default.override {
        extensions = [ "rust-src" ];
      })
      gcc # Needed to compile rust
      docker docker-compose
      direnv
      nix-direnv

      pkg-config # Idk cargo-mobile2 needs it

      # GUI but not a Flatpak
      mission-center
      vlc
      kdePackages.dolphin
      blockbench
      gedit
      kdePackages.ktorrent
      clamtk
      ckan
      blender
      libresprite
      kdePackages.kdenlive
      nexusmods-app
      bottles
      protontricks
      
      # hyprland stuff
      rofi
      hyprpaper
      grimblast # screenshot
      gparted
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
