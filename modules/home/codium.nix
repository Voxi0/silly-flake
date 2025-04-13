{ lib, config, pkgs, ... }: 
{
  # Module options
  options.lucy-codium.enable = lib.mkEnableOption "Enable Lucy's Codium";

  # Configuration - Enable and configure VSCodium
  config = {
    programs.vscode = {
      package = pkgs.vscodium;
      enable = true;
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        rust-lang.rust-analyzer
        pkief.material-icon-theme
        vadimcn.vscode-lldb
        tekumara.typos-vscode
        t3dotgg.vsc-material-theme-but-i-wont-sue-you # I just liked the theme and this gives it back to me
      ];
    };
  };
}
