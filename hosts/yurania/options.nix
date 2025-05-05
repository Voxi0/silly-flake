{ ... }:
{
  options = {
    # What desktop to use
    desktop = { # These will not work on all systems
      hyprland.enable = lib.mkEnableOption {
        default = true;
      };
      plasma.enable = lib.mkEnableOption {
        default = false;
      };
      # gnome.enable = false; # Dummy
    };
  };
}