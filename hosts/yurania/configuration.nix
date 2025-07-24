# yurania is the desktop
{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./yurnia-desktop.nix
    ./options.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/yurania.nix
    inputs.home-manager.nixosModules.default
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix-command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Kernel modules
  boot.initrd.kernelModules = ["amdgpu"];

  services.xserver.videoDrivers = ["amdgpu"];

  networking.hostName = "yurania"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Tailscale
  services.tailscale.enable = true;
  # Enable tailscale fs
  services.davfs2.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lucy = {
    isNormalUser = true;
    description = "lucy";
    extraGroups = ["networkmanager" "wheel" "kvm" "libvirtd" "docker" "audio"];
    packages = with pkgs; [];
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Docker and podman setup
  # virtualisation.docker.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Enable packages, Flatpak and VSCodium
  lucy-packages.enable = true;
  lucy-flatpak.enable = true;

  programs.dconf.enable = true;

  # Setup sddm
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.xserver.displayManager.sddm.theme
  services.desktopManager.plasma6.enable = true;

  # cpu!
  powerManagement.cpuFreqGovernor = "performance";

  # Audio - Pipewire
  services.pulseaudio.enable = false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 2048;
        "default.clock.min-quantum" = 1024;
        "default.clock.max-quantum" = 2048;
      };
    };
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs.bash.completion.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    ghostty
    pavucontrol
    lutris
    wineWowPackages.stable
    winetricks
    qpwgraph
    mono
    sshfs
    waypipe # ssh -X like

    weylus # use linda as a drawing tablet

    ns-usbloader # Install homebrew onto a switch / custom apps

    # godot stuff
    godot
    # for godot android export
    # android-studio
    # android-tools
    # androidenv.androidPkgs.androidsdk
    # androidenv.androidPkgs.emulator
    # androidenv.androidPkgs.ndk-bundle
    # jdk # Java
  ];

  # Home manager
  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [inputs.sops-nix.homeManagerModules.sops];
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "bak-again25";
    # Users
    users.lucy = {
      imports = [./home.nix];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # To run linux bins for other distros
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXext
    xorg.libXrandr
    xorg.libXrender
    xorg.libX11
    xorg.libXi
    libGL
    alsa-lib
  ];

  # List services that you want to enable:

  services.ratbagd.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [41022];
    settings = {
      PasswordAuthentication = false;
      X11Forwarding = false;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [47984 47989 47990 48010];
    allowedUDPPortRanges = [
      {
        from = 47998;
        to = 48000;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
