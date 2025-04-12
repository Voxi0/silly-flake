{ config, lib, pkgs, modulesPath, ... }: {
  # Import Nix modules
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Nixpkgs
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  # Hardware
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Boot
  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
      luks.devices."luks-bdcf371c-70c7-41f0-8bc0-4494cf5849e8".device = "/dev/disk/by-uuid/bdcf371c-70c7-41f0-8bc0-4494cf5849e8";
    }
  };

  # Filesystems
  fileSystems = {
    # Boot
    "/boot" = {
      device = "/dev/disk/by-uuid/1154-325A";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    # Root
    "/" = {
      device = "/dev/disk/by-uuid/5f31d81b-bda4-4cf0-8f47-8245ad208aab";
      fsType = "ext4";
    };
  };

  # Swap (Virtual memory)
  swapDevices = [
    { device = "/dev/disk/by-uuid/2bf7895b-c761-4289-8b56-d53e7e5d5b23"; }
  ];

  # Enable DHCP on each ethernet and wireless interface
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;
}
