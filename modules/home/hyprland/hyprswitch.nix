{ lib, config, pkgs, ... }: 
{
    # packages.pkgs.rofi

    home.file.".config/hyprswitch/theme.css".text = ''
        :root {
            --border-color: rgba(90, 90, 120, 0.4);
            --border-color-active: rgba(201, 9, 239, 0.9);
            --bg-color: rgba(20, 20, 20, 1);
            --bg-color-hover: rgba(40, 40, 50, 1);
            --index-border-color: rgba(98, 1, 163, 0.7);
            --border-radius: 12px;
            --border-size: 3px;
        }
    '';   
}