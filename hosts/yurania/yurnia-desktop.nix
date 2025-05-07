# yurania is the desktop
{ config, lib, pkgs, inputs, ... }: 
{
  imports = [
    ./options.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf config.desktop.hyprland.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      }; 

      environment.systemPackages = with pkgs; [
        inputs.hyprswitch.packages.x86_64-linux.default
      ];

      # Setup sddm
      services.xserver.enable = true;
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;
      # services.xserver.displayManager.sddm.theme 
    })

    (lib.mkIf config.desktop.plasma.enable {
      # Setup sddm
      services.xserver.enable = true;
      services.displayManager.sddm.enable = true;
      # services.displayManager.sddm.wayland.enable = true;
      # services.xserver.displayManager.sddm.theme 
      services.desktopManager.plasma6.enable = true;

      qt = {
        enable = true;
        platformTheme = "gnome";
        style = "adwaita-dark";
      };
    })
  ];
}