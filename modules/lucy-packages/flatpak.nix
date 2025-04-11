{ lib, config, pkgs, ... }:

let
	cfg = config.lucy-flatpak;
in
{
    options = {
        lucy-flatpak.enable
            = lib.mkEnableOption "enable lucy flatpak";
    };

    config = lib.mkIf cfg.enable {
        # Enable flatpak to all users and auto add flathub
        services.flatpak.enable = true;
        # https://github.com/gmodena/nix-flatpak?tab=readme-ov-file
        services.flatpak.packages = [
            "org.mapeditor.Tiled"
            "dev.vencord.Vesktop"
            "app.zen_browser.zen"
            "org.signal.Signal"
            "io.missioncenter.MissionCenter"
            "com.github.KRTirtho.Spotube"
        ];
    };
}
