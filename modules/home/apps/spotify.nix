{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./spotify.nix {
  config = {
    home.packages = with pkgs; [ spotify ];
  };
}
