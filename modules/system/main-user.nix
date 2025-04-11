{ lib, config, pkgs, ... }:

let
    cfg = config.main-user;
in
{
    options.main-user = {
        enable
            = lib.mkEnableOption "enable user module";
        
        userName = lib.mkOption {
            default = "mainuser";
            description = ''
                username
            '';
        };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    config = lib.mkIf cfg.enable {
        users.users.${cfg.userName} = {
            isNormalUser = true;
            description = cfg.userName;
            extraGroups = [ "networkmanager" "wheel" ];
            shell = pkgs.bash;
        };
    };
}