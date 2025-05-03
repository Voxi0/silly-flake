{ lib, config, pkgs, ... }: 
{
  # Install hyprland
  wayland.windowManager.hyprland.enable = true; # enable Hyprland

  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland.settings = {
    # Apps / shortcuts
    "$terminal" = "ghostty";
    "$browser" = "flatpak run app.zen_browser.zen";
    "$files" = "dolphin";
    "$menu" = "rofi -show drun";
    "$scrot" = "grimblast copysave area";
    "$scrot-screen" = "grimblast copysave output";
    "$window-switch" = "hyprswitch gui --mod-key $mod --key $switch-key --max-switch-offset 9 --hide-active-window-border";

    # Keybinds
    "$mod" = "alt";
    "$switch-key" = "tab";
    bind =
      [
	      "$mod, T, exec, $terminal"
        #"$mod, D, exec, $browser"
        #"$mod, F, exec, $files"
        "$mod, Q, killactive"
        "$mod, D, exec, $menu"
        "$mod, $switch-key, exec, $window-switch"
        "$mod, M, exit"
        ", Print, exec, $scrot"
        "Shift, Print, exec, $scrot-screen"
      ];
    
    # Does this save the environment?
    env = 
      [
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_SIZE,24"

        "GTK_IM_MODULE,cedilla"
        "QT_IM_MODULE,cedilla"

        "GTK_THEME,ArchEVA-01"
      ];
    
    general = {
      gaps_in = 3;
      gaps_out = 6;

      border_size = 2;

      "col.active_border" = "rgba(2A233Dff)";
      "col.inactive_border" = "rgba(2A233Dff)";

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = true;

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;

      layout = "dwindle";
    };

    exec-once = [
      "waybar"
      "hyprpaper"
      "hyprctl dispatch workspace main"
      "hyprswitch init --show-title --size-factor 5.5 --workspaces-per-row 5  --custom-css ~/.config/hyprswitch/theme.css &"
    ];

    monitor = [
      "HDMI-A-1, 1920x1080, 0x0, 1"
      "DVI-D-1, 1920x1200, 1920x0, 1"
    ];

    workspace = [
      "name:main, monitor:HDMI-A-1"
      "name:browser, monitor:DVI-D-1"
      "name:comms, monitor:DVI-D-1"
    ];
  };
}
