{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./stremio.nix {
  config = {
    home.packages = with pkgs; [ stremio-linux-shell ];
  };
}
