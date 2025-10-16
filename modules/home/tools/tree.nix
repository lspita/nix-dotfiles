{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./tree.nix {
  config = {
    home.packages = with pkgs; [ tree ];
  };
}
