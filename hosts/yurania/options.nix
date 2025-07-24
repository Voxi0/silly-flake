{lib, ...}: {
  options = {
    # What desktop to use
    desktop = {
      # These will not work on all systems
      hyprland.enable = lib.mkEnableOption {
        default = false;
      };
      plasma.enable = lib.mkEnableOption {
        default = true;
      };
      # gnome.enable = false; # Dummy
    };
  };
}
