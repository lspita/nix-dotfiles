{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nix-auth.nix {
  config = {
    home.packages = with pkgs; [ nix-auth ];
  };
}
