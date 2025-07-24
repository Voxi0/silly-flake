{
  pkgs,
  lib,
  config,
  # inputs,
  ...
}:
with lib; let
  settings = import ./config.nix {inherit lib config pkgs;};
  style = import ./style.nix {inherit config;};
in {
  programs.waybar = {
    inherit settings style;
    enable = true;
    # package = inputs.waybar.packages.${pkgs.system}.waybar;
  };
}
