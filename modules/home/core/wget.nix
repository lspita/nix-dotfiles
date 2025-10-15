{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./wget.nix {
  config = {
    home.packages = with pkgs; [ wget ];
  };
}
