{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./devcontainer.nix {
  config = {
    home.packages = with pkgs; [ devcontainer ];
  };
}
