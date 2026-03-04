{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./hoppscotch.nix {
  config = {
    home.packages = with pkgs; [ hoppscotch ];
  };
}
