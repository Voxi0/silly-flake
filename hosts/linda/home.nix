{ config, pkgs, inputs, ... }: {
  # Import Nix modules
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Home
  home = {
    # User information
    username = "lucy";
    homeDirectory = "/home/lucy";

    # Environment variables to always set at login
    sessionVariables.EDITOR = "coium";

    # User packages
    packages = [];

    # Manage dotfiles
    file = {
      ".bashrc".source = ../../dotfiles/bashrc;
      ".bash_aliases".source = ../../dotfiles/bash_aliases;
      "bin".source = ../../bin;
    };

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
