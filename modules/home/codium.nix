{ lib, config, pkgs, ... }: 
{
  # Module options
  options.lucy-codium.enable = lib.mkEnableOption "Enable Lucy's Codium";

  # Configuration - Enable and configure VSCodium
  config = {
    programs.vscode = {
      package = pkgs.vscodium.fhsWithPackages (ps: with ps; [ 
            cargo rustfmt rustc rustup
            gcc
            
            pkg-config
            alsa-lib
            vulkan-loader
            vulkan-tools
            vulkan-headers
            libxkbcommon
            wayland
            xorg.libX11
            xorg.libXcursor
            xorg.libXi
            xorg.libXrandr
            mesa
            udev
            clang
            lld 
          ]);
      enable = true;
      profiles.default = {
        enableUpdateCheck = true;
        enableExtensionUpdateCheck = true;
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          rust-lang.rust-analyzer
          pkief.material-icon-theme
          vadimcn.vscode-lldb
          tekumara.typos-vscode
          tamasfe.even-better-toml
          mkhl.direnv
          # Won't build if included? t3dotgg.vsc-material-theme-but-i-wont-sue-you # I just liked the theme and this gives it back to me
          # kylinideteam.kylin-python
        ];
      };
    };
  };
}
