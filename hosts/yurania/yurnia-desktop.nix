# yurania is the desktop
{ config, lib, inputs, ... }: 
{
  config = lib.mkMerge [
    (lib.mkIf inputs.desktop.hyprland.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    })

    (lib.mkIf inputs.desktop.plasma.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    })
  ];
}