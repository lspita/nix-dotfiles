{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./plantuml.nix {
  config = {
    home.packages = with pkgs; [ plantuml ];
  };
}
