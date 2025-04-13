{ inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../../modules/home
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Home
  home = {
    # User information
    username = "lucy";
    homeDirectory = "/home/lucy";

    # Environment variables to always set at login
    sessionVariables.EDITOR = "coium";

    # Shell aliases
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos#linda";
      c = "clear";
      t = "touch";

      # `alert` alias for long running commands - Use it like, `sleep 10; alert`
      alert = "notify-send --urgency=low -i \"$( [ $? = 0 ] && echo terminal || echo error )\" \"$(history | tail -n1 | sed -e 's/^\s*[0-9]\\+\\s*//;s/[;&|]\\s*alert$//')\"";

      # Useful aliases for `ls`
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
    };

    # User packages
    packages = with pkgs; [
      # CLI utilities
      vim wget git fastfetch
      
      # System tools
      sops

      # Development
      # cargo rustfmt rustc
      gcc                 # Needed to compile rust
      docker docker-compose

      # GUI but not a Flatpak
      vlc
    ];

    # Manage dotfiles
    file.".bashrc".source = ../../dotfiles/bashrc;

    # Don't change this value even if you update Home Manager
    stateVersion = "24.11";
  };

  # SOPS - Secrets provisioning for NixOS
  sops = {
    age.keyFile = "/home/lucy/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;

    # Secrets
    secrets = {
      "git/config_main".path = ".gitconfig";
      "git/config_work".path = ".gitconfig_work";
    };
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
}
