{ inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/system
    ../../modules/lucy-packages
    inputs.home-manager.nixosModules.default
    inputs.sops-nix.nixosModules.sops
  ];

  # Nix / Nixpkgs
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Virtual console and boot
  console.keyMap = "us";
  boot = {
    initrd.luks.devices."luks-1fa23410-0aea-499d-84ed-766344681c40".device = "/dev/disk/by-uuid/1fa23410-0aea-499d-84ed-766344681c40";
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  }

  # Timezone and internationalisation properties
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  # Networking
  networking = {
    hostName = "linda";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # Services
  services = {
    # Enable touchpad support - Enabled by default in most desktop managers
    # services.xserver.libinput.enable = true;

    # Additional
    printing.enable = false;
    openssh.enable = true;

    # X11
    xserver = {
      enable = true;

      # Gnome display manager and desktop environment
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Keymap
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Audio - Pipewire
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
      # jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  # Enable packages, Flatpak and VSCodium
  lucy-packages.enable = true;
  lucy-flatpak.enable = true;
  lucy-codium.enable = true;

  # Main user
  main-user = {
    enable = true;
    userName = "lucy";
  };

  # Home manager
  home-manager = {
    sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
    extraSpecialArgs = { inherit inputs; };
    users = {
      "lucy" = import ./home.nix;
    };
  };

  # SOPS - Secrets provisioning for NixOS
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/lucy/.config/sops/age/keys.txt";
  };

  # Programs
  programs = {
    firefox.enable = false;

    # SUID wrappers
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Perfectly fine and recommended to leave this value as is
  system.stateVersion = "24.11";
}
