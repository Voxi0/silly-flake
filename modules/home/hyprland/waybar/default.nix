{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: 
with lib; let
  cfg = import ./config.nix {inherit lib config pkgs;};
  style = import ./style.nix {inherit config;};
in {
    programs.waybar = {
        enable = true;
        # package = inputs.waybar.packages.${pkgs.system}.waybar;
        settings = cfg;
        style = style;
    };
}