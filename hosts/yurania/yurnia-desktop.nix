# yurania is the desktop
{ config, lib, desktop, pkgs, inputs, ... }: 
{
  config = lib.mkMerge [
    (lib.mkIf desktop.hyprland.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      
      environment.systemPackages = with pkgs; [
        inputs.hyprswitch.packages.x86_64-linux.default
      ];
    })

    (lib.mkIf desktop.plasma.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    })
  ];
}