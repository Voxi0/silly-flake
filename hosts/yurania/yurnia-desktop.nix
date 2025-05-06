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
      
      xdg.portal = { enable = true; extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; }; 

      environment.systemPackages = with pkgs; [
        inputs.hyprswitch.packages.x86_64-linux.default
      ];
    })

    (lib.mkIf config.desktop.plasma.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    })
  ];
}