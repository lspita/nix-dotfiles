{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./protonpass.nix {
  config = {
    home.packages = with pkgs; [ proton-pass ];
  };
}
