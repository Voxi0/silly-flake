{
  config,
  pkgs,
  ...
}: {
  mainBar = with config.colorScheme.palette; {
    layer = "top";
    position = "top";
    height = 30;
    output = [
      "DVI-D-1"
      "HDMI-A-1"
    ];
    modules-left = [
      /*
      "wlr/workspaces"
      */
      /*
      "sway/mode"
      */
      "wlr/taskbar"
    ];
    modules-center = ["sway/window" "custom/hello-from-waybar"];
    modules-right = ["tray"];

    "sway/workspaces" = {
      disable-scroll = false;
      all-outputs = true;
    };

    "wlr/taskbar" = {
      on-click = "activate"; # IDK works sometimes?
      on-click-middle = "minimize";
    };

    "custom/hello-from-waybar" = {
      format = "hello {}";
      max-length = 90;
      interval = "once";
      exec = pkgs.writeShellScript "hello-from-waybar" ''
        date
      '';
    };
  };
}
