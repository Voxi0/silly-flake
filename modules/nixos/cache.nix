{ inputs, pkgs, ... }: {
    nix = {
    settings = {
      substituters = [
        #"http://binarycache.example.com"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        #"binarycache.example.com-1:dsafdafDFW123fdasfa123124FADSAD"
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}