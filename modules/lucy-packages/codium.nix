{ lib, config, pkgs, ... }:

let
	cfg = config.lucy-codium;
in
{
    options = {
        lucy-codium.enable
            = lib.mkEnableOption "enable lucy's codium";
    };

    config = lib.mkIf cfg.enable {
        # more at: https://nixos.wiki/wiki/VSCodium
        environment.systemPackages = with pkgs; [
            (vscode-with-extensions.override {
                vscode = vscodium;
                vscodeExtensions = with vscode-extensions; [
                bbenoist.nix
                rust-lang.rust-analyzer
                pkief.material-icon-theme
                vadimcn.vscode-lldb
                tekumara.typos-vscode
                # t3dotgg.vsc-material-theme-but-i-wont-sue-you # I just liked the theme and this gives it back to me
                ];
            })
        ];

    };
}
