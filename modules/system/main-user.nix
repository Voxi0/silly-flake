{ lib, config, pkgs, ... }: let
    cfg = config.main-user;
in {
    # Module options
    options.main-user = {
        enable = lib.mkEnableOption "Enable user module";
        userName = lib.mkOption {
            default = "mainuser";
            description = "username";
        };
    };

    # Configuration
    config = lib.mkIf cfg.enable {
        # Define a user account - Don't forget to set a password with ‘passwd’
        users.users.${cfg.userName} = {
            isNormalUser = true;
            description = cfg.userName;
            extraGroups = [ "networkmanager" "wheel" ];
            shell = pkgs.bash;
        };
    };
}
